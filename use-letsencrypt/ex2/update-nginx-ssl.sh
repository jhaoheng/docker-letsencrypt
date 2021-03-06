#!/bin/sh

LetsEncrypt_ARCHIVE_PATH="/etc/letsencrypt/archive"
EXIST_CERTIFICATE_NAME=$(certbot certificates -d $DOMAIN | head -1 | awk '{print $3}')

UPDATE_NGINX_SSL () {
    # check if have nginx
    $(which nginx)
    ret=$?; 
    if [[ 0 -ne $ret ]]; then 
        echo "nginx get fail"; 
        exit $ret; 
    fi

    # path
    CERT_PATH=$(certbot certificates -d $DOMAIN | grep 'Certificate Path' | awk '{print $3}')
    KEY_PATH=$(certbot certificates -d $DOMAIN | grep 'Private Key Path' | awk '{print $4}')
    
    # nginx ssl path
    NGINX_SSL_PATH="/etc/nginx/ssl"
    mkdir -p $NGINX_SSL_PATH

    # copy new ssl to nginx-ssl-path
    NEW_SSL_PATH=$LetsEncrypt_ARCHIVE_PATH'/'$EXIST_CERTIFICATE_NAME
    cp $NEW_SSL_PATH"/cert"*".pem" $NGINX_SSL_PATH"/cert.pem"
    cp $NEW_SSL_PATH"/privkey"*".pem" $NGINX_SSL_PATH"/privkey.pem"

    # make new certificate enable
    nginx -s reload
}

UPDATE_NGINX_SSL