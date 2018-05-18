#!/usr/bin/env bash
set -ev

clear

#colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

source ./.env

# build Docker images

docker run --rm --interactive --tty \
    -v $(pwd):/app \
    --user $(id -u):$(id -g) \
    --name composer \
    composer:1.6.3 install --no-interaction --ignore-platform-reqs -vvv

docker build -t ${DOCKER_REG}/blog-app-1:dev -f docker/DockerfileDev  .
docker build -t ${DOCKER_REG}/blog-app-1:prod -f docker/DockerfileProd --build-arg DOCKER_REG=${DOCKER_REG} .
docker build -t ${DOCKER_REG}/blog-app-1:debug -f docker/DockerfileDebug --build-arg DOCKER_REG=${DOCKER_REG} .

# run unit tests

docker run \
        --volume $(pwd):/var/www/html/blog-app \
        --name unit_tests \
        --rm \
        ${DOCKER_REG}/blog-app-1:dev \
        vendor/phpunit/phpunit/phpunit --bootstrap tests/php/Unit/TestBootstrap.php tests/php/Unit

# run end-2-end test against dev container

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

# run production container

docker run -d \
        --name run_e2e \
        -p "${HTTP_PORT}:80" \
        --rm \
        kmotrebski/blog-app-1:prod

until [ "200" = $(curl --write-out %{http_code} --silent --output /dev/null localhost:${HTTP_PORT}) ]; do
    printf "${YELLOW}Waiting for container to start up...${NC}\n"
    sleep 1
done

docker stop run_e2e

printf "${GREEN}Build finished with success!${NC}\n"
