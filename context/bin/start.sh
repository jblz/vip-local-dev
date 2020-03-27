#!/bin/sh

echo "Waiting on db to be ready...";
sh /usr/local/bin/wait-for db:3306 -t 30 || exit 1;

if $(wp core is-installed); then
    echo "WordPress is already installed";
    if $VIP_GO_EMPTY_SITE; then
        echo "Emptying site";
        wp site empty --yes;
    else
        exit;
    fi
fi

echo VIP_GO_MULTISITE is $VIP_GO_MULTISITE;

if [[ -z "$VIP_GO_MULTISITE" ]] || [[ "$VIP_GO_MULTISITE" -eq "0" ]] || [[ ! $VIP_GO_MULTISITE ]]; then
    echo "Installing WordPress";
    wp core install --url="http://localhost" --title="vip-local-dev test" --admin_user="admin" --admin_password="password" --admin_email="nobody@example.com";
else
    echo "Installing WordPress MULTISITE";
    echo "TODO";
fi
