#!/bin/bash

. .conf

cd "$LAUNCHERDIR"
git pull
git reset --hard

sleep 3
exit 0
