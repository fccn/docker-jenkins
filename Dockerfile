FROM jenkinsci/blueocean:1.24.7

LABEL maintainer="Serviços Multimédia <multimedia@asa.fccn.pt>"

#--- set docker group id depending on the id in the host
ARG DOCKER_GID=999
ENV TZ=Europe/Lisbon

USER root

# change uid and gid for docker user
RUN apk --no-cache add shadow && \
  usermod -aG ${DOCKER_GID} jenkins && \
# Install python3, pip and virtualenv so we could run ansible within jenkins
  apk add --update python3 py3-pip py3-virtualenv && \
# update certificates
  update-ca-certificates && \
# clear apk cache
  rm -rf /var/cache/apk/*

# Change TimeZone
RUN cp /usr/share/zoneinfo/Europe/Lisbon /etc/localtime

USER jenkins 
