# Currency converter

## Overview
A simple application backed by Zend framework and Docker containers that converts currencies

## Requirements
- docker, please follow your distro's installatio procedure
- docker-compose ```sudo pip install docker-compose```
- git
- xargs
- sed
- awk


## Installation
```bash
git clone --recursive -j8 git@github.com:Tafhim/currency-converter-environment.git currency_converter
cd currency_converter
./start.sh
```
## Note
- If you face permission denied issues when trying to edit code, go into docker/php/entrypoint.sh and change the USER_ID value to your own UNIX user ID, you can find that out using the command ```id```
- Some config files are being ignored by the git repo, such as docker-compose.yml
- Please don't delete the ```instance``` file. It's the installation ID that helps avoid container name collisions

Please provide feedback and suggestions to help me improve this.