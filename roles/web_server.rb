name "web_server"
description "web server [nginx php]"
run_list "recipe[my_cookbook::web_server]", "recipe[my_cookbook]" #, "recipe[ntp]"
default_attributes "ntp" => {"servers" => ["0.pool.ntp.org", "1.pool.ntp.org"]}



