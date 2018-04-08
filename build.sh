#!/bin/bash
set -e

clear

CONTAINER_NAME="unit_tests"
SCOPE="tests/php/Unit"

source dev.conf

docker run --rm --interactive --tty \
    -v $(pwd):/app \
    --env SSH_AUTH_SOCK=/ssh-auth.sock \
    --volume $SSH_AUTH_SOCK:/ssh-auth.sock \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --volume ~/.ssh:/home/$(id -u -n)/.ssh \
    --user $(id -u):$(id -g) \
    --name composer \
    composer:1.6.3 update --no-interaction --ignore-platform-reqs -vvv

docker build -t ${DOCKER_REG}/blog-app-1:dev -f docker/DockerfileDev .
docker build -t ${DOCKER_REG}/blog-app-1:prod -f docker/Dockerfile .

docker run \
        --volume $(pwd):/var/www/html/blog-app \
        --name ${CONTAINER_NAME} \
        --rm \
        ${DOCKER_REG}/blog-app-1:dev \
        vendor/phpunit/phpunit/phpunit --bootstrap tests/php/Unit/TestBootstrap.php ${SCOPE}
