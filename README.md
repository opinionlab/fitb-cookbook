FITB Cookbook
=============

[FITB](https://github.com/lozzd/FITB) is a simple php web application that's designed to Fill In The Blanks about your network gear. 

In the creators own words, FITB is a tool that automatically polls every port on a list of switches you give it. Simple configuration, precise polling, easy searching and automatic discovery of both new ports and ports that go offline are the goals of FITB.

This cookbook is designed to automate the setup of FITB so that you don't have to manually install mysql, apache or FITB itself.

Requirements
------------

**cookbooks**

* apache2

* apt

* database

* mysql

* ssh_known_hosts

* yum 

Attributes
----------
### fitb::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['fitb']['home']</tt></td>
    <td>String</td>
    <td>Users home directory</td>
    <td><tt>"/srv/fitb"</tt></td>
  </tr>
  <tr>
    <td><tt>['fitb']['install_dir']</tt></td>
    <td>String</td>
    <td>Users home directory</td>
    <td><tt>"/srv/fitb/app"</tt></td>
  </tr>
  <tr>
    <td><tt>['fitb']['server_name']</tt></td>
    <td>String</td>
    <td>Domain name for apache to listen on</td>
    <td><tt>"localhost"</tt></td>
  </tr>
  <tr>
    <td><tt>['fitb']['server_admin']</tt></td>
    <td>String</td>
    <td>Administrator email for apache</td>
    <td><tt>"ops@yourwebsite.com"</tt></td>
  </tr>
  <tr>
    <td><tt>['fitb']['repository']</tt></td>
    <td>String</td>
    <td>URL to FITB repo</td>
    <td><tt>"https://github.com/lozzd/FITB.git"</tt></td>
  </tr>
  <tr>
    <td><tt>['fitb']['reference']</tt></td>
    <td>String</td>
    <td>Branch of FITB code to use</td>
    <td><tt>"master"</tt></td>
  </tr>
  <tr>
    <td><tt>['fitb']['user']</tt></td>
    <td>String</td>
    <td>FITB user name for app to be installed as</td>
    <td><tt>""fitb""</tt></td>
  </tr>
  <tr>
    <td><tt>['fitb']['cron']['name']</tt></td>
    <td>String</td>
    <td>Job name</td>
    <td><tt>"FITB Poller"</tt></td>
  </tr>
  <tr>
    <td><tt>['fitb']['cron']['command']</tt></td>
    <td>String</td>
    <td>Command for cron to execute</td>
    <td><tt>"/usr/bin/php #{default['fitb']['install_dir']}/poller.php >> #{default['fitb']['install_dir']}/poller.log 2>&1"</tt></td>
  </tr>
  <tr>
    <td><tt>['fitb']['cron']['minute']</tt></td>
    <td>String</td>
    <td>Cron minutes</td>
    <td><tt>"*/1"</tt></td>
  </tr>
  <tr>
    <td><tt>['fitb']['cron']['hour']</tt></td>
    <td>String</td>
    <td>Cron hour</td>
    <td><tt>"*"</tt></td>
  </tr>
  <tr>
    <td><tt>['fitb']['cron']['day_of_month']</tt></td>
    <td>String</td>
    <td>Cron day of month</td>
    <td><tt>"*"</tt></td>
  </tr>
  <tr>
    <td><tt>['fitb']['cron']['month']</tt></td>
    <td>String</td>
    <td>Cron month</td>
    <td><tt>"*"</tt></td>
  </tr>
  <tr>
    <td><tt>['fitb']['cron']['day_of_week']</tt></td>
    <td>String</td>
    <td>Cron day of week</td>
    <td><tt>"*"</tt></td>
  </tr>
</table>

### fitb::config

These attributes will control the configuration of the FITB application. You can see the raw config file [here](https://github.com/lozzd/FITB/blob/master/config.php.sample).

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['config']['pollingenabled']</tt></td>
    <td>Boolean</td>
    <td>Master switch for poller</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['config']['verbose']</tt></td>
    <td>Integer</td>
    <td>Verbosity level for logging</td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['config']['path_rrdtool']</tt></td>
    <td>String</td>
    <td>Path to rrd tool</td>
    <td><tt>/usr/bin/rrdtool</tt></td>
  </tr>
  <tr>
    <td><tt>['config']['path_rrd']</tt></td>
    <td>String</td>
    <td>Directory to store RRD graphs</td>
    <td><tt>/rrds/</tt></td>
  </tr>
  <tr>
    <td><tt>['config']['RRA_average']</tt></td>
    <td>String</td>
    <td>Time resolution for graphs</td>
    <td><tt>RRA:AVERAGE:0.5:1:44640 RRA:AVERAGE:0.5:60:8760</tt></td>
  </tr>
  <tr>
    <td><tt>['config']['RRA_max']</tt></td>
    <td>String</td>
    <td>Max resolution to store for graphs</td>
    <td><tt>RRA:MAX:0.5:1:44640 RRA:MAX:0.5:60:8760</tt></td>
  </tr>
  <tr>
    <td><tt>['config']['mysql']['host']</tt></td>
    <td>String</td>
    <td>MySQL db host</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['config']['mysql']['user']</tt></td>
    <td>String</td>
    <td>MySQL username to connect as</td>
    <td><tt>fitbuser</tt></td>
  </tr>
  <tr>
    <td><tt>['config']['mysql']['pass']</tt></td>
    <td>String</td>
    <td>MySQL password</td>
    <td><tt>fitbpass</tt></td>
  </tr>
  <tr>
    <td><tt>['config']['mysql']['db'] </tt></td>
    <td>String</td>
    <td>MySQL database for FITB</td>
    <td><tt>fitb</tt></td>
  </tr>
  <tr>
    <td><tt>['config']['staleage']</tt></td>
    <td>Integer</td>
    <td>Mark graphs older than this many seconds as stale</td>
    <td><tt>1800</tt></td>
  </tr>
  <tr>
    <td><tt>['config']['purgeage']</tt></td>
    <td>Integer</td>
    <td>DELETE graphs that have been stale for this many seconds</td>
    <td><tt>2592000</tt></td>
  </tr>
  <tr>
    <td><tt>['config']['configtimeperiods']</tt></td>
    <td>Hash</td>
    <td>An array of time periods that you wish to be selectable from the dropdown at the top of every page.</td>
    <td><tt>
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
  </tt></td>
  </tr>
  <tr>
    <td><tt>['config']['default_duration']</tt></td>
    <td>String</td>
    <td>MySQL database for FITB</td>
    <td><tt>"-86400"</tt></td>
  </tr>
  <tr>
    <td><tt>['config']['error_reporting']</tt></td>
    <td>String</td>
    <td>Incase you want to debug FITB code, change this.</td>
    <td><tt>"E_ERROR | E_WARNING | E_PARSE"</tt></td>
  </tr>
</table> 

### fitb::switches

You'll want to override this hash in your wrapper cookbook. Check the example below if you want to see how we do it at [OpinionLab](http://www.opinionlab.com).

This is designed to make it easier to add switches to the FITB config file. FITB reads the switches from an [array](https://github.com/lozzd/FITB/blob/master/config.php.sample#L10-L13), which this cookbook writes for you.

```ruby
default['fitb']['config']['switches']= \
{
  'switch_1' => {
    'enabled'         => true,
    'prettyname'      => 'switch_1',
    'showoninterface' => true,
    'ip'              => '10.0.0.2',
    'snmpcommunity'   => 'public',
    "graphtypes"      => ['bits','ucastpkts','errors']
  },
  'switch_2' => {
    'enabled'         => true,
    'prettyname'      => 'switch_2',
    'showoninterface' => true,
    'ip'              => '10.0.0.2',
    'snmpcommunity'   => 'public',
    "graphtypes"      => ['bits','ucastpkts','errors']
  }
}
```

Usage
-----
#### fitb::default

Include `fitb` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[fitb]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: [Adam Enger](adamenger@gmail.com)
