# sta-drive
mise en place d'un drive pour les commerces du centre ville de saint amand

# Build 
All docker files can be found in .docker directory
docker-compose build

# Change parameters
Before the first run, you muste specify the mysql information in th .env file.
cat .env 
MYSQL_ROOT_HOST="%"
MYSQL_DATABASE="prestashop"
MYSQL_USER="prestashop"
MYSQL_PASSWORD="prestashop*"
MYSQL_ROOT_PASSWORD="prestashop**"

You need also change nginx-phpfpm/.sites.conf
in this file you can liste all the prestahop web site you want to use.
File Header :  SHORTNAME PHP_TCP_PORT PRESTASHOP_VERSION WANTED_DOCUMENT_ROOT
After you have change this file run create_new_fpm_container.sh to generate php7 docker files and add a php block on the docker-compose.yml like this :
 php7-fpm-{SHORTNAME}:
  image: benzo96nkg/php7-fpm-{SHORTNAME}:1.0.1
  build: php7-fpm-{SHORTNAME}
  volumes:
   - /var/www/:/var/www/
  depends_on:
   - mariadb
   - memcached


# Launch
docker compose up

Check if all is running well with "docker ps"
CONTAINER ID        IMAGE                                COMMAND                  CREATED             STATUS              PORTS                                                   NAMES
fa78097bb7ed        benzo96nkg/nginx-phpfpm:1.0.1        "nginx -g 'daemon of…"   7 weeks ago         Up 5 weeks          8080/tcp, 0.0.0.0:443->4443/tcp, 0.0.0.0:80->8000/tcp   docker_nginx-phpfpm_1
0567c2a20df8        benzo96nkg/php7-fpm-stadrive:1.0.1   "start.sh php-fpm7 -…"   7 weeks ago         Up 5 weeks          9000/tcp                                                docker_php7-fpm-stadrive_1
4f1a2d3277aa        benzo96nkg/mariadb:1.0.1             "/usr/local/bin/star…"   7 weeks ago         Up 5 weeks          3306/tcp                                                docker_mariadb_1
062d3a089691        memcached:1.6.2                      "docker-entrypoint.s…"   7 weeks ago         Up 5 weeks          11211/tcp                                               docker_memcached_1

stopping : docker compose stop
