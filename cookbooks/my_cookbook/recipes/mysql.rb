include_recipe "yum"

yum_repo = yum_repository "Percona" do
  description 'Percona'
  baseurl 'http://repo.percona.com/centos/6/os/$basearch/'
  gpgkey 'http://www.percona.com/downloads/RPM-GPG-KEY-percona'
  action :nothing
end
yum_repo.run_action(:create)

packages = ["Percona-Server-devel-56", "Percona-Server-server-56", "percona-xtrabackup-21", "Percona-Server-client-56", "Percona-Server-shared-56"]
packages.each{|one|
  package1 = yum_package one do
    action :nothing
  end
  package1.run_action(:install)
}

#my.cnf
ip_pre = node['my_cookbook']['inner_ip_pre']
ip = getNodeIp node, ip_pre

require 'ipaddr'
ip_obj = IPAddr.new ip

execute "mysql_config_change" do
  command '/etc/init.d/mysql restart'
  action :nothing
end

template "/etc/my.cnf" do
  source "mysql.erb"
  variables(
    bind_address: ip,
    server_id: ip_obj.to_i,
    binlog_dbs: ['cim_public_user_0', 'cim_public_data_0']
  )
  notifies :run, 'execute[mysql_config_change]', :immediately
end


#start service
enableService "/etc/init.d/mysql"

#create database and users
server_nodes = search(:node, "role:web_server")
Chef::Log.info("ser nodes #{server_nodes}")
client_ips = []
server_nodes.each{|node|
  ip = getNodeIp node, ip_pre
  client_ips << ip if ip.start_with? ip_pre
}

#include_recipe "database::mysql"
connection_params = {
  :username => 'root',
  :host => 'localhost',
  :password => '',
  :socket => '/data0/mysql/mysql.sock'
}
databases = ['cim_public_user_0', 'cim_public_data_0']

chef_gem "mysql"

#databases.each{|db_name|
#  mysql_database db_name do
#    connection connection_params
#    encoding 'utf8'
#    action :drop
#  end
#}
mysql_database 'delete niming users' do
  connection connection_params
  database_name "mysql"
  sql "delete from mysql.user where User='';\ndelete from mysql.user where Host='#{node.name}';"
  action :query
end
databases.each{|db_name|
  mysql_database db_name do
    connection connection_params
    encoding 'utf8'
    action :create
  end
  client_ips.each{|web_server_ip|
    mysql_database_user 'web_server' do
      connection connection_params
      password 'web_server_pass'
      database_name db_name
      host web_server_ip
      #privileges [:select,:update,:insert]
      privileges [:all]
      #require_ssl true
      action :grant
    end
  }
}


