apt_update 'all platforms' do
  frequency 86400
  action :periodic
end
#making the resource cross platform
case node['platform_family']
when 'debian'
  pac = 'apache2'
when 'rhel'
  pac = 'httpd'
end

package "#{pac}" do
  action :install
end

service "#{pac}" do
  action [ :enable, :start]
end


package 'mysql-server' do
  action :install
end



%w{ php php-gd php-mysql}.each do |pkgname|
  package pkgname do
    action :install
  end
  `notifies :restart, "service["#{pac}"]", :immediately`
end
