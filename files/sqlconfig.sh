mysql -e "CREAT DATABASE wordpress;"
mysql -e "CREATE USER wordpressuser@localhost IDENTIFIED BY 'password';"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO wordpressuser@localhost IDENTIFIED BY 'password';"
mysql -e "FLUSH PRIVILEGES;"
