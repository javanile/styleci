FROM ubuntu:20.04

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common git && \
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y curl tini php7.2 php7.2-dom php7.2-xsl php7.2-mbstring && \
    update-alternatives --set php /usr/bin/php7.2 && \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN curl -SsLo styleci.phar https://github.com/StyleCI/CLI/releases/download/v1.0.0/styleci.phar \
    && chmod +x styleci.phar && mv styleci.phar /usr/local/bin/styleci

COPY styleci-entrypoint.sh /usr/local/bin/styleci-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["styleci-entrypoint.sh"]

CMD ["styleci"]
