bash 'extract_module' do
  code <<-EOH
      echo $'[client]\npassword="new-password"' > .my.cnf
      EOH
  #not_if { ::File.exist?(/root/.my.cnf) }
end


cookbook_file '/tmp/sqlconfig.sh' do
  source "sqlconfig.sh"
  mode "0755"
  owner "root"
end

execute 'run the bash' do
  command "su -c /tmp/sqlconfig.sh root"
end
