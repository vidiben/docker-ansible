#!/bin/bash

docker run -ti \
    -v $(readlink -f ~/.ssh):/home/user/.ssh:ro \
    -v $(readlink -f .):/home/user/ansible \
    -v $SSH_AUTH_SOCK:/ssh-agent \
    -e SITE_UID=$(id -u) -e SITE_GID=$(id -g) \
    -e http_proxy=$http_proxy -e https_proxy=$https_proxy \
    vidiben/ansible $*
