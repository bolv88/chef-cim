ip_pre = "192."
server_nodes = search(:node, "role:web_servers")
Chef::Log.info("ser nodes #{server_nodes}")
client_ips = []
server_nodes.each{|node|
  ip = getNodeIp node, ip_pre
  client_ips << ip if ip.start_with? ip_pre
}

Chef::Log.info("client ips #{client_ips}")

bash "run_on_haproxy_config_change" do
  code '/etc/init.d/haproxy reload'
  action :nothing
end

template '/etc/haproxy/haproxy.cfg' do
  source "haproxy_config.erb"
  variables(
    #listen_ip: listen_ip,
    client_ips: client_ips,
    back_port: 8081,
    from: node['fqdn'],

    maxconn: 4000,
    main_listenport: 80

  )
  notifies :run, 'bash[run_on_haproxy_config_change]'
end

