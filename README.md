# docker-linux-shell
Docker container for an interactive linux shell

Docker Hub: https://hub.docker.com/r/cseelye/linux-shell/

Github: https://github.com/cseelye/docker-linux-shell

## Features
* Ubuntu 16.04 based shell with all of the standard GNU command line tools you expect (awk, sed, cut, etc.)
* Variety of tools such as build tools, SSH client, curl, wget, ping, taceroute, jq, ipmitool, vim, tar, pigz, etc.
* X11 support, so you can run GUI apps
* Docker client binaries, so you can control other containers (docker, docker-compose)
* Virt management tools (libvirt, virt-manager, virt-top, etc.)

## Usage
The linux-shell script should be run on the host to launch a shell. The script will automatically mount the X11 and docker sockets, so those features work, as well as mount your home directory into the container.

When run, the script will start a new container and launch an interactive shell in it. Or if the --shared arg is used with the script, the script will attempt to find an existing container and exec a new interactive shell in it, or launch a new container if one is not running.

There are some environment variables that can tweak the script behavior:
* ```LINUX_SHELL_CONTAINER_NAME``` can be set to override the name prefix of the containers that are launched
* ```LINUX_SHELL_RUN_OPTIONS``` can be set to add additional options to the docker run command
