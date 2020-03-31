FROM alpine
MAINTAINER Benjamin MIXTE <bmixte@agileweb.fr>

# Install nginx
ENV LC_ALL=en_US.UTF-8
RUN adduser -D -u 10001 -g 'mysql' -h /home/mysql -s /bin/sh mysql\
 && apk --update add mariadb mariadb-client mariadb-server-utils pwgen \
 && rm -rf /var/cache/apk && mkdir -p /var/lib/mysql /var/run/mysqld /run/mysqld/ /etc/mysql/conf.d/ \
 && chown -R mysql:mysql /var/tmp /etc/mysql/ /var/lib/mysql /var/run/mysqld /etc/mysql/conf.d/ /run/mysqld/ \
 && chmod 777 /var/run/mysqld
# comment out a few problematic configuration values
# don't reverse lookup hostnames, they are usually another container
RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/my.cnf \
    && echo '[mysqld]\nskip-host-cache\nskip-name-resolve' > /etc/my.cnf
#USER mysql
ADD start_mysql.sh /usr/local/bin/start_mysql.sh
VOLUME /var/lib/mysql
WORKDIR /var/lib/mysql

EXPOSE 3306
ENTRYPOINT ["/usr/local/bin/start_mysql.sh"]
CMD ["/usr/bin/mysqld","--user=mysql","--console","--skip-name-resolve","--skip-networking=0"]
