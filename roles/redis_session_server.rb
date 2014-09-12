name "redis_session_server"
description "web session [redis]"
run_list "recipe[my_cookbook::redis_session_server]" #, "recipe[ntp]"
default_attributes "ntp" => {"servers" => ["0.pool.ntp.org", "1.pool.ntp.org"]},
                   "redisio" => {
                     'install_dir' => '/data0/soft', #important
                      #'bypass_setup' => true,
                      'default_settings' => {'datadir' => '/data0/redis-data'},
                      'servers' => [
                        {
                        }
                        
                    ]
                  }
