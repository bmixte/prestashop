FROM alpine
MAINTAINER Benjamin MIXTE <bmixte@agileweb.fr>

# Configurations.
ENV MEMCACHED_MEMORY 128
ENV MEMCACHED_MAX_CONNECTIONS 1024
ENV MEMCACHED_MAX_ITEM_SIZE 4M

COPY start.sh /bin/start.sh
# Install memcached
RUN adduser -D -u 10003 -g 'memcached' memcached -h /home/memcached -s /bin/sh \
 && apk --update add memcached \
 && rm -rf  /tmp/* /var/cache/apk/* && chown -R memcached. /bin/start.sh && chmod 755 /bin/start.sh

# redirect php logs to stdout
#&& ln -sf /dev/stdout /var/log/php5/error.log

USER memcached

ENTRYPOINT start.sh
EXPOSE 11211
#CMD ["su","-c","start.sh","php"]
#CMD ["start.sh"]
#CMD ["/bin/sh"]
