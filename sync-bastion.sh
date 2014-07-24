#!/bin/bash
watchmedo shell-command --command=" \
    rsync -avz \
    -e ssh \
    --delete \
    --exclude-from .rsyncignore \
    . $1"
