# WordPress con Apache + PHP-FPM incluso + estensione phpredis (object cache veloce).
# Tag: major WP 7 (minor automatiche) + PHP 8.5 + Apache.
# Per riproducibilità totale pinna una minor esatta, es. wordpress:7.1.3-php8.5-apache
FROM wordpress:7-php8.5-apache

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends $PHPIZE_DEPS; \
    pecl install redis; \
    docker-php-ext-enable redis; \
    apt-get purge -y --auto-remove $PHPIZE_DEPS; \
    rm -rf /var/lib/apt/lists/*

# Accesso del gestore del sito (utente SSH "wpsite" sull'host, vedi
# /usr/local/sbin/wp-enter): sftp-server senza demone + wp-cli.
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends openssh-sftp-server less; \
    rm -rf /var/lib/apt/lists/*; \
    curl -fsSL -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; \
    chmod +x /usr/local/bin/wp; \
    wp --allow-root --version
