#!/bin/bash

SITE_UID=${SITE_UID:-1013}
SITE_GID=${SITE_GID:-1013}

sed -ie "s|:1013:1013:|:$SITE_UID:$SITE_GID:|" /etc/passwd
sed -ie "s|user:x:1013:|user:x:$SITE_GID:|" /etc/group
mkdir /home/user/ansible
chown -R $SITE_UID:$SITE_GID /home/user

export SSH_AUTH_SOCK=/ssh-agent
chmod 0777 /ssh-agent

chmod a+rw /dev/console

if [ "$http_proxy" != "" ]; then
    echo "export http_proxy=$http_proxy" >> /home/user/.bashrc
fi
if [ "$https_proxy" != "" ]; then
    echo "export https_proxy=$https_proxy" >> /home/user/.bashrc
fi
if [ "$no_proxy" != "" ]; then
    echo "export no_proxy=\"$no_proxy\"" >> /home/user/.bashrc
fi

export TERM=xterm

if [ -f /root/service.sh ]; then
    . /root/service.sh
fi

cd /home/user/ansible
sudo -u user $@
