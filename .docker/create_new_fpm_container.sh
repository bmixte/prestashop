#!/bin/sh

while read SHORT_NAME FPM_POOL_PORT PRESTASHOP_RELEASE DOCUMENT_ROOT
do 
 echo "Processing website ${SHORT_NAME} ${PRESTASHOP_RELEASE}"
 # copy template dir
 rm -rf php7-fpm-${SHORT_NAME}
 cp -r php7-fpm-template php7-fpm-${SHORT_NAME}
 # change start script
 sed -Ei "s?__DOCUMENT_ROOT__?${DOCUMENT_ROOT}?g" php7-fpm-${SHORT_NAME}/start.sh 
 sed -Ei "s?__PRESTASHOP_RELEASE__?${PRESTASHOP_RELEASE}?g" php7-fpm-${SHORT_NAME}/start.sh 
 # change Dockerfile
 sed -Ei "s?__DOCUMENT_ROOT__?${DOCUMENT_ROOT}?g" php7-fpm-${SHORT_NAME}/Dockerfile
 sed -Ei "s?__SHORT_NAME__?${SHORT_NAME}?g" php7-fpm-${SHORT_NAME}/Dockerfile
 sed -Ei "s?__PRESTASHOP_RELEASE__?${PRESTASHOP_RELEASE}?g" php7-fpm-${SHORT_NAME}/Dockerfile
 sed -Ei "s?__FPM_POOL_PORT__?${FPM_POOL_PORT}?g" php7-fpm-${SHORT_NAME}/Dockerfile
 # change configuration
 mv php7-fpm-${SHORT_NAME}/conf/php-fpm-template.conf php7-fpm-${SHORT_NAME}/conf/php-fpm-${SHORT_NAME}.conf
 sed -Ei "s?__SHORT_NAME__?${SHORT_NAME}?g" php7-fpm-${SHORT_NAME}/conf/php-fpm-${SHORT_NAME}.conf
 sed -Ei "s?__FPM_POOL_PORT__?${FPM_POOL_PORT}?g" php7-fpm-${SHORT_NAME}/conf/php-fpm-${SHORT_NAME}.conf
 sed -Ei "s?__SHORT_NAME__?${SHORT_NAME}?g" php7-fpm-${SHORT_NAME}/conf/php-fpm-${SHORT_NAME}.conf
 sed -Ei "s?__SHORT_NAME__?${SHORT_NAME}?g" php7-fpm-${SHORT_NAME}/conf/php-memcached.ini
done < nginx-phpfpm/.sites.conf
