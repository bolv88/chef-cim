name "web_servers"
description "This role contains nodes, which act as web servers"
run_list "recipe[my_cookbook]"
default_attributes "my_cookbook" => {"message" => "hehe from rule"}
#run_list "recipe[webserver]", "recipe[my_cookbook]"

