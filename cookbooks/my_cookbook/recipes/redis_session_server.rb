
#include_recipe "build-essential::default"
#my_cookbook_install "redis-install" do
#  version '2.8.14'
#  download_url 'http://download.redis.io/releases/redis-2.8.14.tar.gz'
#  safe_install false
#  action :run
#end
#
#return

#get ip
ip_pre = node['my_cookbook']['inner_ip_pre']
listen_ip = getNodeIp node,ip_pre
#
redis_servers = node['redisio']['servers'].dup
redis_servers.each_with_index{|val, index|
  #node.default['redisio']['servers'][index]['address'] = listen_ip
  redis_servers[index]['port'] = node['my_cookbook']['redis_session_port']
  redis_servers[index]['address'] = listen_ip
}

#node.default['redisio']['bypass_setup'] = true
Chef::Log.info("pre ==================#{node['redisio']['servers']}")
node.default['redisio']['servers'] = redis_servers
Chef::Log.info("==================#{node.default['redisio']['servers']}")

include_recipe "redisio"

redisio_install "redis-installation" do
  version '2.8.14'
  download_url 'http://download.redis.io/releases/redis-2.8.14.tar.gz'
  safe_install false
end

#Chef::Log.info("redis servers : #{redis_servers}")
#
#redisio_configure "redis-servers" do
#  version '2.8.14'
#  default_settings node['redisio']['default_settings']
#  servers redis_servers
#  #servers node['redisio']['servers']
#  base_piddir node['redisio']['base_piddir']
#  action [:run]
#end

include_recipe "redisio::enable"
#node['redisio']['servers'].each{|server|
#  service "redis#{server['port']}" do
#    action [:restart]
#  end
#}

#设置iptables
ip_pre = node['my_cookbook']['inner_ip_pre']
server_nodes = search(:node, "role:web_server")
Chef::Log.info("ser nodes #{server_nodes}")
client_ips = []
server_nodes.each{|node|
  ip = getNodeIp node, ip_pre
  client_ips << ip if ip.start_with? ip_pre
}

execute "iptables_change" do
  command <<-EOS
  /etc/init.d/iptables stop
  /etc/init.d/iptables start
  EOS
  action :nothing
end
template "/etc/sysconfig/iptables" do
    source "iptables.erb"
    variables(
        web_server_ips: client_ips,
        session_redis_port: node['my_cookbook']['redis_session_port'],
    )
    notifies :run, 'execute[iptables_change]'
end

enableService "/etc/init.d/iptables"
