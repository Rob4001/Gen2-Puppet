# Empty site.pp required (puppet #15106, foreman #1708)
Package {
    provider => $operatingsystem ? {
        redhat => yum,
        centos => yum,
        debian => apt,
        Solaris => pkgutil,
    }
}
