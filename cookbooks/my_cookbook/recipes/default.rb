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
#hehe
