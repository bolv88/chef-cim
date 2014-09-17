module MyCookbook
  module Helpers
    def getInnerIps search_param
      ip_pre = node['my_cookbook']['inner_ip_pre']
      server_nodes = self::search(:node, search_param)
      Chef::Log.info("ser nodes #{server_nodes}")
      client_ips = []
      server_nodes.each{|node|
        ip = getNodeIp node, ip_pre
        client_ips << ip if ip.start_with? ip_pre
      }
      client_ips.sort!
    end
  end
end
