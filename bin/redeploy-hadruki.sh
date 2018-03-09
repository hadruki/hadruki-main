#!/bin/bash

echo "Kill any existing servers if needed: " `lsof -i -P -n | grep 3000 | grep LISTEN | awk '{print $2}'`
lsof -i -P -n | grep 3000 | grep LISTEN | awk '{print $2}' | xargs -I {} kill -9 {}

cp /tmp/hadruki /var/hadruki/hadruki
cd /var/hadruki/
nohup ./hadruki

