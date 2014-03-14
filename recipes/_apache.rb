include_recipe "apache2::default"
include_recipe "apache2::mod_php5"

package "php5-mysql"

apache_module "php5"

template "/etc/apache2/sites-available/fitb.conf" do
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

apache_site "fitb.conf"