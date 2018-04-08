#!/bin/bash

source ./.env

docker-compose -f docker-compose.yaml -p ${D_COMP_PR_NAME} up --abort-on-container-exit
