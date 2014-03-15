name             'fitb'
maintainer       'OpinionLab, Inc.'
maintainer_email 'ops@opinionlab.com'
license          'All rights reserved'
description      'Installs/Configures fitb'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

depends 'apache2', '1.9.6'
depends 'apt', '2.3.8'
depends 'database', '2.0.0'
depends 'mysql', '4.1.2'
depends 'ssh_known_hosts', '1.2.0'
depends 'yum', '= 2.4.4'