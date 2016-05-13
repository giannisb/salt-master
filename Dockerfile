FROM centos:centos7

MAINTAINER Giannis Betas

RUN yum -y update && \
yum -y install epel-release && \
yum -y install wget && \
wget https://repo.saltstack.com/yum/rhel7/SALTSTACK-GPG-KEY.pub && \
rpm --import SALTSTACK-GPG-KEY.pub && \
rm -f SALTSTACK-GPG-KEY.pub && \
yum clean all

COPY saltstack.repo /etc/yum.repos.d/

RUN yum clean expire-cache && \
yum -y update && \
yum -y install salt-master

RUN useradd -r -s /bin/false salt -d  /var/cache/salt && \
mkdir /var/run/salt && \
chown -R salt /etc/salt /var/cache/salt /var/log/salt /var/run/salt

EXPOSE 4505 4506

ENTRYPOINT [ "salt-master" ]
