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
  $dashboard_db_name='dashboard',
  $nova_user,
  $nova_user_domain='Default',
  $nova_pass,
  $keystone_auth_url,
  $pollster_tenant,
  $pollster_project_domain='Default',
  $db_sync=false
) inherits reporting {

  ensure_packages(['python-reporting-pollster', 'mariadb-client'])

  service {'reporting-pollster':
    ensure    => running,
    require   => Package['python-reporting-pollster'],
    subscribe => File['/etc/reporting-pollster/reporting.conf'],
  }

  file {'/etc/reporting-pollster/reporting.conf':
    owner   => root,
    group   => root,
    mode    => '0600',
    content => template('reporting/reporting-pollster/reporting.conf.erb'),
    require => Package['python-reporting-pollster'],
  }

  if $db_sync {

    $done_file='/etc/reporting-pollster/reporting-db-sync.done'
    $schema_file='/usr/share/doc/python-reporting-pollster/reporting_schema_nectar.sql.gz'
    exec { 'reporting-db-sync run':
      command => "/usr/bin/reporting-db-sync --db-name=${db_name} --db-user=${db_user} --db-pass=${db_pass} --db-host=${db_host} --db-port=${db_port} --schema=${schema_file} && touch ${done_file}",
      creates => $done_file,
      require => Package['mariadb-client', 'python-reporting-pollster'],
    }
  }
}

