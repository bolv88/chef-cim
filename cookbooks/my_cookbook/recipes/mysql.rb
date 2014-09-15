include_recipe "yum"

yum_repository "Percona" do
  description 'Percona'
  baseurl 'http://repo.percona.com/centos/6/os/$basearch/'
  gpgkey 'http://www.percona.com/downloads/RPM-GPG-KEY-percona'
  action :create
end

yum_package "Percona-Server-server-56"
yum_package "percona-xtrabackup-21"
yum_package "Percona-Server-client-56"
yum_package "Percona-Server-shared-56"

template "/etc/my.cnf" do
  source "mysql.erb"
  
  notifies :run, 'execute[mysql_config_change]'
end

execute "mysql_config_change" do
  command '/etc/init.d/mysql restart'
  action :nothing
end


