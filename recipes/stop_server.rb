marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

service "nginx" do
  action :stop
end
