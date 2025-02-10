#!/bin/bash

# $1 should be either 'dev' or 'prod'
# $2 should be rebuild, restart or down
LOG_FILE=./logs/docker-compose.log
# touch $LOG_FILE
touch $LOG_FILE
# Check if all parameters are provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 {dev|prod} {rebuild|up|down}"
  exit 1
fi


case $1 in
  dev)
    # echo "Running in development mode"
    ENV_NAME="dev"
    ENV_FILE=".env.dev"
    ;;
  prod)
    # echo "Running in production mode"
    ENV_NAME="prod"
    ENV_FILE=".env.prod"
    ;;
  *)
    echo "Invalid parameter. Use 'dev' or 'prod'."
    exit 1
    ;;
esac

case $2 in
  rebuild)
    ARG_COMMAND="up"
    ARG_BUIILD="--build"
    ARG_DEPENDNT="-d"
    ;;
  up)
    ARG_COMMAND="up"
    ARG_DEPENDNT="-d"
    ;;
  down)
    ARG_COMMAND="down"
    ;;
  *)
    echo "Invalid parameter. Use 'rebuild', 'up' or 'down'."
    exit 1
    ;;
esac


docker compose -f docker-compose.appsmith."$ENV_NAME".yml --env-file $ENV_FILE $ARG_COMMAND $ARG_BUIILD $ARG_DEPENDNT >> $LOG_FILE 2>&1
echo "docker compose -f docker-compose.appsmith.$ENV_NAME.yml --env-file $ENV_FILE $ARG_COMMAND $ARG_BUIILD $ARG_DEPENDNT" >> $LOG_FILE
