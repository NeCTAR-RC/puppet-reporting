# Reporting API server install and configuration
class reporting::api (
  $api_host,
  $api_port,
  $db_user,
  $db_pass,
  $db_host,
  $db_name,
  $keystone_auth_url,
  $keystone_identity_url,
  $admin_user,
  $admin_pass,
  $admin_tenant,
  $auth_role
) inherits reporting {

  package {'python-reporting-api':
    ensure => installed,
  }

  file {'/etc/reporting-api/apiv1.ini':
    owner   => root,
    group   => root,
    mode    => '0600',
    content => template('reporting/reporting-api/apiv1.ini.erb'),
    require => Package['python-reporting-api'],
  }

  file {'/etc/reporting-api/paste.config':
    owner   => root,
    group   => root,
    mode    => '0600',
    content => template('reporting/reporting-api/paste.config.erb'),
    require => Package['python-reporting-api'],
  }

  file {'/etc/reporting-api/swagger/swagger_apiv1.json':
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template('reporting/reporting-api/swagger/swagger_apiv1.json.erb'),
    require => Package['python-reporting-api'],
  }

  file {'/etc/reporting-api/swagger/swagger_versions.json':
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template('reporting/reporting-api/swagger/swagger_versions.json.erb'),
    require => Package['python-reporting-api'],
  }
}
