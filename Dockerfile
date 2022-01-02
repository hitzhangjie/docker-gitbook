FROM hitzhangjie/centos:latest

MAINTAINER hitzhangjie

ENV GIT_SSL_NO_VERIFY=true GIT_TERMINAL_PROMPT=1

USER root

COPY bash/bashrc /root/.bashrc
COPY git/gitconfig /etc/gitconfig

RUN sed -i 's/tsflags=nodocs/#tsflags=nodocs/' /etc/yum.conf                        && \
    rm -rf /etc/yum.repos.d && mkdir /etc/yum.repos.d                               && \
    curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.cloud.tencent.com/repo/centos7_base.repo && \
    yum install -y sudo which git epel-release                                      && \
    yum install -y nodejs                                                           && \
    yum clean all                                                                   && \
    npm install -g gitbook-cli
RUN gitbook fetch 3.2.3

WORKDIR /root/gitbook

EXPOSE 4000 35729

CMD gitbook install && gitbook serve

