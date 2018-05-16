FROM ubuntu:18.04

ARG VCS_REF=unknown
ARG BUILD_DATE=unknown
ARG VERSION=0.0
LABEL maintainer="cseelye@gmail.com" \
      url="https://github.com/cseelye/docker-linux-shell" \
      name="docker-linux-shell" \
      description="Interactive linux shell" \
      vcs-ref=$VCS_REF \
      build-date=$BUILD_DATE \
      version=$VERSION

ENV TERM=xterm-color

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get --assume-yes dist-upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes \
        aptitude \
        ack-grep \
        build-essential \
        curl \
        git \
        inetutils-ping \
        inetutils-telnet \
        inetutils-traceroute \
        ipmitool \
        jq \
        libvirt-bin \
        libvirt-dev \
        man \
        mercurial \
        net-tools \
        nfs-common \
        openssh-client \
        pkg-config \
        pigz \
        rsync \
        sshpass \
        sysstat \
        tree \
        vim \
        virt-top \
        virt-what \
        wget && \
    apt-get autoremove --assume-yes && \
    apt-get clean && \
    rm --force --recursive /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Setup locale
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install locales && \
    locale-gen en_US && \
    locale-gen en_US.UTF-8 && \
    localedef -i en_US -c -f UTF-8 en_US.UTF-8 && \
    update-locale && \
    apt-get autoremove --assume-yes && \
    apt-get clean && \
    rm --force --recursive /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Python stuff
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install \
        libffi-dev \
        libssl-dev \
        python \
        python-dev \
        python3 \
        python3-dev && \
    curl https://bootstrap.pypa.io/get-pip.py | python3 && \
    curl https://bootstrap.pypa.io/get-pip.py | python2 && \
    pip3 install --upgrade six && \
    pip3 install --upgrade awscli paramiko requests future pylint && \
    pip2 install --upgrade six && \
    pip2 install --upgrade awscli paramiko requests future pylint && \
    curl https://raw.githubusercontent.com/cseelye/pylinter/master/pylint2 -o /usr/local/bin/pylint2 && \
    curl https://raw.githubusercontent.com/cseelye/pylinter/master/pylint3 -o /usr/local/bin/pylint3 && \
    chmod +x /usr/local/bin/pylint* && \
    apt-get autoremove --assume-yes && \
    apt-get clean && \
    rm --force --recursive /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Ruby and travis-ci
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install \
        ruby \
        ruby-dev && \
    gem install travis && \
    apt-get autoremove --assume-yes && \
    apt-get clean && \
    rm --force --recursive /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Docker binaries
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes \
        apt-transport-https \
        ca-certificates \
        lsb-release \
        software-properties-common && \
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) edge" > /etc/apt/sources.list.d/docker.list && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes docker-ce && \
    curl -L https://github.com/docker/compose/releases/download/$(curl https://api.github.com/repos/docker/compose/releases | jq -r '.[0].name')/docker-compose-$(uname -s)-$(uname -m) > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    apt-get autoremove --assume-yes && \
    apt-get clean && \
    rm --force --recursive /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
