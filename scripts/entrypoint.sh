#!/bin/bash
set -e
CMD=$1

echo "$CMD"

case "$CMD" in
  
  "start" )
    echo "=======> Replacing APP_HOST Environment Variable in nginx virtual host"
    envsubst \$APP_HOST < /tmp/conf/vhost.conf > /etc/nginx/conf.d/vhost.conf
    echo "=======> Replacing Environment Variables in .env file"
    envsubst < .env-production > .env
    echo "=======> Wait for MYSQL to start and start Supervisor"
    waitfor --timeout=5 $MYSQL_HOST:3306 -- /usr/bin/supervisord -c /etc/supervisord.conf
    ;;

  "dev" )
    echo "=======> Replacing APP_HOST Environment Variable in nginx virtual host"
    envsubst \$APP_HOST < /tmp/conf/vhost.conf > /etc/nginx/conf.d/vhost.conf
    echo "=======> Replacing Environment Variables in .env file"
    envsubst < .env-development > .env
    echo "=======> Wait for MYSQL to start and start Supervisor"
    waitfor --timeout=20 $MYSQL_HOST:3306 -- /usr/bin/supervisord -c /tmp/conf/supervisord-dev.conf
    ;;    

  * )
    exec $CMD ${@:2}
    ;;

esac