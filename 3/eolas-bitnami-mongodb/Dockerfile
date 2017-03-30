FROM bitnami/mongodb:3.4.2-r1
MAINTAINER Fabrizio Torelli <fabrizio.torelli@wipro.com>

USER root

RUN chmod 777 /*.sh

RUN apt-get update > /dev/null 2>&1 && apt-get install -y tar \
python-software-properties net-tools curl sudo > /dev/null 2>&1 && \
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash - > /dev/null 2>&1 && \
sudo apt-get install -y nodejs > /dev/null 2>&1 && \
apt-get -y autoremove > /dev/null 2>&1 && \
apt-get -y clean > /dev/null 2>&1 && \
rm -rf /var/lib/apt/lists/* && \
mkdir -p /root/importdb

COPY ./data/ /root/importdb/

WORKDIR /root/importdb

RUN npm i > /dev/null 2>&1 && \
/bin/bash -c "/app-entrypoint.sh nami start --foreground mongodb &"  && \
sleep 15 && \
while [ -z "$(netstat -tulnp| grep 0.0.0.0:27017|grep LISTEN)" ]; do echo "Waiting mongodb to be up ..."; sleep 5; done && \
sleep 10 && \
node test_data/testdata1.js && \
node test_data/testdata2.js && \
node test_data/testdata3.js && \
node test_data/testdata4_Pensions.js && \
node test_data/testdata5.js && \
tar -czf /root/mongod.tar.gz /bitnami/mongodb/* && \
apt-get -y remove nodejs > /dev/null 2>&1 && \
rm -f /etc/apt/sources.list.d/nodesource.list && \
apt-get -y remove python-software-properties net-tools > /dev/null 2>&1 && \
rm -Rf /usr/share/dh-python && \
apt-get update > /dev/null 2>&1 && \
apt-get -y autoremove > /dev/null 2>&1 && \
apt-get -y clean > /dev/null 2>&1 && \
rm -rf /var/lib/apt/lists/* && \
rm -Rf /root/importdb && \
echo "#!/bin/bash -e" > /tmp.sh && \
echo "" >> /tmp.sh && \
echo "# Restoring Eolas test data if it doesn't exist" >> /tmp.sh && \
echo "if ! [[ -e /bitnami/mongodb/data ]]; then" >> /tmp.sh && \
echo "  tar -xzf /root/mongod.tar.gz" >> /tmp.sh && \
echo "fi" >> /tmp.sh && \
echo "" >> /tmp.sh && \
cat /app-entrypoint.sh | grep -v bash >> /tmp.sh && \
cat /tmp.sh && \
cat /tmp.sh > /app-entrypoint.sh && \
rm -f /tmp.sh


WORKDIR /

VOLUME ["/bitnami/mongodb"]

EXPOSE 27017

ENTRYPOINT ["/app-entrypoint.sh"]

CMD ["/app-entrypoint.sh","nami","start","--foreground","mongodb"]
