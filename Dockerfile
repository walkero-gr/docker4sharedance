ARG PHP_TAG
FROM wodby/php:${PHP_TAG}

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

USER root

RUN apk add --update --no-cache npm \
    build-base \
    libevent \
    libevent-dev \
    zlib \
    tar \
    openjdk8 py2-pip py2-yuicompressor;

RUN curl -fSL "https://github.com/walkero-gr/docker4sharedance/raw/master/files/sharedance-0.6.tar.gz" -o /tmp/sharedance-0.6.tar.gz; \
    tar xzf /tmp/sharedance-0.6.tar.gz -C /tmp; \
    cd /tmp/sharedance-0.6; \
    ./configure; make; make install; \
    mkdir /tmp/sharedance; \
    rm /tmp/sharedance-0.6.tar.gz; \
    rm -rf /tmp/sharedance-0.6; \
    mkdir /docker-entrypoint-init.d; \
    touch /docker-entrypoint-init.d/sharedance_start.sh; \
    printf "#\!/usr/bin/env bash\nsudo /usr/local/sbin/sharedanced --directory=/tmp/sharedance --daemonize" > /docker-entrypoint-init.d/sharedance_start.sh

RUN pear channel-update pear.php.net; \
    pear install Console_ProgressBar-beta; \
    npm install -g uglify-js;

USER wodby