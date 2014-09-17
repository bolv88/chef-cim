#
# Cookbook Name:: my_cookbook
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# common settings like sysctl
#
# sysctl
net = {}
net['ipv4'] = {}
net['core'] = {}
#port range
net['ipv4']['ip_local_port_range'] = "10000 61000"

# increase TCP max buffer size settable using setsockopt()
net['core']['rmem_max'] = 16777216 
net['core']['wmem_max'] = 16777216 


# increase Linux autotuning TCP buffer limit 
net['ipv4']['tcp_rmem'] = "4096 87380 16777216"
net['ipv4']['tcp_wmem'] = "4096 65536 16777216"

# increase the length of the processor input queue
net['core']['netdev_max_backlog'] = 30000

# recommended default congestion control is htcp 
net['ipv4']['tcp_congestion_control']="htcp"

# recommended for hosts with jumbo frames enabled
net['ipv4']['tcp_mtu_probing']=1

#默认60，tcp fin状态超时时间 
net['ipv4']['tcp_fin_timeout'] = 10

#tcp重用
net['ipv4']['tcp_tw_reuse'] = 1
#打开可能回引发一些奇怪的问题
net['ipv4']['tcp_tw_recycle'] = 0
net['ipv4']['tcp_syncookies']=0

net['ipv4']['tcp_no_metrics_save']=1

#listen()的默认参数,挂起请求的最大数量.默认是128.对繁忙的服务器,增加该值有助于网络性能.可调整到256.
net['core']['somaxconn'] = 1024

#系统所能处理不属于任何进程的TCP sockets最大数量。假如超过这个数量﹐那么不属于任何进程的连接会被立即reset，并同时显示警告信息。之所以要设定这个限制﹐纯粹为了抵御那些简单的 DoS 攻击﹐千万不要依赖这个或是人为的降低这个限制(这个值Redhat AS版本中设置为32768,但是很多防火墙修改的时候,建议该值修改为2000)
net['ipv4']['tcp_max_orphans'] = 262144

#对于那些依然还未获得客户端确认的连接请求﹐需要保存在队列中最大数目。对于超过 128Mb 内存的系统﹐默认值是1024 ﹐低于 128Mb 的则为 128。如果服务器经常出现过载﹐可以尝试增加这个数字。警告﹗假如您将此值设为大于1024﹐最好修改 include/net/tcp.h 里面的 TCP_SYNQ_HSIZE ﹐以保持TCP_SYNQ_HSIZE*16<=tcp_max_syn_backlog ﹐并且编进核心之内。(SYN Flood攻击利用TCP协议散布握手的缺陷，伪造虚假源IP地址发送大量TCP-SYN半打开连接到目标系统，最终导致目标系统Socket队列资源耗尽而无法接受新的连接。为了应付这种攻击，现代Unix系统中普遍采用多连接队列处理的方式来缓冲(而不是解决)这种攻击，是用一个基本队列处理正常的完全连接应用(Connect()和Accept() )，是用另一个队列单独存放半打开连接。这种双队列处理方式和其他一些系统内核措施(例如Syn-Cookies/Caches)联合应用时，能够比较有效的缓解小规模的SYN Flood攻击(事实证明<1000p/s)加大SYN队列长度可以容纳更多等待连接的网络连接数，所以对Server来说可以考虑增大该值.)
net['ipv4']['tcp_max_syn_backlog'] = 262144

#受到攻击时可设置该值
#net['ipv4']['tcp_synack_retries = 2

net['ipv4']['tcp_syn_retries']=2

# net['ipv4']['tcp_keepalive_intvl = 75
# net['ipv4']['tcp_keepalive_probes = 9
# net['ipv4']['tcp_keepalive_time = 7200
# 意思是如果某个TCP连接在idle 7200秒（2个小时）后,内核才发起probe.如果probe 9次(每次75秒)不成功,内核才彻底放弃,认为该连接已失效
net['ipv4']['tcp_keepalive_time'] = 300
net['ipv4']['tcp_keepalive_intvl'] = 75
net['ipv4']['tcp_keepalive_probes'] = 9

params = {}
params['net'] = net
params['fs'] = {}
params['fs']['file-max'] = 6553560
node.default['sysctl']['params']=params

include_recipe 'sysctl::apply'



