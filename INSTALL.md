# Step by step

1. Create an empty MySQL database. If you wish to use an existing 
   installation of Wordpress (not recommended) then just use it's 
   coordinate below.
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

6. Open a terminal in the current directory and run: docker-compose up

7. Navigate to your Wordpress URL with your favorite Internet Browser


