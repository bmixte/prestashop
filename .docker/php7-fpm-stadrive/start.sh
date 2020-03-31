#!/bin/sh
set -e

cd __DOCUMENT_ROOT__
if [ ! -f ./config/settings.inc.php ]; then
	unzip -o /tmp/__PRESTASHOP_RELEASE__.zip
	mkdir -p log
	chmod +w -R log
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

exec "$@"
