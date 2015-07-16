template "/etc/nginx/sites-available/proxy.conf" do
  source "proxy.conf.erb"
  owner "root"
  group "root"
  mode 0777
  variables(:proxy_hash => node['nginx']['proxy'] )
  action :create
end

nginx_site "proxy" do
  enable true
end
