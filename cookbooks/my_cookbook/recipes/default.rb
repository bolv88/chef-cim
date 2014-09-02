#
# Cookbook Name:: my_cookbook
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
message = node['my_cookbook']['message']
Chef::Log.info("** Saying what I was told to say: #{message}")

template '/tmp/index.html' do
  source 'index.html.erb'
  variables(hi: 'hello', word: message, from: node['fqdn'])
end

capistrano_deploy_dirs "cap cim120 dirs" do
	deploy_to "/srv"
end

my_cookbook "Ohai" do
	title "Chef"
	action :remove
end

#yum install
include_recipe "yum"
yum_repository "ius" do
  description 'ius'
  mirrorlist 'http://dmirr.iuscommunity.org/mirrorlist?repo=ius-el6&arch=$basearch'
  gpgkey 'http://mirror.its.dal.ca/ius/IUS-COMMUNITY-GPG-KEY'
  action :create
end

#package "libcurl"
#package "libcurl-devel"
#yum_package "php54"

#remote dir
remote_directory "/tmp/111" do
	files_backup 10
	files_owner "root"
	files_group "root"
	files_mode 00644
	owner "root"
	group "root"
	mode 00755
end

#users
include_recipe "users"
users_manage "staff" do
  group_id 999
  action [:remove, :create]
  data_bag "users"
end

#hehe
