FROM centos:7
MAINTAINER Okada Hayato

WORKDIR /cloud9

RUN yum -y update \
    && yum -y install epel-release \
    && yum -y install nodejs npm \
    && yum -y install git \
    && yum -y install which \
    && yum groupinstall -y development \
    && yum install -y glibc-static \
    && git clone git://github.com/c9/core.git c9sdk \
    && cd c9sdk \
    && scripts/install-sdk.sh

EXPOSE 8080

ENTRYPOINT ["node"]
CMD ["/cloud9/c9sdk/server.js"]
