# install mysql server and client
include_recipe "database::mysql"
include_recipe "mysql::server"
include_recipe "mysql::client"

# store mysql information in a hash to be reused later
db_creds = \
{
  :host     => node['fitb']['config']['mysql']['host'],
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

# database create commands
mysql_database node['fitb']['config']['mysql']['db'] do
  connection db_creds
  action     :create
end

# Grant SELECT, UPDATE, and INSERT privileges to all tables in fitb db
mysql_database_user node['fitb']['config']['mysql']['user'] do
  connection    db_creds
  password      node['fitb']['config']['mysql']['pass']
  database_name node['fitb']['config']['mysql']['db']
  host          node['fitb']['config']['mysql']['host']
  privileges    [:select,:update,:insert]
  action        :grant
end