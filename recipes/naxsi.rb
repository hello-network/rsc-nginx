marker 'recipe_start_rightscale' do
  template 'rightscale_audit_entry.erb'
end

node.override['nginx']['install_method'] = 'source'
include_recipe "nginx::naxsi_module"
