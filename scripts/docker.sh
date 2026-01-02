#!/bin/bash

COMPOSE_PATH=${DOTFILES_DIR}/docker-compose.yml

docker compose -f ${COMPOSE_PATH} up -d --remove-orphans
