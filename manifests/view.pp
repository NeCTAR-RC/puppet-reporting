# Reporting view layer server install and configuration
class reporting::view (
  $host='localhost',
  $path='',
  $admin_email='root@localhost',
  $api_host,
  $api_port
) inherits reporting {

  package {'reporting-view':
    ensure => installed,
  }

  class { 'apache::mod::wsgi': }

  file {'/etc/reporting-view/config.js':
    owner   => root,
    group   => root,
    mode    => '0640',
    content => template('reporting/reporting-view/config.js.erb'),
    require => Package['reporting-view'],
  }

  apache::vhost {$host:
    serveradmin         => $admin_email,
    port                => 80,
    docroot             => '/var/lib/www',
    wsgi_script_aliases => { '/' => '/usr/share/reporting-view/reporting_view.py' },
    aliases             => [
      {
        aliasmatch  => '/static',
        path        => '/usr/share/reporting-view/static',
      },
    ],
    directories         => [
      {
        path => '/usr/share/reporting-view'
      },
      {
        path    => '/usr/share/reporting-view/static',
        options => ['-Indexes']
      },
    ],
  }
}