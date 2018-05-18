#!/bin/bash

source ./.env

docker-compose -p ${D_COMP_PR_NAME} up --abort-on-container-exit
