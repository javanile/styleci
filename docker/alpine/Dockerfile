FROM php:7.3-alpine

RUN apk add --no-cache tini git

RUN curl -SsLo styleci.phar https://github.com/StyleCI/CLI/releases/download/v1.0.1/styleci.phar \
        && chmod +x styleci.phar && mv styleci.phar /usr/local/bin/styleci

RUN curl -o composer.phar -sL https://getcomposer.org/composer.phar && \
        php composer.phar global require phpmailer/phpmailer && rm composer.phar

COPY mail styleci-entrypoint.sh /usr/local/bin/

WORKDIR /app

ENTRYPOINT ["styleci-entrypoint.sh"]
