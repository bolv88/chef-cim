#get ip
ip_pre = "10."
listen_ip = getNodeIp node,ip_pre
#
redis_servers = node['redisio']['servers'].dup
redis_servers.each_with_index{|val, index|
  #node.default['redisio']['servers'][index]['address'] = listen_ip
  redis_servers[index]['address'] = listen_ip
}

node.default['redisio']['servers'] = redis_servers
include_recipe "redisio"

redisio_install "redis-installation" do
  version '2.8.14'
  download_url 'http://download.redis.io/releases/redis-2.8.14.tar.gz'
  safe_install false
  install_dir '/data/software1'
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
