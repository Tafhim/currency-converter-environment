#!/bin/bash
# Go to the source directory
cd "$( dirname "${BASH_SOURCE[0]}" )"

# Shut down and clean up
docker-compose down --remove-orphans