#!/usr/bin/env bash
set -e

#colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

#todo DOCKER_REG rename na DOCKER_REG_LOGIN

#set up DOCKER_REG and DOCKER_REG_PASSWORD variable
source build/setup_push_variables.sh

# push Docker images to the repository

eval "docker login --username ${DOCKER_REG} --password ${DOCKER_REG_PASSWORD}"

docker push ${DOCKER_REG}/blog-app-1:dev
docker push ${DOCKER_REG}/blog-app-1:prod
docker push ${DOCKER_REG}/blog-app-1:debug
