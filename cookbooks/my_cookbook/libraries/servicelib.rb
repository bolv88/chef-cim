class Chef::Recipe
  class ServiceLib
    #得到node中前缀是pre的ip
    def self.getNodeIp node, pre="192."
      
      node.network.interfaces.each{|eth_name, info|
        #Chef::Log.info("info1: #{info}")
        info.addresses.each{|ip, ipsinfos|
            return ip if ip.start_with? pre
        }
      }

      reutrn "127.0.0.1"
    end
    def self.enableService command_pre
      service_status = Mixlib::ShellOut.new("#{command_pre} status")
      service_status.run_command

      Chef::Log.info("\e[1;36m #{command_pre} checking .... #{service_status.stdout} \e[0m")
      return true if (service_status.stdout.index "running") != nil and (service_status.stdout.index "not running") == nil

      run_service = Mixlib::ShellOut.new("#{command_pre} start")
      run_service.run_command
      Chef::Log.info("\e[1;36m #{command_pre} start \e[0m")
    end

  end
end
