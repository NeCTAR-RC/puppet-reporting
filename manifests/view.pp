# Reporting view layer server install and configuration
#
# Note: port and external_port are split up this way because part of the
# config we're working with is internal (the apache config) and part of it is
# external (the stuff the browser deals with). Sometimes those two will have
# a mediating agent in between (a load balancer, most likely) and there's no
# guarantee that it'll be listening on the same port. So, we need to split the
# external port out into its own variable, and we likewise need to split the
# protocol part of the URL out (since the external mediator may be doing TLS
# termination).
class reporting::view (
  $host='localhost',
  $port=80,
  $external_port='',
  $proto='http',
  $path='',
  $admin_email='root@localhost',
  $api_host,
  $api_port,
  $api_proto='http',
  $rcshibboleth_url,
  $auth_role,
  $auth_url,
) inherits reporting {

  package {'reporting-view':
    ensure => installed,
  }

  file {'/etc/reporting-view/config.js':
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('reporting/reporting-view/config.js.erb'),
    require => Package['reporting-view'],
  }

  file {'/etc/reporting-view/reporting-view.conf':
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template('reporting/reporting-view/reporting-view.conf.erb'),
    require => Package['reporting-view'],
  }

}
