FROM openjdk:8u212-slim-stretch

RUN apt-get update && apt-get install -y bash wget unzip libwebkitgtk-1.0-0 libxtst6 mysql-client

# Software
WORKDIR /tmp
RUN wget https://razaoinfo.dl.sourceforge.net/project/pentaho/Data%20Integration/7.1/pdi-ce-7.1.0.0-12.zip
RUN unzip pdi-ce-7.1.0.0-12.zip
RUN mv data-integration /opt/data-integration

# Lib
WORKDIR /tmp
RUN wget http://ftp.iij.ad.jp/pub/db/mysql/Downloads/Connector-J/mysql-connector-java-5.1.46.tar.gz
RUN tar -zxvf mysql-connector-java-5.1.46.tar.gz
RUN mkdir -p /opt/data-integration/plugins/databases/pdi-mysql-plugin/lib
RUN mv \
  /tmp/mysql-connector-java-5.1.46/mysql-connector-java-5.1.46.jar \
  /opt/data-integration/plugins/databases/pdi-mysql-plugin/lib/mysql-connector-java-5.1.46.jar
RUN ln \
  /opt/data-integration/plugins/databases/pdi-mysql-plugin/lib/mysql-connector-java-5.1.46.jar \
  /opt/data-integration/lib/mysql-connector-java-5.1.46.jar

# Cleanup
WORKDIR /opt/data-integration
RUN apt-get clean && \
  apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /tmp/* \
  rm -rf samples docs *.bat *.txt *.html

# Project
RUN mkdir /etl
COPY run.sh /etl/run.sh

# Run
VOLUME [ "/etl" ]
ENV KITCHEN_PATH /opt/data-integration/kitchen.sh
WORKDIR /etl
CMD [ "/etl/run.sh" ]
