# docker-linux-shell [![Build Status](https://travis-ci.org/cseelye/docker-linux-shell.svg?branch=master)](https://travis-ci.org/cseelye/docker-linux-shell)
Docker container for an interactive linux shell. I use this to have a standard command line environment that I can 
run on any host I am using.

Docker Hub: https://hub.docker.com/r/cseelye/linux-shell/  
Github: https://github.com/cseelye/docker-linux-shell

Tags:  
`cseelye/linux-shell:xenial` (basic shell) [Dockerfile](https://github.com/cseelye/docker-linux-shell/blob/xenial/Dockerfile)  
`cseelye/linux-shell:xenial-x11` (basic shell plus X11 support and some GUI apps)  [Dockerfile](https://github.com/cseelye/docker-linux-shell/blob/xenial/Dockerfile-x11)

## Features
* Ubuntu 16.04 based shell with all of the standard GNU command line tools you expect (awk, sed, cut, etc.)
* Variety of tools such as build tools, SSH client, curl, wget, ping, traceroute, jq, ipmitool, vim, tar, pigz, etc.
* Docker client binaries, so you can control other containers (docker, docker-compose)
* Virt management tools (libvirt, virsh, virt-top, etc.)
* Optional X11 support, so you can run GUI apps (use the `-x11` tag if you want this)

## Usage
The linux-shell script should be run on the host to launch a shell. The script will automatically mount the X11 and docker sockets, so those features work, as well as mount your home directory into the container.

When run, the script will start a new container and launch an interactive shell in it. Or if the --shared arg is used with the script, the script will attempt to find an existing container and exec a new interactive shell in it, or launch a new container if one is not running.

There are some environment variables that can tweak the script behavior:
* ```LINUX_SHELL_CONTAINER_NAME``` can be set to override the name prefix of the containers that are launched
* ```LINUX_SHELL_RUN_OPTIONS``` can be set to add additional options to the docker run command
