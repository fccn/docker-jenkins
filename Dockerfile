FROM jenkinsci/blueocean

LABEL maintainer="Paulo Costa <paulo.costa@fccn.pt>"

#--- set docker group id depending on the id in the host
ARG DOCKER_GID=999
ENV TZ=Europe/Lisbon

USER root

#add testing and community repositories
#------ install required tools
#------ set timezone
RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
  && echo '@community http://nl.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
  && echo '@edge http://nl.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
  &&  apk update && apk upgrade --no-cache --available \
  && apk add --upgrade apk-tools@edge \
  && apk add --no-cache --upgrade ca-certificates shadow tzdata && update-ca-certificates \
  && rm -rf /var/cache/apk/* \
# Change TimeZone
 && cp /usr/share/zoneinfo/Europe/Lisbon /etc/localtime \
#-- add jenkins user to server docker group
 ; usermod -aG ${DOCKER_GID} jenkins

USER jenkins 