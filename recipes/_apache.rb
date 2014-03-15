# install apache and mod_php5 for FITB
include_recipe "apache2::default"
include_recipe "apache2::mod_php5"

# only centos has a differently named mod_php5.so module, libphp5.so
apache_module "php5" do
  if node['platform'] == "centos"
    filename "libphp5.so"
  end
end

# install template for fitb vhost in apache
template "#{node['fitb']['apache']['conf_dir']}/fitb.conf" do
  source "fitb_vhost.erb"
  owner node['apache']['user']
  group node['apache']['group']
  mode  "0770"
  variables ({
    :server_admin => node['fitb']['server_admin'],
    :install_dir  => node['fitb']['install_dir'],
    :server_name  => node['fitb']['server_name']
    })
  notifies :reload, "service[apache2]", :delayed
end

# enable fitb vhost
apache_site "fitb.conf"