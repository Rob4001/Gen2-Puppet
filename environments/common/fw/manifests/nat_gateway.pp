class fw::nat_gateway(){

  #Insure Interfaces Setup
#  network::interface{ 'eth0':
#    address => 192.168.1.1,
#    network => "192.168.1.0",
#    broadcast => "192.168.1.255",
#  }
#  network::interface{ 'eth1':
#    address => 192.168.1.1,
#    network => "192.168.1.0",
#    broadcast => "192.168.1.255",
#  }

  #General NAT for internal network internet
  # /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
  firewall { '100 nat for internal network':
  chain    => 'POSTROUTING',
  jump     => 'MASQUERADE',
  proto    => 'all',
  outiface => "eth0",
  source   => '10.0.0.0/8',
  table    => 'nat',
  }
  
  # /sbin/iptables -A FORWARD -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT
  firewall { '101 allow inbound nat for internal network':
  chain    => 'FORWARD',
  iniface     => 'eth0',
  outiface    => 'eth1',
  state => ['RELATED', 'ESTABLISHED'],
  action   => 'accept',
  }
  
  
  # /sbin/iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
  firewall { '101 allow outbound nat for internal network':
  chain    => 'FORWARD',
  iniface     => 'eth1',
  outiface    => 'eth0',
  action   => 'accept',
  }
  
  #Add all 1:1 NAT and port forwarding
  Firewall <<|table="nat"|>>
}