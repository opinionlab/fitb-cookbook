# install the packages we need for FITB to work
node['fitb']['packages'].each do |p|
  package p
end

# we need git to pull FITB code
package "git"

# add github.com ssh key to known hosts
ssh_known_hosts_entry "github.com"

# create the FITB user to run the application as
user node['fitb']['user'] do
  supports :manage_home => true
  action   :create
  home     node['fitb']['home']
  shell    "/bin/bash"
end

# sync the code 
git node['fitb']['install_dir'] do
  action     :sync
  user       node['fitb']['user']
  group      node['fitb']['user']
  repository node['fitb']['repository']
  reference  node['fitb']['reference']
end

# fix ownership to fitb app dir for apache
execute "fix ownership" do
  command "chown -R #{node['apache']['user']}:#{node['apache']['group']} #{node['fitb']['install_dir']}"
end

# also fix perms so apache can read/execute
execute "fix permissions" do
  command "chmod -R 755 #{node['fitb']['install_dir']}"
end

# basically this imports the FITB skeleton the first time the cookbook is ran. 
# if the import succeeds, a file is created and the resource checks to see if that file exists so that your data is not overwritten on the next run
# there's probably a better way to do this.
execute "importing FITB sql skeleton" do
  command <<-IMPORT
  mysql -h #{node['fitb']['config']['mysql']['host']} \
  -u root \
  -p#{node['mysql']['server_repl_password']} \
  #{node['fitb']['config']['mysql']['db']} \
  < #{node['fitb']['install_dir']}/fitb.sql \
  && touch #{node['fitb']['install_dir']}/.fitb_db_imported
  IMPORT
  not_if  "ls #{node['fitb']['install_dir']}/.fitb_db_imported"
end

# drop of the config.php template with variables from our attributes
template "#{node['fitb']['install_dir']}/config.php" do
  source "config.php.erb"
  owner  node['apache']['user']
  group  node['apache']['group']
  mode   0700
  variables({
    # this is a deep hash
    :config => node['fitb']['config']
    })
end

# create cron for polling switches
cron node['fitb']['cron']['name'] do
  action :create
  command node['fitb']['cron']['command']
  minute  node['fitb']['cron']['minute']
  hour    node['fitb']['cron']['hour']   
  day     node['fitb']['cron']['day_of_month']
  month   node['fitb']['cron']['month']       
  weekday node['fitb']['cron']['day_of_week'] 
end 




