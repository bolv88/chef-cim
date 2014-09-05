class Chef::Recipe

  #得到node中前缀是pre的ip
  def getNodeIp node, pre="192."
    
    node.network.interfaces.each{|eth_name, info|
      Chef::Log.info("info1: #{info}")
      info.addresses.each{|ip, ipsinfos|
          return ip if ip.start_with? pre
      }
    }

    reutrn "127.0.0.1"
  end
end
