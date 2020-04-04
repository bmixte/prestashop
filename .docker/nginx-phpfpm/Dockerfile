FROM alpine
ARG CONFIG_FILE='.sites.conf'
ARG PRESTASHOP_RELEASE='1.7.6.4'
MAINTAINER Benjamin MIXTE <bmixte@agileweb.fr>
# Install nginx
RUN adduser -D -u 10000 -g 'nginx' nginx -h /home/nginx -s /bin/sh &&\
 apk --update add nginx unzip &&\
 touch /run/nginx.pid && \
 mkdir -p /run/nginx /var/www/ /etc/letsencrypt/live/stadrive.agileweb.fr/ &&\
 chmod 777 /tmp && chmod 444 /etc/letsencrypt/live/stadrive.agileweb.fr/ &&\
 chown -R 10000:10000 /etc/nginx/ /run/nginx.pid /var/lib/nginx /run/nginx /etc/letsencrypt/live/stadrive.agileweb.fr/ /usr/lib/nginx/modules /var/www &&\
 rm -rf /var/cache/apk /etc/nginx/conf.d/default.conf
# Set running context
#USER nginx
WORKDIR /var/www/
# Modify configuration file
ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./conf/default-ssl.conf /etc/nginx/conf.d/default-ssl.conf
ADD ./configure.sh /tmp/configure.sh
ADD ${CONFIG_FILE} /tmp/.sites.conf
ADD ./conf/nginx-prestashop-template.conf /tmp/nginx-prestashop-template.conf
ADD ./configure.sh /tmp/configure.sh
RUN /tmp/configure.sh && rm -rf /tmp/*
# Expose the ports for nginx
EXPOSE 8080 4443
VOLUME /etc/letsencrypt/
VOLUME /var/www/
# Start nginx server
#CMD ["nginx","-c","/etc/nginx/nginx.conf";"-d"]
CMD ["nginx", "-g", "daemon off;"]
