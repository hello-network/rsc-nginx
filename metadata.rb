name             'rsc-nginx'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rsc-nginx'
long_description 'Installs/Configures rsc-nginx'
version          '0.3.1'

depends 'yum'
depends 'apt'
depends 'runit', '= 1.5.10'
depends 'marker', '~> 1.0.1'
depends 'collectd', '~> 1.1.0'
depends 'rightscale_tag', '~> 1.0.5'
depends "nginx", "~> 2.7.4"

recipe 'rsc-nginx::default', 'Install nginx'
recipe 'rsc-nginx::start_server', 'start nginx'
recipe 'rsc-nginx::stop-server', 'stop nginx'
recipe 'rsc-nginx::tags', 'setup the Rightscale tags for the server'
recipe 'rsc-nginx::collectd', 'setup monitoring'
recipe 'rsc-nginx::proxy', 'setups a reverse proxy'
recipe 'rsc-nginx::naxsi', 'installs and sets up naxsi'
recipe 'rsc-nginx::application_backend', 'attach to the load balancer'
recipe 'rsc-nginx::application_backend_detached', 'detach from the load balancer'

attribute "nginx/install_method",
  :display_name => "nginx install method",
  :description => "Indicate how to install nginx.  Default: package",
  :default => "package",
  :choice =>["package","source"],
  :required => "optional",
  :recipes => ['rsc-nginx::default']

attribute "nginx/default_root",
  :display_name => "Nginx root path",
  :description => "Indicate the root path.  default: /var/www/nginx-default",
  :required => "optional",
  :recipes => ['rsc-nginx::default']

attribute 'rsc-nginx/application_name',
  :display_name => 'Application Name',
  :description => 'The name of the application. This name is used to generate the path of the' +
  ' application code and to determine the backend pool in a load balancer server that the' +
  ' application server will be attached to. Application names can have only alphanumeric' +
  ' characters and underscores. Example: hello_world',
  :required => 'required',
  :recipes => [
  'rsc-nginx::default',
  'rsc-nginx::tags',
  'rsc-nginx::application_backend',
  'rsc-nginx::application_backend_detached',]
