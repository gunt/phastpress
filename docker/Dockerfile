FROM alpine:latest

RUN apk add --no-cache \
        apache2-proxy \
        mysql-client \
        php5-apache2 \
        php5-cli \
        php5-json \
        php5-mysqli \
        php5-openssl \
        php5-phar \
        php5-zlib

RUN ln -s /usr/bin/php5 /usr/local/bin/php

RUN wget -O /usr/local/bin/wp \
    https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
