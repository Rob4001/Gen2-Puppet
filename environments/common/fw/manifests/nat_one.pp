class fw::nat_one(
$ip=false
){

  #Setup Interface
  $inter = regsubst($ip,'/.','/:')
  network::interface{ 'eth1:$inter':
    address => $ip,
    network => "130.159.141.0",
    broadcast => "130.159.141.127",
	netmask => "255.255.255.128",
	gateway => "130.159.141.127",
  }

  #iptables -t nat -I PREROUTING -d <$ip> -j DNAT --to-destination <this ip>
  firewall { "103 121 nat for $fdqn":
  chain    => 'PREROUTING',
  jump     => 'DNAT',
  todest    => '${ipaddress}',
  destination => '$ip',
  table    => 'nat',
  }
  
}