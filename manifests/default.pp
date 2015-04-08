include stdlib
include environment

class { ubuntu: stage => setup }

class {
    'apache': default_vhost => false;
}

apache::vhost { 'app.lh':
    port          => '80',
    docroot       => '/vagrant/web',
    docroot_owner => 'vagrant',
    docroot_group => 'vagrant',
}

include nodejs

exec { 'install less node module':
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    command => 'npm install -g less &> /dev/null',
    require => Class['nodejs'],
}

exec { 'install other node modules':
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    command => 'npm install -g grunt-cli coffee-script which rimraf nopt semver chalk mime lodash opn pretty-bytes tiny-lr-fork &> /dev/null',
    require => Class['nodejs'],
}

