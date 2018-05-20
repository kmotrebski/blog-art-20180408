#!/usr/bin/env bash

# This script sets up variables that are going to be used in build.sh script
# in main directory.

if [ ! -f .env ]; then
    touch .env
fi

source ./.env

if [ "$TRAVIS" = "true" ]; then
    printf "${GREEN}Looking for values in Travis env variables.${NC}\n"
    DOCKER_REG="${TRAVIS_ART1_DOCKER_REG:-kmotrebski}"
    HTTP_PORT="${DOCKER_ART1_HTTP_PORT:-80}"
fi
