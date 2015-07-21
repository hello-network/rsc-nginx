# To change this template, choose Tools | Templates
# and open the template in the editor.
default["rsc-nginx"]["application_name"]="myapp"
default["rsc-nginx"]["vhost_path"]="default"
default["rsc-nginx"]["listen_port"]="80"
default['rsc-nginx']['bind_network_interface']="private"

include_attribute 'nginx::source'
