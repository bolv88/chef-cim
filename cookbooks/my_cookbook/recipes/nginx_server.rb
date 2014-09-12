yum_package "nginx"
file '/etc/nginx/conf.d/default.conf' do
  content  <<-EOS
    #set black by chef
  EOS
  notifies :run, 'execute[nginx_config_change]'
end

ip_pre = node['my_cookbook']['inner_ip_pre']
listen_ip = getNodeIp node,ip_pre

template '/etc/nginx/conf.d/virtual.conf' do
  source "nginx_config_virtual.erb"
  variables(
    listen_ip: listen_ip,
    listen_port: node['my_cookbook']['web_server_port'],
    from: node['fqdn']
  )
  notifies :run, 'execute[nginx_config_change]'
end

execute "nginx_config_change" do
  command '/etc/init.d/nginx reload'
  action :nothing
end

#remote dir
remote_directory "/etc/nginx/sites-enabled/" do
  source "empty_dir"
end

enableService "/etc/init.d/nginx"
