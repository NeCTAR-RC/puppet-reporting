# Reporting pollster install and configuration
class reporting::pollster (
  $db_user,
  $db_pass,
  $db_host='localhost',
  $db_port='3306',
  $db_name,
  $source_db_user,
  $source_db_pass,
  $source_db_name,
  $source_db_host,
  $source_db_port='3306',
  $nova_user,
  $nova_pass,
  $keystone_auth_url,
  $pollster_tenant
) inherits reporting {

  package {'python-reporting-pollster':
    ensure => installed,
  }

  file {'/etc/reporting-pollster/reporting.conf':
    owner   => root,
    group   => root,
    mode    => '0600',
    content => template('reporting/reporting-pollster/reporting.conf.erb'),
    require => Package['python-reporting-pollster'],
  }
}

