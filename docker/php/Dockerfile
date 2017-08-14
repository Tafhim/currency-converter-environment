FROM php:7.0-fpm

RUN apt-get update && \
    apt-get install -y --no-install-recommends git zip unzip zlib1g-dev ca-certificates #zendframework-bin #gosu

RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install json \
    && docker-php-ext-install zip

# Setup composer
RUN curl --silent --show-error https://getcomposer.org/installer -o /var/www/html/composer-installer.php
RUN php /var/www/html/composer-installer.php --install-dir=/usr/local/bin --filename=composer

# Setup zf tool
#RUN ZEND_TOOL_INCLUDE_PATH=/usr/local/include/php/Zend/

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

#COPY for_docker/passwd /etc/passwd
#COPY for_docker/shadow /etc/shadow
#COPY for_docker/group /etc/group

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 777 /usr/local/bin/entrypoint.sh
RUN bash /usr/local/bin/entrypoint.sh 

#ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
