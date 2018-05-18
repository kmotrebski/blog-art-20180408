#!/usr/bin/env bash

# Add DOCKER_REG_PASS if missing

if ! grep "DOCKER_REG_PASS" .env > /dev/null
then

    echo "Password to Docker Hub.".
    read DOCKER_REG_PASS

    echo "DOCKER_REG_PASS=${DOCKER_REG_PASS}" >> .env
fi

source ./.env

# push Docker images to the repository

docker login --username ${DOCKER_REG} --password ${DOCKER_REG_PASS}

docker push ${DOCKER_REG}/blog-app-1:dev
docker push ${DOCKER_REG}/blog-app-1:prod
docker push ${DOCKER_REG}/blog-app-1:debug
