#
# Cookbook Name:: my_cookbook
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#yum install, uis for php54
include_recipe "yum"
yum_repository "ius" do
  description 'ius'
  mirrorlist 'http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el6&arch=$basearch'
  gpgkey 'http://mirror.its.dal.ca/ius/IUS-COMMUNITY-GPG-KEY'
  action :create
end

#package "libcurl"
#package "libcurl-devel"
#php
yum_package "php54"
yum_package "php54-pdo"
yum_package "php54-common"
yum_package "php54-cli"
yum_package "php54-gd"
yum_package "php54-mysql"
yum_package "php54-mcrypt"

package_fpm = yum_package "php54-fpm"  do
    action :nothing
end
package_fpm.run_action(:install)
Chef::Log.info("after php-fpm run")

ruby_block "enable php-fpm" do
  block do
    #start service
    ServiceLib.enableService "/etc/init.d/php-fpm"
  end
  action :create
end

#nginx
include_recipe "my_cookbook::nginx_server"

#users, sudo, need data bag
include_recipe "users"
users_manage "staff" do
  group_id 999
  action [:create]
end
#sudo
#node.default['openssh']['server']['listen_address'] = '192.168.1.1'
#node.default['openssh']['server']['port'] = '6222'
#
#node.default['openssh']['server']['permit_root_login'] = "no"
#node.default['openssh']['server']['password_authentication'] = "no"
node.default['authorization']['sudo']['passwordless'] = true
node.default['authorization']['sudo']['groups'] = ['staff']
include_recipe 'sudo'

#ntp
include_recipe 'ntp'
#include_recipe 'ntp::undo'

#node.default['varnish']['backend_port'] = '80'
#include_recipe 'varnish'


#yum_package "haproxy"
#include_recipe "my_cookbook::haproxy_config"

#include_recipe "my_cookbook::redis"

#node.default['haproxy']['httpchk'] = true
#node.default['haproxy']['x_forwarded_for'] = true
#node.default['haproxy']['app_server_role'] = "web_servers"
#node.default['haproxy']['incoming_port'] = 80
#node.default['haproxy']['member_port'] = 8081
#include_recipe "haproxy::app_lb"


