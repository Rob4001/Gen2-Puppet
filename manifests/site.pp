# Empty site.pp required (puppet #15106, foreman #1708)
Package {
    provider => $operatingsystem ? {
        redhat => yum,
        centos => yum,
        debian => apt,
        Solaris => pkgutil,
    }
}

# iptables purge
  resources { "firewall":
    purge   => true
  }

  Firewall {
    before  => Class['fw::post'],
    require => Class['fw::pre'],
  }

  class { ['fw::pre', 'fw::post']: }
