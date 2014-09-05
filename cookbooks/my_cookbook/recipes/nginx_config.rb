file '/etc/nginx/conf.d/default.conf' do
  content  <<-EOS
    #set black by chef
  EOS
  notifies :run, 'bash[run_on_nginx_config_change]'
end

ip_pre = "10."
listen_ip = getNodeIp node,ip_pre

server_nodes = search(:node, "role:web_servers")
Chef::Log.info("ser nodes #{server_nodes}")
client_ips = []
server_nodes.each{|node|
  ip = getNodeIp node, ip_pre
  client_ips << ip if ip.start_with? ip_pre
}
Chef::Log.info("client ips #{client_ips}")


template '/etc/nginx/conf.d/virtual.conf' do
  source "nginx_config_virtual.erb"
  variables(
    listen_ip: listen_ip,
    client_ips: client_ips,
    from: node['fqdn']
  )
  notifies :run, 'bash[run_on_nginx_config_change]'
end

bash "run_on_nginx_config_change" do
  code '/etc/init.d/nginx reload'
  action :nothing
end

#remote dir
remote_directory "/etc/nginx/sites-enabled/" do
  source "empty_dir"
end
