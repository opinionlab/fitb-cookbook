#
# Cookbook Name:: fitb
# Recipe:: default
#
# Copyright 2014, OpinionLab, Inc.
#
# All rights reserved - Do Not Redistribute
#



# create the FITB user to run the application as
user node['fitb']['user'] do
  action :create
  home   node['fitb']['install_dir']
end

# sync the code to the users home directory
git node['fitb']['install_dir'] do
  action :sync
  owner  node['fitb']['user']
  group  node['fitb']['user']
  repository node['fitb']['repository']
  reference  node['fitb']['reference']
end

# basically this imports the FITB skeleton the first time the cookbook is ran. 
# if the import succeeds, a file is created and the resource checks to see if that file exists so that your data is not overwritten on the next run
# there's probably a better way to do this.
execute "importing FITB sql skeleton" do
  command <<-IMPORT
  mysql -h #{node['fitb']['config']['mysql']['host']} 
  -u #{node['fitb']['config']['mysql']['user']} 
  -p#{node['fitb']['config']['mysql']['pass']} 
  #{node['fitb']['config']['mysql']['db']}
  < #{node['fitb']['install_dir']}/fitb.sql
  && touch #{node['fitb']['install_dir']}/.fitb_db_imported"
  IMPORT
  not_if  "ls #{node['fitb']['install_dir']}/.fitb_db_imported"
end

# drop of the config.php template with variables from our attributes
template "node['fitb']['install_dir']/config.php" do
  source "config.php.erb"
  owner  node['fitb']['user']
  group  node['fitb']['user']
  mode   0700
  variables({
    # this is a deep hash
    :config => node['fitb']['config']
    })
end

# create cron for polling switches
cron node['fitb']['cron']['name'] do
  action :create
  command
end