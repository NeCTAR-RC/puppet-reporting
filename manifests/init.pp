class reporting {

  apt::key {'reporting':
    content => file('reporting/reporting-key.asc'),
    id => '2C03CC35BC4F40D7B3BDA81032A5F6463BD97D51',
  }

  apt::source {'reporting':
    location => 'http://130.56.253.127/packages',
    release => $::lsbdistcodename,
    repos => 'main',
    key => '2C03CC35BC4F40D7B3BDA81032A5F6463BD97D51',
  }
 
}
