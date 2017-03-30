FROM bitnami/mongodb:3
MAINTAINER Fabrizio Torelli <fabrizio.torelli@wipro.com>

USER root

RUN apt-get update > /dev/null 2>&1 && apt-get install -y apt-utils > /dev/null 2>&1
RUN sudo apt-get install -y python-software-properties net-tools curl sudo > /dev/null 2>&1
RUN curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - > /dev/null 2>&1
RUN sudo apt-get install -y nodejs > /dev/null 2>&1

RUN apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*;

RUN mkdir -p /root/importdb

COPY ./data/ /root/importdb/

WORKDIR /root/importdb

RUN npm i

RUN /bin/bash -c "/run.sh &"  && \
sleep 15 && \
while [ -z "$(netstat -tulnp| grep 0.0.0.0:27017|grep LISTEN)" ]; do echo "Waiting mongodb to be up ..."; sleep 5; done && \
sleep 10 && \
node test_data/testdata1.js && \
node test_data/testdata2.js && \
node test_data/testdata3.js && \
node test_data/testdata4_Pensions.js && \
node test_data/testdata5.js

RUN apt-get -y remove nodejs > /dev/null 2>&1

RUN rm -f /etc/apt/sources.list.d/nodesource.list

RUN apt-get -y remove python-software-properties apt-utils net-tools > /dev/null 2>&1

RUN rm -Rf /usr/share/dh-python

RUN apt-get update && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*;

WORKDIR /

RUN rm -Rf /root/importdb

VOLUME ["/bitnami/mongodb"]

EXPOSE 27017

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["/run.sh"]
