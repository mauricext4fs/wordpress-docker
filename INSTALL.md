# Step by step

You must install docker-proxy first before beginning to install 
wordpress-docker. We provided a version already fully configured 
with SSL and the domain ninezh.cc at : 
https://github.com/mauricext4fs/docker-proxy.git

Please clone the above git repo and follow the setup instruction 
before continuing with this Guide.

1. Create an empty MySQL database. If you wish to use an existing 
   installation of Wordpress (not recommended) then just use it's 
   coordinate below.

2. In etc/nginx/wp.conf uncomment the section location /rapi 
   and change the value of `proxy_pass http://vlad.com;`
   to your remote backend API.

   This is optional... if you do not need to use a remote backend 
   then leave this section commented.

3. Run the configure script "./configure" which will do the following: 
    - Pull the latest version of Wordpress in wordpress directory
    - Take out the freshly installed wp-content/plugins and move it to ./plugins 
      (if not exist yet)
    - Take out the freshly installed wp-content/themes and move it to ./themes
      (if not exist yet)
    - Create project configuration (.env file) based on your answers. If this file already exists you will have option to delete it and create again.
4. Open your /etc/hosts file and add following line:<br/>
    ```sh
    X.X.X.X     <your-wordpress-url>
    ```
   Where X.X.X.X is the IP Address of your external adapter. NOT 127.0.0.1.
   Where <your-wordpress-url> is the url of you wordpress installation.

5. Open a terminal in the current directory and run: docker-compose up

6. Navigate to your Wordpress URL with your favorite Internet Browser
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
- Enter DB_HOST during configure with ip which docker sees as your local machine. In order to find it open terminal and execute:
  ```
  ip a | grep docker0 | grep inet | sed 's/inet//' | sed 's/\/.*//'
  ```

### Advices during project configuration
- WORDPRESS_URL is the 
hostname... make sure it resolve properly to the same server 
as this Wordpress installation). Do not use 127.0.0.1. As 
docker have their own network, working similarly to a Virtual 
machine, 127.0.0.1 will not resolve to the same host (your 
PC) inside the docker machine. You must use the IP of you 
WLAN or Ethernet Adapter or Virtual Adapter.

- As far as I understand it... WordrPress uses UNIQUE_KEY for
salting password saved in the Database.

- For a new installation you must create an empty Database in Mysql 
manually. The wordpress installation routine (/wp-admin/) will 
create all necessary tables in the empty database.
