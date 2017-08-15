#!/bin/bash
# Go to the source directory
cd "$( dirname "${BASH_SOURCE[0]}" )"

# As a default, judge this run as not new
FIRST_RUN="no"

# Detect if it's actually the first run
if [ ! -e ./instance ]; then
    INSTANCE_KEY=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    echo $INSTANCE_KEY > ./instance
    FIRST_RUN="yes"
fi

# Load the instance ID
INSTANCE_ID="zend-cconvert-$(cat ./instance)"
echo "Instance ID: $INSTANCE_ID";

if [ $FIRST_RUN = "yes" ]; then
    grep -rl "zend-cconvert" . --exclude=.git --exclude=first_boot.sh | xargs sed -i "s/zend-cconvert/$INSTANCE_ID/g"
fi

# Go into source directory
cd ./public/

# pull the current branch
echo "Pulling latest changes to current branch: $(git branch | grep \* | awk -F ' ' '{ print $2 }')"
git pull origin $(git branch | grep \* | awk -F ' ' '{ print $2 }')

# Start it all up
docker-compose down --remove-orphans && docker-compose build && docker-compose up -d

# Pull using composer
docker exec -ti -u tafhim $INSTANCE_ID-php bash -c "cd /var/www/html/public && composer install"

# Run DB seeds and init
if [ $FIRST_RUN = "yes" ]; then
    # Migrate db imports
    echo "Running DB init scripts"
    docker exec -ti -u tafhim $INSTANCE_ID-php bash -c "cd /var/www/html/public && php /var/www/html/public/vendor/robmorgan/phinx/bin/phinx migrate"
    docker exec -ti -u tafhim $INSTANCE_ID-php bash -c "cd /var/www/html/public && php /var/www/html/public/vendor/robmorgan/phinx/bin/phinx seed:run"
fi

echo 'Setup complete! Go to: http://localhost:1234/'