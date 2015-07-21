# To change this template, choose Tools | Templates
# and open the template in the editor.

default["rsc-nginx"]["application_name"]="myapp"
default["rsc-nginx"]["vhost_path"]="default"
default["rsc-nginx"]["listen_port"]="80"
default['rsc-nginx']['bind_network_interface']="private"
override['nginx']['install_method'] = 'source'
default['nginx']['version'] = '1.9.3'
default['nginx']['source']['version'] = node['nginx']['version']
