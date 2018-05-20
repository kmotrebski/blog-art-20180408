#!/bin/bash
set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [ -e .env ]; then
    printf "${RED}.env is already present. Please fill it in the missing configuration (if any at all). If you want to use this configuration helper then you have to delete the .env file and start again. If you want to start an app then run a run.sh script.${NC}\n"
    exit
fi

# Add "DOCKER_REG" field if missing

if ! grep "DOCKER_REG" .env > /dev/null
then

    echo "DOCKER_REG=kmotrebski" >> .env
fi

# Add HTTP_PORT if missing

if ! grep "HTTP_PORT" .env > /dev/null
then

    echo "HTTP port you want the app to be exposed at. Press enter if you want to use default 80 port."
    read HTTP_PORT

    if [ "$HTTP_PORT" = "" ] ; then
        HTTP_PORT=80
    fi

    echo "HTTP_PORT=${HTTP_PORT}" >> .env
fi

# Add "D_COMP_PR_NAME" field if missing

if ! grep "D_COMP_PR_NAME" .env > /dev/null
then

    echo "D_COMP_PR_NAME=otr_1" >> .env
fi

# Finished!
# Show the file to the user.

printf "Configuration finished! Here is how the file looks now: \n\n"

printf "# # # # # START # # # # #\n"
cat .env
printf "\n# # # # # STOP # # # # # \n"

sleep 1

printf "Starting the project...\n"

sleep 1

source .env

docker run --rm --interactive --tty \
    -v $(pwd):/app \
    --env SSH_AUTH_SOCK=/ssh-auth.sock \
    --volume $SSH_AUTH_SOCK:/ssh-auth.sock \
    --volume /etc/passwd:/etc/passwd:ro \
    --volume /etc/group:/etc/group:ro \
    --volume ~/.ssh:/home/$(id -u -n)/.ssh \
    --user $(id -u):$(id -g) \
    --name composer \
    composer:1.6.3 install --no-interaction --ignore-platform-reqs -vvv

docker-compose -p ${D_COMP_PR_NAME} up --abort-on-container-exit
