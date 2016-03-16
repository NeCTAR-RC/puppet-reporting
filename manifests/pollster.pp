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
  $keystone_db_name='keystone',
  $nova_db_name='nova',
  $glance_db_name='glance',
  $cinder_db_name='cinder',
  $rcshibboleth_db_name='rcshibboleth',
  $nova_user,
  $nova_pass,
  $keystone_auth_url,
  $pollster_tenant
) inherits reporting {

  package {'python-reporting-pollster':
    ensure => installed,
  }

  package {'mariadb-client':
    ensure => installed,
  }

  file {'/etc/reporting-pollster/reporting.conf':
    owner   => root,
    group   => root,
    mode    => '0600',
    content => template('reporting/reporting-pollster/reporting.conf.erb'),
    require => Package['python-reporting-pollster'],
  }

  exec { 'reporting-db-sync run':
    command => "/usr/bin/reporting-db-sync --db-name=${db_name} --db-user=${db_user} --db-pass=${db_pass} --db-host=${db_host} --db-port=${db_port} --schema=/usr/share/doc/python-reporting-pollster/reporting_schema_nectar.sql.gz && touch /etc/reporting/reporting-db-sync.done",
    creates => '/etc/reporting-pollster/reporting-db-sync.done',
    require => Package['mariadb-client'],
  }
}

