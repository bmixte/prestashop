# sta-drive
mise en place d'un drive pour les commerces du centre ville de saint amand

# Docker Build 
All docker files can be found in .docker directory

* docker build -t apache-agw:202003 .docker/apache/
* docker build -t php5-agw:202003 .docker/php5-fpm/
* docker build -t php7-agw:202003 .docker/php7-fpm/
* docker build -t memcached-agw:202003 .docker/memcached/
* docker build -t mariadb-agw:202003 .docker/mysql/
* docker build -t nginx-agw:202003 .docker/nginx/

# Docker Compose
docker compose -rm mariadb
docker-compose rm php5-fpm
