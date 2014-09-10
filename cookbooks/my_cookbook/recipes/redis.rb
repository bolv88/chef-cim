redis_servers = [{"port" => 10000}, {"port" => 10001}]
Chef::Log.info("redis servers  pre: #{redis_servers}")
Chef::Log.info("redis servers  install dir: #{node['redisio']['install_dir']}")
Chef::Log.info("redis servers  default_settings: #{node['redisio']['default_settings']}")

node['redisio'].override_attributes({'servers' => redis_servers})
Chef::Log.info("redis servers : #{node['redisio']['servers']}")
include_recipe "redisio"


#get ip
ip_pre = "10."
listen_ip = getNodeIp node,ip_pre

redis_servers.each_with_index{|val, index|
  #node.default['redisio']['servers'][index]['address'] = listen_ip
  redis_servers[index]['address'] = listen_ip
}
Chef::Log.info("redis servers : #{redis_servers}")

redisio_install "redis-installation" do
  version '2.8.14'
  download_url 'http://download.redis.io/releases/redis-2.8.14.tar.gz'
  safe_install false
  install_dir '/data/software1'
end


redisio_configure "redis-servers" do
  version '2.8.14'
  default_settings node['redisio']['default_settings']
  #servers redis_servers
  servers node['redisio']['servers']
  base_piddir node['redisio']['base_piddir']
end

include_recipe "redisio::enable"
