#!/bin/bash
set -e

clear

CONTAINER_NAME="unit_tests"
SCOPE="tests/php/Unit"

#colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

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

docker run -d \
        --volume $(pwd):/var/www/html/blog-app \
        --name run_e2e \
        -p "${HTTP_PORT}:80" \
        --rm \
        ${DOCKER_REG}/blog-app-1:dev

until [ "200" = $(curl --write-out %{http_code} --silent --output /dev/null localhost:${HTTP_PORT}) ]; do
    printf "${YELLOW}Waiting for container to start up...${NC}\n"
    sleep 1
done

docker stop run_e2e

printf "${GREEN}Build finished with success!${NC}\n"
