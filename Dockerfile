# Dockerizing Kibana
# Dockerfile for building kibana on an ubuntu machine

# OS to use
FROM phusion/baseimage

# Provisioning
## Download the tarred file, untar, and place in the correct location
### Replace when github has Large File Storage activated
RUN apt-get update && apt-get install curl git -y
RUN curl -L https://download.elasticsearch.org/kibana/kibana/kibana-4.1.1-linux-x64.tar.gz | tar xvz -C /opt/ && mv /opt/kibana-4.1.1-linux-x64/ /opt/kibana/

## Install Governor binary
RUN mkdir -p /opt/governor
RUN git clone git://github.com/adsabs/governor.git /opt/governor/
RUN git -C /opt/governor pull && git -C /opt/governor reset --hard fb9273bb20fa4748d05901ad075de5b137246d2e
ENV CONSUL_HOST consul.adsabs
ENV CONSUL_PORT 8500

# Define the entry point for docker<->kibana
## GUI Interface for Kibana
EXPOSE 5601

# Copy configuration and run files
##
COPY resources/govern.conf /opt/governor/
COPY resources/kibana.sh /etc/service/kibana/run

# How the docker container is interacted with
##
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/sbin/my_init"]
