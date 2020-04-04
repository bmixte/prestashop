#!/bin/sh

while read SHORT_NAME FPM_POOL_PORT PRESTASHOP_RELEASE DOCUMENT_ROOT
do 
 echo "Processing website ${SHORT_NAME}"
 sed -E "s?__SHORT_NAME__?${SHORT_NAME}?g" /tmp/nginx-prestashop-template.conf |\
 sed -E "s?__FPM_POOL_PORT__?${FPM_POOL_PORT}?g" |\
 sed -E "s?__DOCUMENT_ROOT__?${DOCUMENT_ROOT}?g" > /etc/nginx/conf.d/${SHORT_NAME}.agileweb.fr.conf
done < /tmp/.sites.conf
