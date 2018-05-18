#!/bin/bash
set -e

#colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

printf "${GREEN}What port you want the app to be exposed on your machine?.${NC}\nE.g. 80 or 8080. Press ENTER to use 80 default port.\n"
    read PORT

if [ "$PORT" = "" ] ; then
    PORT=80
fi

printf "${GREEN}Starting the app at ${PORT} port!${NC}\n"
sleep 1

docker run -p "${PORT}:80" --rm kmotrebski/blog-app-1:prod
