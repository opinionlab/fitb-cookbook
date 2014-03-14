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

execute "importing FITB sql skeleton" do
  command "mysql -h #{node['fitb']['config']['mysql']['host']} -u #{node['fitb']['config']['mysql']['user']} -p#{node['fitb']['config']['mysql']['pass']} && touch #{node['fitb']['install_dir']}/.fitb_db_imported"
  not_if  "ls #{node['fitb']['install_dir']}/.fitb_db_imported"
end

cron node['fitb']['cron']['name'] do
  action :create
  command
end

template 

