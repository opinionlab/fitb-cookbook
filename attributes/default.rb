#===============#
# FITB cookbook
#===============#

# FITB application settings
default['fitb']['install_dir'] = "/srv/fitb"
default['fitb']['repository']  = "https://github.com/lozzd/FITB.git"
default['fitb']['reference']   = "master"
default['fitb']['user']        = "fitb"

# FITB cronjob settings
default['fitb']['cron']['name']         = "*/1"
default['fitb']['cron']['command']      = "/usr/bin/php #{default['fitb']['install_dir']}/poller.php >> #{default['fitb']['install_dir']}/poller.log 2>&1"
default['fitb']['cron']['minute']       = "*"
default['fitb']['cron']['hour']         = "*"
default['fitb']['cron']['day_of_month'] = "*"
default['fitb']['cron']['month']        = "*"
default['fitb']['cron']['day_of_week']  = "*"

#::
# Config.php settings
#::

# POLLING ENABLED:
# This is the master switch. Flip this to false if you want to stop polling for any reason. 
default['fitb']['config']['pollingenabled'] = true

# FITB hash of switches to poll
default['fitb']['config']['switches']['yourswitchname']  = \
{
  'enabled'         => true,
  'prettyname'      => 'yourswitchname',
  'showoninterface' => true,
  'ip' => '0.0.0.0'
}

# Verbosity. Choose your level of logging here. This affects everything that logs, which at the minute is
# just the poller and it's child processes. 
#
# 0 for almost nothing, 1 for some information, 2 for lots of information. 
default['fitb']['config']['verbose'] = 1

# The path to your desired rrdtool binary.
default['fitb']['config']['path_rrdtool'] = "/usr/bin/rrdtool"

# The path where you want to store your RRD files. The default is the "rrds" directory beneath this file.
default['fitb']['config']['path_rrd'] = "/rrds/"

# Feel free to adjust these RRA definitions. Default stores 1 month at 1 minute resolution, and 1 year at 60 minutes
default['fitb']['config']['RRA_average'] = "RRA:AVERAGE:0.5:1:44640 RRA:AVERAGE:0.5:60:8760 "
default['fitb']['config']['RRA_max']     = "RRA:MAX:0.5:1:44640 RRA:MAX:0.5:60:8760"

##
# MySQL db settings
##
default['fitb']['config']['mysql']['host'] = "localhost"
default['fitb']['config']['mysql']['user'] = "fitbuser"
default['fitb']['config']['mysql']['pass'] = "fitbp4ss"
default['fitb']['config']['mysql']['db']   = "fitb"

# Old age:
# Mark graphs older than this many seconds as stale
default['fitb']['config']['staleage'] = 1800

# DELETE graphs that have been stale for this many seconds
# WARNING! You will lose your data if you don't set this correctly!
# You have been warned!
# Set to 0 to disable deletion of ports that have since been downed. 
default['fitb']['config']['purgeage'] = 2592000;

# Time periods:
# An array of time periods that you wish to be selectable from the dropdown at the top of every page.
# E.g. 300 seconds = 5 minutes
default['fitb']['config']['configtimeperiods'] = \
{
  "-300"     => '5 minutes', 
  "-3600"    => '1 hour', 
  "-7200"    => '2 hours', 
  "-14400"   => '4 hours', 
  "-43200"   => '12 hours', 
  "-86400"   => '1 day', 
  "-172800"  => '2 days', 
  "-604800"  => '7 days', 
  "-1209600" => '14 days', 
  "-2678400" => '1 month'
}

# default is one day
default['fitb']['config']['default_duration'] = "-86400";

# PHP Error reporting
# Incase you want to debug FITB code, change this
default['fitb']['config']['error_reporting']= "(E_ERROR | E_WARNING | E_PARSE)"

