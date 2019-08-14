# Usage

## Setup

1. Create an empty MySQL database 
2. Open the file "docker-compose.yml" and replace all value in 
   the environment section of wp-php-fpm.
3. Open the file etc/nginx/wp.conf and replace ".ninezh.cc" for 
   the domain name or local hostname for your Wordpress instalation.
4. Run the configure script "./configure" which will do the following: 
    - Pull the latest version of Wordpress in wordpress directory
    - Take out the freshly installed wp-content/plugins and move it to ./plugins 
      (if not exist yet)
    - Take out the freshly installed wp-content/themes and move it to ./themes
      (if not exist yet)
5. Open a terminal in the current directory and run: docker-compose up
6. Navigate to your Wordpress URL with your favorite Internet Browser


## Themes and plugins

