#
# Cookbook Name:: webserver
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package 'httpd'

service 'httpd' do
  action [:start, :enable]
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
end
