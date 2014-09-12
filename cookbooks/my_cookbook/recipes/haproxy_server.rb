include_recipe "yum"
haproxy_package = yum_package "haproxy" do
    action :nothing
end
haproxy_package.run_action(:install)

ip_pre = node['my_cookbook']['inner_ip_pre']
server_nodes = search(:node, "role:web_server")
Chef::Log.info("ser nodes #{server_nodes}")
client_ips = []
server_nodes.each{|node|
  ip = getNodeIp node, ip_pre
  client_ips << ip if ip.start_with? ip_pre
}

Chef::Log.info("client ips #{client_ips}")

template '/etc/haproxy/haproxy.cfg' do
  source "haproxy_config.erb"
  variables(
    #listen_ip: listen_ip,
    client_ips: client_ips,
    back_port: node['my_cookbook']['web_server_port'],
    from: node['fqdn'],

    maxconn: 4000,

    main_listenport: 80
  )
  notifies :run, 'execute[haproxy_config_change]'
end

execute "haproxy_config_change" do
  command '/etc/init.d/haproxy reload'
  action :nothing
end

enableService "/etc/init.d/haproxy"

