name             'rsc-nginx'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rsc-nginx'
long_description 'Installs/Configures rsc-nginx'
version          '0.1.0'


depends "rightscale"

recipe 'rsc-nginx::default', 'Install nginx'
recipe 'rsc-nginx::start_server', 'start nginx'
recipe 'rsc-nginx::stop-server', 'stop nginx'

attribute "nginx/version",
  :display_name => "nginx version",
  :description => "Indicate which version of nginx to install",
  :required => "optional",
  :recipes => ['rsc-nginx::default']
