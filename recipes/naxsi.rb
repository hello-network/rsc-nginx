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

node.default['nginx']['default']['modules'] = @nginx_modules

include_recipe "nginx::naxsi_module"

naxsi_extract_path = "#{Chef::Config['file_cache_path']}/nginx-naxsi-#{node['nginx']['naxsi']['version']}"
node.run_state['nginx_configure_flags'] =
  node.run_state['nginx_configure_flags'] | ["--add-module=#{naxsi_extract_path}/naxsi-#{node['nginx']['naxsi']['version']}/naxsi_src"]
