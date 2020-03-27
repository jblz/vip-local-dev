#!/bin/sh

echo "Waiting on db to be ready...";
sh /usr/local/bin/wait-for db:3306 -t 30 || exit 1;

if $(wp core is-installed); then
    echo "WordPress is already installed. 🚀";
    exit;
fi

ADMIN_EMAIL=${WPVIP_ADMIN_EMAIL:-"nobody@example.com"}
ADMIN_USER=${WPVIP_ADMIN_USER:-admin}
ADMIN_PASS=${WPVIP_ADMIN_PASS:-password}
SITE_TITLE=${WPVIP_SITE_TITLE:-Just Another VIP Test Site}
SITE_URL=${WPVIP_SITE_URL:-"http://localhost"}

if [[ -z "$WPVIP_MULTISITE" ]] || [[ "$WPVIP_MULTISITE" -eq "0" ]] || [[ ! $WPVIP_MULTISITE ]]; then
    echo "Installing WordPress";
    wp core install --url="$SITE_URL" --title="$SITE_TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASS" --admin_email="$ADMIN_EMAIL";
    echo RESULT: $?
    echo SITE_URL is $SITE_URL;
else
    echo "Installing WordPress MULTISITE";
    echo "TODO";
fi
