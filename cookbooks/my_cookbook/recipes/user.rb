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
