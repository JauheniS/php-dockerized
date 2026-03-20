FROM composer/composer:latest-bin AS composer
FROM ghcr.io/php/pie:bin AS pie
FROM php:8.5-cli

COPY --from=composer /composer /usr/local/bin/composer

COPY --from=pie /pie /usr/bin/pie

COPY confd/opcache.ini /usr/local/etc/php/conf.d/

# Install dependencies for gRPC
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        make \
        libgrpc-dev \
        protobuf-compiler \
        build-essential \
        pkg-config \
        libssl-dev \
        zlib1g-dev \
        autoconf \
        automake \
        libtool \
        git \
        cmake

# Install additional gRPC dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        libgrpc++-dev \
        build-essential \
        autoconf \
        libtool

# Install project required dependencies
RUN apt-get update -yqq \
    && apt-get install -yqq \
        libzip-dev \
        zip \
        libgmp-dev re2c libmhash-dev libmcrypt-dev file libcurl4-gnutls-dev \
        curl \
        libonig-dev \
        librabbitmq-dev \
        libssh-dev \
        libfreetype-dev \
        libjpeg-dev \
        libpng-dev \
        libxslt-dev supervisor \
        watch \
        libffi-dev \
        gcc \
        bison

# Install gRPC
RUN pie install pie-extensions/grpc

RUN docker-php-ext-install zip \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install gd \
    && docker-php-ext-install sockets \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install pdo \
    && docker-php-ext-install pdo_mysql

# Install Protocol Buffers
RUN pie install pie-extensions/protobuf

RUN echo 'memory_limit = 512M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini

RUN apt-get autoremove --purge -y && apt-get autoclean -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

WORKDIR /projects/