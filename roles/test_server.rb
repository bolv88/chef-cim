name "test_server"
description "test"
run_list "recipe[my_cookbook::user]" #, "recipe[ntp]"
default_attributes "ntp" => {"servers" => ["0.pool.ntp.org", "1.pool.ntp.org"]}




