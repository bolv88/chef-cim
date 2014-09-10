name "web_servers"
description "This role contains nodes, which act as web servers"
run_list "recipe[my_cookbook]", "recipe[yum]" #, "recipe[ntp]"
default_attributes "my_cookbook" => {"message" => "hehe from rule"}, 
                   "ntp" => {"servers" => ["0.pool.ntp.org", "1.pool.ntp.org"]},
                   "redisio" => {
                     'install_dir' => '/data/software1', #important
                      'default_settings' => {'datadir' => '/data0/redis-data'},
                      'servers' => [
                        {
                          'port' => 11000
                        },
                        {
                          'port' => 11001
                        }
                        
                        ]
                  }
#run_list "recipe[webserver]", "recipe[my_cookbook]"

