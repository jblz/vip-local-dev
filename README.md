# Jeff's Local VIP Go Dev Env

w00t

## Quick Start

1. Install & run docker (& docker-compose if your install doesn't include it)
1. Clone this repo
1. `git submodule update --init --recursive`
1. Share the `vip-go-mu-plugins` directory in your Docker config
1. `docker-compose up`
1. Browse to http://localhost

This will create a site using the default values

## Customizing the Install

1. If you've created a site using this tool before, you'll need to clear it out. Follow the instructions under [Starting over](#starting-over)
1. `cp default.env .env` -- don't edit default.env directly, it won't work :)
1. Customize the values in the `.env` file for the site you're about to build
1. The values will get picked up when a new site is created

## Starting over

When developing against this repo, it's often helpful to "start from scratch."

```
# Stop and remove containers, networks, images, and volumes described in the docker-compose.yml file
docker-compose down

# Remove the image generated from the WPCLI Dockerfile (when altering injected scripts. See ./context/bin/start.sh)
docker image rm -f vip-local-dev_wpcli

# Remove the shared volumes that hold the WordPress DB & file system data
docker volume rm -f vip-local-dev_db_data vip-local-dev_wp_data

# Customize the values in your .env file for the new site

# Now, you're starting fresh!
docker-compose up
```

...or all together:
`docker-compose down && docker image rm -f vip-local-dev_wpcli && docker volume rm -f vip-local-dev_db_data vip-local-dev_wp_data && docker-compose up`

## CLI

You can issue one-off CLI commands like so:

`docker-compose run wpcli wp post list`
