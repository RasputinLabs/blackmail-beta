FROM rasputinlabs/server:0.2
MAINTAINER David Ramsington <grokbot.dwr@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV APP_HOST blackmail.rasputinlabs.com
ENV APP_ENV production
ENV MYSQL_HOST mysql
ENV MYSQL_PW my-secret-pw
ENV REDIS_HOST redis

COPY ./conf/* /tmp/conf/
COPY ./src /usr/share/nginx/html
COPY ./scripts/wait-for-it.sh /usr/bin/waitfor
COPY ./scripts/entrypoint.sh /entrypoint.sh

WORKDIR /usr/share/nginx/html
# Install Node / Laravel Envoy / Laravel Installer + artisan up + npm run production + clean up again
RUN composer global require "laravel/envoy" && \
	composer global require "laravel/installer" && \
    ln -s /root/.composer/vendor/bin/laravel /usr/bin/laravel && \
    apt-get update && apt-get install -y nodejs && \
    envsubst < .env-development > .env && \
    mv /tmp/conf/supervisord.conf /etc/supervisord.conf && \
	php artisan up && \
	npm run production && \
	chown -R www-data:www-data . && \
	apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean && \
    echo -n > /var/lib/apt/extended_states && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/man/?? && \
    rm -rf /usr/share/man/??_* && \
    chmod +x /entrypoint.sh && chmod +x /usr/bin/waitfor

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["start"]