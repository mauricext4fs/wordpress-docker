# Step by step

You must install docker-proxy first before beginning to install 
wordpress-docker. We provided a version already fully configured 
with SSL and the domain ninezh.cc: 
https://github.com/mauricext4fs/docker-proxy.git

1. Create an empty MySQL database. If you wish to use an existing 
   installation of Wordpress (not recommended) then just use it's 
   coordinate below.
2. Open the file "docker-compose.yml" and replace all value in 
   the environment section of wp-php-fpm. Also change the value 
   of VIRTUAL_HOST and aliases. Also change the value 
   of WORDPRESS_UNIQUE_KEY (optional) to whatever you like so that.
   As far as I understand it... WordrPress uses this variable for
   salting password saved in the Database.
3. Open the file "docker-compose.yml" and replace 
   "my-wordpress-site.com" for 
   the site url value of your wordpress installation. This is the 
   hostname... make sure it resolve properly to the same server 
   as this Wordpress installation). Do not use 127.0.0.1. As 
   docker have their own network, working similarly to a Virtual 
   machine, 127.0.0.1 will not resolve to the same host (your 
   PC) inside the docker machine. You must use the IP of you 
   WLAN or Ethernet Adapter or Virtual Adapter.

   Replace WORDPRESS_DB_HOST with ip of your database. Also 
   replace the value of the variable WORDPRESS_DB_NAME to your 
   database server. Also adjust the DB login information as desired. 
   For a new installation you must create an empty Database in Mysql 
   manually. The wordpress installation routine (/wp-admin/) will 
   create all necessary tables in the empty database.

4. In etc/nginx/wp.conf uncomment the section location /rapi 
   and change the value of `proxy_pass http://vlad.com;`
   to your remote backend API.

   This is optional... if you do not need to use a remote backend 
   then leave this section commented.

5. Go to .env file and replace "some_project_name" value of variable COMPOSE_PROJECT_NAME 
   with name of your wordpress project.

6. Run the configure script "./configure" which will do the following: 
    - Pull the latest version of Wordpress in wordpress directory
    - Take out the freshly installed wp-content/plugins and move it to ./plugins 
      (if not exist yet)
    - Take out the freshly installed wp-content/themes and move it to ./themes
      (if not exist yet)
7. Open your /etc/hosts file and add following line:<br/>
```sh
X.X.X.X     <your-wordpress-url>
```
   Where X.X.X.X is the IP Address of your external adapter. NOT 127.0.0.1.
   Where <your-wordpress-url> is the url of you wordpress installation.

8. Open a terminal in the current directory and run: docker-compose up

9. Navigate to your Wordpress URL with your favorite Internet Browser
(remember to use `:<port>/wp-admin/` path)

## Troubleshooting

### Theme does not exist
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

### IP of local MySQL database
Although it is strongly not recommended to use local database (you should use remote one) here is a solution for finding right ip of this database so docker container can reach it:
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
- Replace WORDPRESS_DB_HOST with ip which docker sees as your local 
machine. In order to find it open terminal and execute:
  ```
  ip a | grep docker0 | grep inet | sed 's/inet//' | sed 's/\/.*//'
  ```
