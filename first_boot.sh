#!/bin/bash
# Go into source directory
cd ./public/

# pull the current branch
git pull origin $(git branch | grep \* | awk -F ' ' '{ print $2 }')

# Start it all up
docker-compose down --remove-orphans && docker-compose build && docker-compose up -d

# Pull using composer
docker exec -ti -u tafhim zend-cconvert-php bash -c "cd /var/www/html/public && composer install"

# Migrate db imports
docker exec -ti -u tafhim zend-cconvert-php bash -c "cd /var/www/html/public && php /var/www/html/public/vendor/robmorgan/phinx/bin/phinx migrate"
docker exec -ti -u tafhim zend-cconvert-php bash -c "cd /var/www/html/public && php /var/www/html/public/vendor/robmorgan/phinx/bin/phinx seed:run"
