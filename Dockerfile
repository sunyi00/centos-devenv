FROM centos:7.2.1511

ENV GO_VERSION=1.6.2 \
    NODEJS_VERSION=v6.2.2 \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8 \
    GOPATH=/go \
    PATH=/usr/local/go/bin:/go/bin:$PATH

RUN yum -y update \
    && yum -y install epel-release gcc make git tar mariadb-devel libffi-devel openssl-devel unzip wget curl iproute bind-utils \
    && localedef -c -f UTF-8 -i en_US en_US.UTF-8 \
    && rm -f /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && cd /tmp \
    && curl -O https://nodejs.org/dist/$NODEJS_VERSION/node-$NODEJS_VERSION-linux-x64.tar.gz \
    && tar --strip-components 1 -xzf node-$NODEJS_VERSION-linux-x64.tar.gz -C /usr/local \
    && curl -OL https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz \
    && tar -zxf go$GO_VERSION.linux-amd64.tar.gz -C /usr/local \
    && mkdir -p /go/src /go/bin /go/pkg \
    && yum install -y python-pip libevent-devel python-backports-lzma python-devel \
    && pip install --upgrade pip virtualenv virtualenvwrapper \
    && yum -y clean all \
    && rm -rf /tmp/* \
