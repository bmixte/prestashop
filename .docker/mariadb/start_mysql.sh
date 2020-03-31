#!/bin/sh
# execute any pre-init scripts
for i in /scripts/pre-init.d/*sh
do
	if [ -e "${i}" ]; then
		echo "[i] pre-init.d - processing $i"
		. "${i}"
	fi
done

if [ -f /var/lib/mysql/.resetdata ] ;then
	echo "[i] MySQL reset data file found : creating initial DBs"
	chown -R mysql:mysql /var/lib/mysql
	rm -rf /var/lib/mysql
	#mysql_install_db --user=mysql -ldata=/var/lib/mysql/data --force --verbose --force --skip-name-resolve --auth-root-authentication-method=socket --auth-root-socket-user=mysql
	mysql_install_db --user=mysql --datadir=/var/lib/mysql --force --skip-name-resolve --auth-root-socket-user=mysql
	#mysql_secure_installation
	rm -f /var/lib/mysql/.resetdata
fi

# if command starts with an option, prepend mysqld
if [ "${1:0:1}" = '-' ]; then
	set -- mysqld "$@"
fi
exec "$@"
