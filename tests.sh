#!/bin/bash

clear

source ./.env

CONTAINER_NAME="unit_tests"
SCOPE="tests/php/Unit"

# (1) read test scope if provided in command line
if [ "$1" != "" ] ; then
    SCOPE=$1
fi

# (2a) find out if there is a detached container running
DETACHED=$(docker ps --filter "name=${CONTAINER_NAME}" -q | wc -l)

# (2b) start detached container if not started yet
if [ $DETACHED != "1" ] ; then
    docker run \
        -d \
        --volume $(pwd):/var/www/html/blog-app \
        --name ${CONTAINER_NAME} \
        --rm \
        ${DOCKER_REG}/blog-app-1:dev \
        sleep infinity
fi

# (3) run tests
docker exec ${CONTAINER_NAME} vendor/phpunit/phpunit/phpunit \
    --bootstrap tests/php/Unit/TestBootstrap.php \
    --configuration phpunit.xml \
    ${SCOPE}

# (4) kill detached container if no scope provided in CLI
if [ "$1" == "" ] ; then
    printf "Killing detached container..."
    docker kill $(docker ps --filter "name=${CONTAINER_NAME}" -q)
fi
