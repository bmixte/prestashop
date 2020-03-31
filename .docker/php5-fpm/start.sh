#!/bin/sh
set -e

if [ ! -f ./config/settings.inc.php ]; then
	cd /var/www/PrestaShop-__PRESTASHOP_RELEASE__
	unzip -o /tmp/__PRESTASHOP_RELEASE__.zip
	mkdir -p log
	chmod +w -R log
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

exec "$@"
