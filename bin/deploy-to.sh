#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

scp .stack-work/dist/x86_64-linux-nopie/Cabal-1.24.2.0/build/hadruki-exe/hadruki-exe admin@$1:/tmp/hadruki
ssh admin@$1 'bash -s' < ${dir}/redeploy-hadruki.sh
