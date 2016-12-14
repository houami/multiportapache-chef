#adding content for site-I
file '/var/www/html/index.html' do
  content 'This is a page served by port 8005'
  mode '0755'
  owner 'root'
  group 'root'
end

# enabling the port for site-II
cookbook_file '/etc/httpd/conf.d/site2.conf' do
  source 'site2.conf'
  mode "0755"
  owner 'root'
  group 'root'
end

directory '/var/www/site2' do
  mode "0755"
  owner 'root'
  group 'root'
  action :create
end

file '/var/www/site2/index.html' do
  content 'This is a page supposed to be served by port 8006'
end

ruby_block "insert_line" do
  block do
    file=Chef::Util::FileEdit.new("/etc/httpd/conf/httpd.conf")
    #file.insert_line_if_no_match("/Listen 8005/","Listen 8005")
    file.search_file_replace_line(/Listen 80/,"Listen 8005")
    file.search_file_replace_line(/NameVirtualHost \*:80/,"NameVirtualHost *:8005")
    file.search_file_replace_line(/<VirtualHost \*:80>/,"<VirtualHost *:8005>")
    file.insert_line_if_no_match(/Listen 8006/,"Listen 8006")
    #file.search_file_delete("/Listen 80/")
    file.write_file
  end
  notifies :restart, 'service[httpd]'
end


#remote_file
#wget http://wordpress.org/latest.tar.gz
#tar xzvf

#apt-get update &apt-get i
