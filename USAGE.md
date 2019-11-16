# Start and stop wordpress

## Start

There are two way of running the wordpress docker-compose. Either 
inline which output directly the logs to the screen or as deamon 
which gives no information unless using docker-compose logs.

### Inline

```sh
docker-compose up
```

### Deamon

```sh
docker-compose up -d
```


## Stop

### Inline

CTRL+C 

### Deamon

```sh
docker-compose down
```

# Themes and plugins

You can add your plugin directly into the `plugins` directory.

You can add your themes directly into the `themes` directory. 

Both those directory are "mounted" directly into docker. 
Any changes made in those directories will be repercuted almost 
instantly into the Wordpress Docker.

After having copied the plugin, login into your wordpress instance 
and install the plugin / theme as usual.

# Theme Version Control
Remember to create repository for your custom wordpress theme inside `./themes/<your-custom-theme-name>`.

Then setup cronjob for pulling changes from repository every 2 minutes:
```
*/2 * * * *	cd <path-to-wordpress-docker-root-directory>/themes/<your-custom-wordpress-theme> && /bin/git pull
```

# Plugin Version Control
You can do the same with plugins directory (same as above - Theme Version Control)