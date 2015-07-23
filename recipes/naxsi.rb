marker 'recipe_start_rightscale' do
  template 'rightscale_audit_entry.erb'
end

include_recipe 'nginx::ohai_plugin'
include_recipe 'nginx::commons_dir'
include_recipe 'nginx::commons_script'

@nginx_modules=[]

node['nginx']['default']['modules'].each do |mod|
  @nginx_modules<<mod
end
@nginx_modules<<'naxsi_module'

@nginx_source_modules=[]
node['nginx']['source']['modules'].each do |mod|
  @nginx_source_modules<<mod
end
@nginx_source_modules<<'nginx::naxsi_module'
@nginx_source_modules<<'nginx::http_geoip_module'

node.default['nginx']['default']['modules'] = @nginx_modules
node.default['nginx']['source']['modules'] = @nginx_source_modules

naxsi_extract_path = "#{Chef::Config['file_cache_path']}/nginx-naxsi-#{node['nginx']['naxsi']['version']}"
node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{naxsi_extract_path}/naxsi-#{node['nginx']['naxsi']['version']}/naxsi_src"]

node.set['nginx']['proxy']['location']['/']['include'] = '/etc/nginx/naxsi.rules'

include_recipe "rsc-nginx::source"

template "/etc/nginx/naxsi.rules" do
  source "naxsi.rules.erb"
  owner "root"
  group "root"
  mode 0644
  action :create
end

Chef::Log.info "adding nx_util"

package "python" do
  action :install
end

bash "install nx_util" do
  cwd ::File.join(naxsi_extract_path,"naxsi-#{node['nginx']['naxsi']['version']}",'nx_util')
  code <<-EOF
    python setup.py install
  EOF
end

directory "/var/cache/nginx" do
  owner "root"
  group "root"
  mode "0777"
  action :create
end

template "/usr/local/etc/nx_util.conf" do
  source "nx_util.conf.erb"
  owner "root"
  group "root"
  mode 0644
  action :create
end

template "/etc/nginx/sites-available/nginx-ui" do
  source 'nginx-ui.conf.erb'
  owner "root"
  group "root"
  mode 0644
  action :create
end

service "nginx"

nginx_site "nginx-ui" do
  enable true
end

cron "nginx-ui" do
  minute '1'
  command '/usr/local/bin/nx_util.py -l /var/log/nginx/*.log -c /usr/local/etc/nx_util.conf -H /var/cache/nginx/index.html -i'
  action :create
end

execute "/usr/local/bin/nx_util.py -l /var/log/nginx/*.log -c /usr/local/etc/nx_util.conf -H /var/cache/nginx/index.html -i"
