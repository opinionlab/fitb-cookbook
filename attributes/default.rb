#===============#
# FITB cookbook
#===============#

# FITB application settings
default['fitb']['home']         = "/srv/fitb"
default['fitb']['install_dir']  = "/srv/fitb/app"
default['fitb']['server_name']  = "localhost"
default['fitb']['server_admin'] = "ops@yourwebsite.com"
default['fitb']['repository']   = "https://github.com/lozzd/FITB.git"
default['fitb']['reference']    = "master"
default['fitb']['user']         = "fitb"

# account for different package names in distros
case node['platform']
  when 'redhat', 'centos', 'amazon'
    default['fitb']['packages'] = \
    [
      'php-mysql',
      'php-snmp',
      'rrdtool'
    ]
    default['fitb']['apache']['conf_dir'] = "/etc/httpd/conf.d/"
  when 'debian', 'ubuntu'
    default['fitb']['packages'] = \
    [
      'php5-mysql',
      'php5-snmp',
      'rrdtool'
    ]
    default['fitb']['apache']['conf_dir'] = "/etc/apache2/sites-available/"
end

# FITB cronjob settings
default['fitb']['cron']['name']         = "FITB Poller"
default['fitb']['cron']['command']      = "/usr/bin/php #{default['fitb']['install_dir']}/poller.php >> #{default['fitb']['install_dir']}/poller.log 2>&1"
default['fitb']['cron']['minute']       = "*/1"
default['fitb']['cron']['hour']         = "*"
default['fitb']['cron']['day_of_month'] = "*"
default['fitb']['cron']['month']        = "*"
default['fitb']['cron']['day_of_week']  = "*"

# MySQL root password for mysql cookbook
# it's not recommended to leave these as default values, or even set them in your attributes.
# best practice is to set these values from an encrypted databag.
# http://docs.opscode.com/chef/essentials_data_bags.html#encrypt
default['mysql']['server_repl_password']   = "yourpassword"
default['mysql']['server_root_password']   = "yourpassword"
default['mysql']['server_debian_password'] = "yourpassword"