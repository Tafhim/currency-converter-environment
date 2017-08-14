#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or
# fallback
USER_ID=1000
USER_NAME=tafhim

echo "Starting with UID : $USER_ID"
export HOME=/home/$USER_NAME
useradd --shell /bin/bash -u $USER_ID -o -c "" -m $USER_NAME -d $HOME

#adduser $USER_NAME --home $HOME --shell /bin/bash --uid $USER_ID --disabled-password --quiet --force-badname

#touch /home/$USER_NAME/.bashrc
if [ ! -f /home/$USER_NAME/.bashrc ]; then 
    echo "The .bashrc exists"
    chmod +x /home/$USER_NAME/.bashrc
    echo "su root" >> /home/$USER_NAME/.bashrc
    echo "chown -R $USER_NAME:$USER_NAME /var/www/html/public" >> /home/$USER_NAME/.bashrc
    echo "chown -R $USER_NAME:$USER_NAME /var/www/html/public/*"  >> /home/$USER_NAME/.bashrc
    echo "exit" >> /home/$USER_NAME/.bashrc
fi


#exec /usr/local/bin/gosu $USER_NAME bash "$@" 

