#!/bin/bash
docker-compose down --remove-orphans && docker-compose build && docker-compose up -d
# Go into source directory
cd ./public/
# pull the current branch
git pull origin $(git branch | grep \* | awk -F ' ' '{ print $2 }')
