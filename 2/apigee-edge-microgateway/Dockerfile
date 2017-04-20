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
    PATH=$PATH:/usr/local/bin

USER root

ADD template /root/template

RUN apt-get update

RUN apt-get install -y python-software-properties curl wget sudo vim  && curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -

RUN apt-get install -y nodejs openssl* net-tools && mkdir -p /usr/local/bin && chmod 755 /usr/local/bin

RUN apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*;

RUN npm install -g edgemicro@2.3.5

COPY start-edgemicro.sh /usr/local/bin/start-edgemicro

COPY stop-edgemicro.sh /usr/local/bin/stop-edgemicro

RUN chmod 777 /usr/local/bin/start-edgemicro && \
    chmod 777 /usr/local/bin/stop-edgemicro

CMD ["/bin/sh", "-c", "start-edgemicro"]

EXPOSE 8000
