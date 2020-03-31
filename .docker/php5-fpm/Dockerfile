FROM alpine:3.8
ARG PRESTASHOP_RELEASE='1.7.6.4'
MAINTAINER Benjamin MIXTE <bmixte@agileweb.fr>

# Install nginx
ENV LC_ALL=en_US.UTF-8
RUN adduser -D -u 10000 -g 'nginx' nginx -h /home/nginx -s /bin/sh \
 && apk --update add curl php5-cli php5-pear 'php5-phar<7.3' 'php5-fpm<7.3' 'php5-opcache<7.3' 'php5-xsl<7.3' 'php5-mcrypt<7.3' 'php5-gd<7.3' 'php5-json<7.3' 'php5-intl<7.3' 'php5-pdo<7.3' 'php5-pdo_mysql<7.3' 'php5-mysqli<7.3' 'php5-curl<7.3' 'php5-iconv<7.3' 'php5-ctype<7.3' 'php5-xml<7.3' 'php5-zip<7.3' 'php5-openssl<7.3' libmemcached-dev  mysql-client netcat-openbsd tcpdump
RUN rm -rf /var/run/php.pid && mkdir -p /var/log/php /var/run/ && touch /var/run/php-fpm5.pid \
 && chown -R nginx:nginx /etc/php5 /var/log/php /var/run/php-fpm5.pid

# redirect php logs to stdout
#&& ln -sf /dev/stdout /var/log/php/error.log

ADD start.sh /usr/local/bin/start.sh
RUN sed -Ei "s?__PRESTASHOP_RELEASE__?${PRESTASHOP_RELEASE}?g" /usr/local/bin/start.sh
COPY conf/php-fpm.conf /etc/php5/
COPY conf/php-mini.ini /etc/php5/php.ini
ADD --chown=10000:10000 https://github.com/PrestaShop/PrestaShop/releases/download/${PRESTASHOP_RELEASE}/prestashop_${PRESTASHOP_RELEASE}.zip /tmp/${PRESTASHOP_RELEASE}.zip
ENTRYPOINT ["start.sh"]
# USER nginx
WORKDIR /var/www/PrestaShop-${PRESTASHOP_RELEASE}
EXPOSE 9000
CMD ["php-fpm5", "--nodaemonize"]
