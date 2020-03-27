#!/bin/sh

echo "Waiting on db to be ready...";
sh /usr/local/bin/wait-for db:3306 -t 30 || exit 1;

echo 🚧🚧🚧 db is ready! Getting to work 🚧🚧🚧;

if $(wp core is-installed); then
    SITE_URL=$(wp option get siteurl)
    echo "🚀 Loaded existing WordPress install at: $SITE_URL";
    exit;
fi

ADMIN_EMAIL=${WPVIP_ADMIN_EMAIL:-"nobody@example.com"}
ADMIN_PASS=${WPVIP_ADMIN_PASS:-password}
ADMIN_USER=${WPVIP_ADMIN_USER:-admin}
SITE_TITLE=${WPVIP_SITE_TITLE:-Just Another VIP Test Site}
SITE_URL=${WPVIP_SITE_URL:-"http://localhost"}

if [[ -z "$WPVIP_MULTISITE" ]] || [[ "$WPVIP_MULTISITE" -eq "0" ]] || [[ ! $WPVIP_MULTISITE ]]; then
    echo "Installing WordPress";
    wp core install --url="$SITE_URL" --title="$SITE_TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASS" --admin_email="$ADMIN_EMAIL" &&
        echo "🚀 Installed WordPress at: $SITE_URL";
else
    echo "Installing WordPress MULTISITE";
    echo "TODO";
fi
