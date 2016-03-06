FROM ubuntu:trusty
MAINTAINER Loïc CORBASSON <loic.corbasson@gmail.com>

ENV DEBIAN_FRONTEND noninteractive 
RUN apt-get update && apt-get install -y --no-install-recommends \ 
    bash \
    devscripts \ 
    dpkg-dev \
    equivs 
#    build-essential \ 
#    curl \ 
#    debhelper \
#    devscripts \ 
#    dpkg-dev \
#    equivs \ 
#    git-buildpackage \ 
#    git \ 
#    lsb-release \ 
#    make \ 
#    openssh-client \ 
#    wget

COPY ./docker-entrypoint.sh /

RUN useradd packaging \
   && mkdir -p /packaging \
   && chown packaging /packaging

WORKDIR packaging
#USER packaging # we still need root for now for mk-build-deps

ENTRYPOINT ["/docker-entrypoint.sh"]

