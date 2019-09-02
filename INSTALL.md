# Step by step

1. Create an empty MySQL database. If you wish to use an existing 
   installation of Wordpress (not recommended) then just use it's 
   coordinate below.
2. Open the file "docker-compose.yml" and replace all value in 
   the environment section of wp-php-fpm. Also change the value 
   of WORDPRESS_UNIQUE_KEY (optional).
3. Open the file etc/nginx/wp.conf and replace ".ninezh.cc" for 
   the domain name or local hostname for your Wordpress instalation
   (the hostname of the computer running this project).
4. Also in etc/nginx/wp.conf change the value of 
   `proxy_pass proxy_pass https://cig-staging.ninezh.cc/invest/api;`
   to your API url. Please note that you may have to activate CORS 
   on your webserver API configuration as well as in the client 
   Javascript code. Read more about CORS here: 
   https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
   https://stackoverflow.com/questions/25702061/enable-cors-on-json-api-wordpress
5. Run the configure script "./configure" which will do the following: 
    - Pull the latest version of Wordpress in wordpress directory
    - Take out the freshly installed wp-content/plugins and move it to ./plugins 
      (if not exist yet)
    - Take out the freshly installed wp-content/themes and move it to ./themes
      (if not exist yet)
6. Open a terminal in the current directory and run: docker-compose up
7. Navigate to your Wordpress URL with your favorite Internet Browser


