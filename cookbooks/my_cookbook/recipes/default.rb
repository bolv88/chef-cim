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
#hehe
