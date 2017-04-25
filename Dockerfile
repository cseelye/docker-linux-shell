FROM ubuntu:16.04
LABEL maintainer="cseelye@gmail.com"

ENV TERM=xterm-256color
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
        libpng-dev \
        libterm-readline-gnu-perl \
        libvirt-bin \
        libvirt-dev \
        libx11-dev \
        man \
        mercurial \
        net-tools \
        nfs-common \
        openssh-client \
        pkg-config \
        pigz \
        python2.7 \
        python2.7-dev \
        rsync \
        sshpass \
        sysstat \
        vim \
        wget \
        xterm && \
    curl https://bootstrap.pypa.io/get-pip.py | python2.7 && \
    apt-get autoremove && \
    apt-get clean && \
    rm --force --recursive /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip install --upgrade \
        awscli \
        paramiko \
        requests
RUN (echo y;echo o conf prerequisites_policy follow;echo o conf commit) | cpan  && \
    ln -s /bin/tar /usr/bin/tar && \
    ln -s /bin/gzip /usr/bin/gzip && \
    cpan -f install CPAN::WAIT CPAN::Changes Exception::Class Readonly Test::DistManifest Test::PerlTidy Test::Pod::Coverage Tk App::ClusterSSH


