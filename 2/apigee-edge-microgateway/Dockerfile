FROM ubuntu:yakkety

MAINTAINER Fabrizio Torelli <fabrizio.torelli@wipro.com>

ENV EDGEMICRO_ORG="" \
    EDGEMICRO_ENV=""  \
    EDGEMICRO_USER="" \
    EDGEMICRO_PASS="" \
    EDGEMICRO_CONSUMER_CREDENTIALS="" \
    EDGEMICRO_PRIVATE_CLOUD="no" \
    EDGEMICRO_ROUTER="" \
    EDGEMICRO_API_MNGMT="" \
    PATH=$PATH:/usr/bin/local

USER root

ADD template /root/template

RUN apt-get update

RUN apt-get install -y python-software-properties curl wget sudo vim  && curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -

RUN apt-get install -y nodejs openssl* net-tools

RUN apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*;

RUN npm install -g edgemicro@2.3.5

COPY start-edgemicro.sh /usr/bin/local/start-edgemicro.sh

COPY stop-edgemicro.sh /usr/bin/local/stop-edgemicro.sh

RUN chmod 777 /usr/bin/local/start-edgemicro.sh && \
    chmod 777 /usr/bin/local/stop-edgemicro.sh

CMD ["/bin/sh", "-c", "/usr/bin/local/start-edgemicro.sh"]

EXPOSE 8000
