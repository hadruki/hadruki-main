#!/bin/bash

docker run -ti --mount type=bind,target=`pwd`,source=`pwd` --mount type=bind,target=/root/.stack,source=/Users/dvekeman/.stack_linux --ulimit nofile=98304:98304 hadruki /src/hadruki-server/hadruki/bin/stack-build-linux.sh

bin/deploy-to-th-bagua.sh
