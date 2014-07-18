name             'rsc-nginx'
maintainer       'RightScale, Inc.'
maintainer_email 'cookbooks@rightscale.com'
license          'Apache 2.0'
description      'Installs/Configures rsc-nginx'
long_description 'Installs/Configures rsc-nginx'
version          '0.1.0'


depends 'nginx', '2.2.2'
depends "rightscale"

recipe 'rsc-nginx::default', 'Install nginx'

attribute "nginx/version",
  :display_name => "nginx version",
  :description => "Indicate which version of nginx to install",
  :required => "optional",
  :recipes => ['rsc-nginx::default']

attribute "nginx/install_method",
  :display_name => "nginx install method",
  :description => "How nginx will be installed.",
  :default => "source",
  :choose => ['source','package'],
  :required => "optional",
  :recipes => ['rsc-nginx::default']