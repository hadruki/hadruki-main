# hadruki

## Build and Deployment

### Developer workflow

#### First time setup

Execute all or some of these steps

- Create an S3 bucket to contain the `dot_stack_linux.tbz` file.
```
aws s3api create-bucket --bucket dot_stack_linux --region eu-west-1 --create-bucket-configuration LocationConstraint=eu-west-1

Output: 
{
    "Location": "http://dot-stack-linux.s3.amazonaws.com/"
}
```

- Upload the `dot_stack_linux.tbz` file


To make docker work, first unzip `dot_stack_linux.tbz` into the existing .stack-work

```
tar -xvf dot_stack_linux.tbz
```

####

stack build
stack exec hadruki
git commit -m "..."
git push

### Producing a linux artifact

The philosophy is to use docker to produce a linux artifact.
Stack supports docker builds but it doesn't work for me (see below in `Stack integration`).
fpco/stack-build didn't work either (see below in `fpco/stack-build`).

Eventually we roll our own Dockerfile, based on debian:stretch.

To build:

```
docker build -t hadruki .
```

To run
```
docker run -ti --mount type=bind,target=`pwd`,source=`pwd` --mount type=bind,target=/root/.stack,source=/Users/dvekeman/.stack_linux --ulimit nofile=98304:98304 hadruki /bin/bash
```

To build automatically
```
docker run -ti --mount type=bind,target=`pwd`,source=`pwd` --mount type=bind,target=/root/.stack,source=/Users/dvekeman/.stack_linux --ulimit nofile=98304:98304 hadruki /src/hadruki-server/hadruki/bin/stack-build-linux.sh
```



#### Stack integration
https://docs.haskellstack.org/en/stable/docker_integration/

FAILED
```
Downloading Docker-compatible stack executable
Control.Exception.Safe.throwString called with:

Could not get release information for Stack from: https://api.github.com/repos/commercialhaskell/stack/releases/tags/v1.7.0
Called from:
  throwString (src/Stack/Setup.hs:1820:14 in stack-1.7.0-823urjatlpOBQdmrFEZ85x:Stack.Setup)
```

#### fpco/stack-build
Issue: 

```
strip:/root/.stack/programs/x86_64-linux/ghc-8.0.2/lib/ghc-8.0.2/base-4.9.1.0/stN8SiVq/Types__724.o: Too many open files
make[1]: *** [install_packages] Error 1
make: *** [install] Error 2


Error: Error encountered while installing GHC with
         make install
         run in /root/.stack/programs/x86_64-linux/ghc-8.0.2.temp/ghc-8.0.2/

       The following directories may now contain files, but won't be used by stack:
         - /root/.stack/programs/x86_64-linux/ghc-8.0.2.temp/
         - /root/.stack/programs/x86_64-linux/ghc-8.0.2/
 ```
 
#### Manual setup

(!) Use the same user as in docker, for now that means root!

Inside a debian stretch virtual machine, create a stack project with the desired resolver.

