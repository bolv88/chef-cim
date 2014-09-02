log_level                :info
log_location             STDOUT
node_name                'yubo'
client_key               '/root/chef-cim/yubo.pem'
validation_client_name   'chef-validator'
validation_key           '/root/.chef/chef-validator.pem'
chef_server_url          'https://server:443'
syntax_check_cache_path  '/root/vagrant_dir/chef-cim/syntax_check_cache'
cookbook_path [ './cookbooks' ]
