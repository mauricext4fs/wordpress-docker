# wordpress-docker

Set of utility to setup wordpress in docker with proxy pass for separated backend api

See USAGE.md for installation guide.

## Requirements

You must have docker and docker-compose installed on your system. You also need to have 
access to a MySQL Server for the Wordpress installation.

## MySQL

This bundle does not include a MySQL server. Our desired is to keep the system as 
simple as possible.

As this is intended for any type of user with only basic Terminal skills, we decided that 
it was more appropriate to let the user setup his MySQL database server separatly. Consequently, the user does not need to learn about data persistency, volumes and other important technical aspect that involves running the database locally in docker.


## Setup

See INSTALL.md

## Usage

See USAGE.md

