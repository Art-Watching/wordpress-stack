# WordPress con Apache + PHP-FPM incluso + estensione phpredis (object cache veloce).
# Pinna una versione WP specifica sostituendo il tag se vuoi riproducibilità totale,
# es. wordpress:6.8-php8.3-apache
FROM wordpress:7-php8.5-apache

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends $PHPIZE_DEPS; \
    pecl install redis; \
    docker-php-ext-enable redis; \
    apt-get purge -y --auto-remove $PHPIZE_DEPS; \
    rm -rf /var/lib/apt/lists/*
