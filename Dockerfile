FROM ubuntu:16.04
LABEL maintainer="cseelye@gmail.com"

ENV TERM=xterm-256color
ARG python_modules="awscli paramiko requests"

RUN apt-get update && \
    apt-get --assume-yes dist-upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes \
        aptitude \
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
        vim \
        wget && \
    apt-get autoremove && \
    apt-get clean && \
    rm --force --recursive /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Python stuff
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install \
        libffi-dev \
        libssl-dev \
        python2.7 \
        python2.7-dev \
        python3 \
        python3-dev && \
    curl https://bootstrap.pypa.io/get-pip.py | python3 && \
    curl https://bootstrap.pypa.io/get-pip.py | python2 && \
    pip2 install --upgrade $python_modules && \
    pip3 install --upgrade $python_modules && \
    apt-get autoremove && \
    apt-get clean && \
    rm --force --recursive /var/lib/apt/lists/* /tmp/* /var/tmp/*
# ClusterSSH and perl stuff
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get --assume-yes install \
        libpng-dev \
        libterm-readline-gnu-perl \
        libx11-dev \
        xterm && \
    (echo y;echo o conf prerequisites_policy follow;o conf build_cache 50;echo o conf commit) | cpan  && \
    ln -s /bin/tar /usr/bin/tar && \
    ln -s /bin/gzip /usr/bin/gzip && \
    cpan -f install CPAN::WAIT CPAN::Changes Exception::Class Readonly Test::DistManifest Test::PerlTidy Test::Pod::Coverage Tk App::ClusterSSH && \
    apt-get autoremove && \
    apt-get clean && \
    rm --force --recursive /var/lib/apt/lists/* /tmp/* /var/tmp/* /root/.cpan/build/* /root/.cpan/rouces/authors/id

