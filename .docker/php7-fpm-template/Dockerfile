FROM alpine:3.9
ARG PRESTASHOP_RELEASE='__PRESTASHOP_RELEASE__'
MAINTAINER Benjamin MIXTE <bmixte@agileweb.fr>

# Install nginx
ENV LC_ALL=en_US.UTF-8

ENV PHPIZE_DEPS \
		autoconf \
		dpkg-dev dpkg \
		file \
		g++ \
		gcc \
		libc-dev \
		make \
		pkgconf \
		re2c

RUN adduser -D -u 10000 -g 'nginx' nginx -h /home/nginx -s /bin/sh \
 && apk --update add --virtual .build-deps $PHPIZE_DEPS \
	zlib-dev libmemcached-dev memcached-dev \
	curl libxml2 libxml2-dev\
	'php7<7.3' 'php7-dev<7.3' 'php7-xml<7.3' 'php7-session<7.3' 'php7-pear<7.3' php7-pecl-igbinary php7-pecl-msgpack 'php7-bcmath<7.3' 'php7-fileinfo<7.3' 'php7-tokenizer<7.3' 'php7-phar<7.3' 'php7-mbstring' 'php7-fpm<7.3' 'php7-opcache<7.3' 'php7-xsl<7.3' 'php7-mcrypt<7.3' 'php7-gd<7.3' 'php7-json<7.3' 'php7-intl<7.3' 'php7-pdo<7.3' 'php7-pdo_mysql<7.3' 'php7-mysqli<7.3' 'php7-dom<7.3' 'php7-curl<7.3' 'php7-iconv<7.3' 'php7-ctype<7.3' 'php7-xml<7.3' 'php7-simplexml<7.3' 'php7-zip<7.3' 'php7-openssl<7.3' \
	mysql-client netcat-openbsd tcpdump
RUN pecl channel-update pecl.php.net && pecl install memcached \
 && chmod +x /usr/lib/php7/modules/memcached.so \
 && rm -rf /etc/php7/php7-fpm.conf /var/run/php7.pid /etc/php7/php-fpm.d/www.conf\
 && touch /var/run/php7-fpm-__SHORT_NAME__.pid \
 && chown -R nginx:nginx /etc/php7 /var/run/php7-fpm-__SHORT_NAME__.pid
USER nginx
RUN wget -O /tmp/${PRESTASHOP_RELEASE}.zip https://github.com/PrestaShop/PrestaShop/releases/download/${PRESTASHOP_RELEASE}/prestashop_${PRESTASHOP_RELEASE}.zip && chmod +r /tmp/${PRESTASHOP_RELEASE}.zip

ADD start.sh /usr/local/bin/start.sh
COPY conf/php-fpm-__SHORT_NAME__.conf /etc/php7/php-fpm.d/
COPY conf/php-memcached.ini /etc/php7/conf.d/99_memcached.ini
COPY conf/php-mini.ini /etc/php7/php.ini

ENTRYPOINT ["start.sh"]
WORKDIR __DOCUMENT_ROOT__
EXPOSE __FPM_POOL_PORT__
CMD ["php-fpm7", "-O", "--nodaemonize"]
