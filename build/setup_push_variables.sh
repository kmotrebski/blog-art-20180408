#!/usr/bin/env bash

# This script sets up variables that are going to be used in push.sh script
# in main directory. Goal is to set up credentials to log in to Docker Hub.

# When running on Travis

if [ "$TRAVIS" = "true" ]; then
    printf "${GREEN}Looking for values in Travis env variables.${NC}\n"

    if [[ -z "${TRAVIS_ART1_DOCKER_REG}" ]]; then
        printf "${RED}Aborting deployment as login to Docker Hub is not set up. Have a look at README file, \"Forking\" section, for details.${NC}\n"
        exit 0
    fi

    if [[ -z "${TRAVIS_ART1_DOCKER_REG_PASSWORD}" ]]; then
        printf "${RED}Aborting deployment as password to Docker Hub is not set up. Have a look at README file, \"Forking\" section, for details.${NC}\n"
        exit 0
    fi

    DOCKER_REG="${TRAVIS_ART1_DOCKER_REG}"
    DOCKER_REG_PASSWORD="${TRAVIS_ART1_DOCKER_REG_PASSWORD}"
fi

# When running locally

if [ "$TRAVIS" != "true" ]; then

    if ! grep "DOCKER_REG_PASSWORD" .env > /dev/null
    then

        echo "Password to Docker Hub.".
        read DOCKER_REG_PASSWORD

        echo "DOCKER_REG_PASSWORD=${DOCKER_REG_PASSWORD}" >> .env
    fi

    source ./.env
fi
