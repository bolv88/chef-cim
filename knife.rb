current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "yubo"
client_key               "#{current_dir}/yubo.pem"
validation_client_name   "cim-validator"
validation_key           "#{current_dir}/cim-validator.pem"
chef_server_url          "https://chef-server/organizations/cim"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/cookbooks"]
