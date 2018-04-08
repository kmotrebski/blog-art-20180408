#!/bin/bash
set -e

clear

CONTAINER_NAME="unit_tests"
SCOPE="tests/php/Unit"

source ./.env

docker run --rm --interactive --tty \
    -v $(pwd):/app \
    --user $(id -u):$(id -g) \
    --name composer \
    composer:1.6.3 install --no-interaction --ignore-platform-reqs -vvv

docker build -t ${DOCKER_REG}/blog-app-1:dev -f docker/DockerfileDev .
docker build -t ${DOCKER_REG}/blog-app-1:prod -f docker/Dockerfile .

docker run \
        --volume $(pwd):/var/www/html/blog-app \
        --name ${CONTAINER_NAME} \
        --rm \
        ${DOCKER_REG}/blog-app-1:dev \
        vendor/phpunit/phpunit/phpunit --bootstrap tests/php/Unit/TestBootstrap.php ${SCOPE}

docker curl -XGET localhost:${HTTP_PORT}
