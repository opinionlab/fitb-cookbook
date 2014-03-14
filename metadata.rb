name             'fitb'
maintainer       'OpinionLab, Inc.'
maintainer_email 'ops@opinionlab.com'
license          'All rights reserved'
description      'Installs/Configures fitb'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apache2', '1.9.6'
depends 'database'
depends 'mysql', '4.1.2'
depends 'ssh_known_hosts'
