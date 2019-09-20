# Step by step

1. Create an empty MySQL database. If you wish to use an existing 
   installation of Wordpress (not recommended) then just use it's 
   coordinate below.
   - after you install mysql on your local machine remeber to
   allow connection to mysql remotely. Open your mysql config
   file (on ubuntu: /etc/mysql/mysql.conf.d/mysqld.cnf) and edit
   following line to be like this:<br/>
   `bind-address  = 0.0.0.0`<br/>
   Then restart your mysql service.
   - after you created mysql database with user who has permission
   to read/write to this database remember to allow remote 
   connections for this user:<br/>
   `UPDATE mysql.user SET host = '%' WHERE user = '<user>'`
2. Open the file "docker-compose.yml" and replace all value in 
   the environment section of wp-php-fpm. Also change the value 
   of WORDPRESS_UNIQUE_KEY (optional) to whatever you like so that.
   As far as I understand it... WordrPress uses this variable for
   salting password saved in the Database.
3. Open the file "docker-compose.yml" and replace 
   "my-wordpress-site.com" for 
   the site url value of your wordpress installation. This is the 
   hostname... make sure it resolve properly to the same server 
   as this Wordpress installation).
   Make sure to add `:<port>/wp/` to WORDPRESS_SITE_URL variable of 
   wp-php-fpm service. Default port is 8020 (property 'ports' in 
   wp-web service)

   Replace WORDPRESS_DB_HOST with ip which docker sees as your local 
   machine. In order to find it open terminal and execute:
   ```
    ip a | grep docker0 | grep inet | sed 's/inet//' | sed 's/\/.*//'
   ```

   Also replace the value of the variable WORDPRESS_DB_NAME to your 
   database server. Also adjust the DB login information as desired. 
   For a new installation you must create an empty Database in Mysql 
   manually. The wordpress installation routine (/wp-admin/) will 
   create all necessary tables in the empty database.

4. In etc/nginx/wp.conf uncomment the section location /rapi 
    and change the value of `proxy_pass http://vlad.com;`
   to your remote backend API.

   This is optional... if you do not need to use a remote backend 
   then leave this section commented.

5. Run the configure script "./configure" which will do the following: 
    - Pull the latest version of Wordpress in wordpress directory
    - Take out the freshly installed wp-content/plugins and move it to ./plugins 
      (if not exist yet)
    - Take out the freshly installed wp-content/themes and move it to ./themes
      (if not exist yet)
6. Open your /etc/hosts file and add following line:<br/>
`127.0.0.1     <your-wordpress-url>`<br/>
\<your-wordpress-url> is site url value of your wordpress installation without
`:<port>/wp/` section.

7. Open a terminal in the current directory and run: docker-compose up

8. Navigate to your Wordpress URL with your favorite Internet Browser
(remember to use `:<port>/wp/` path)

## Troubleshooting

After wordpress installation you can see error saying that twentynineteen theme
is not existing (as it is default theme). To solve this you need to download this 
theme and put it inside themes/ directory:
```
cd themes/ && wget https://downloads.wordpress.org/theme/twentynineteen.1.4.zip
unzip twentynineteen.1.4.zip && rm -f twentynineteen.1.4.zip
```
At the time you are running this there could be newer version of this theme.
To download newest version go to https://wordpress.org/themes/twentynineteen/
and click "Download"
