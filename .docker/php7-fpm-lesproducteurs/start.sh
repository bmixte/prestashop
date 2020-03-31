#!/bin/sh
set -e

cd /var/www/LesProducteurs
if [ ! -f ./config/settings.inc.php ]; then
	unzip -o /tmp/3.7.6.4.zip
	mkdir -p log
	chmod +w -R log
fi

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- php-fpm "$@"
fi

exec "$@"
