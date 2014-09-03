name "web_servers"
description "This role contains nodes, which act as web servers"
run_list "recipe[my_cookbook]", "recipe[yum]" #, "recipe[ntp]"
default_attributes "my_cookbook" => {"message" => "hehe from rule"}, "ntp" => {"servers" => ["0.pool.ntp.org", "1.pool.ntp.org"]}
#run_list "recipe[webserver]", "recipe[my_cookbook]"

