#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM predictionio/pio

ENV SPARK_VERSION 1.4.0
#ENV ELASTICSEARCH_VERSION 1.4.4
ENV ELASTICSEARCH_VERSION 5.1.2
ENV HBASE_VERSION 1.0.0

ADD docker-files/spark-${SPARK_VERSION}-bin-hadoop2.6.tgz /vendors
ENV SPARK_HOME /vendors/spark-${SPARK_VERSION}-bin-hadoop2.6

<<<<<<< HEAD
RUN echo "== Installing Elasticsearch =="
#RUN wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz
RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz
RUN tar zxvfC elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz /vendors
RUN rm elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz
ENV ELASTICSEARCH_HOME /vendors/elasticsearch-${ELASTICSEARCH_VERSION}

RUN echo "== Installing HBase =="
RUN wget http://archive.apache.org/dist/hbase/hbase-${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz
RUN tar zxvfC hbase-${HBASE_VERSION}-bin.tar.gz /vendors
RUN rm hbase-${HBASE_VERSION}-bin.tar.gz
ENV HBASE_HOME /vendors/hbase-${HBASE_VERSION}

RUN echo "== Downloading database drivers =="
RUN mkdir drivers
RUN wget https://jdbc.postgresql.org/download/postgresql-9.4-1204.jdbc41.jar -P /drivers

RUN mkdir PredictionIO
ENV PIO_HOME /PredictionIO
ENV PATH ${PIO_HOME}/bin/:${PATH}
ENV HOST_PIO_HOME /pio_host

RUN echo "== Setting configs =="
=======
COPY docker-files/postgresql-9.4-1204.jdbc41.jar /drivers
>>>>>>> 09504bdb0ca14657e9aa9a39af27632786ab112a
COPY docker-files/init.sh init.sh
COPY docker-files/env-conf/hbase-site.xml ${PIO_HOME}/conf/hbase-site.xml
COPY docker-files/env-conf/pio-env.sh /pio-env.sh
COPY docker-files/wait-for-postgres.sh /wait-for-postgres.sh
COPY docker-files/pgpass /root/.pgpass
RUN chmod 600 /root/.pgpass

# Default repositories setup
ENV PIO_STORAGE_REPOSITORIES_METADATA_SOURCE PGSQL
ENV PIO_STORAGE_REPOSITORIES_EVENTDATA_SOURCE PGSQL
ENV PIO_STORAGE_REPOSITORIES_MODELDATA_SOURCE PGSQL

# JVM settings
ENV JVM_OPTS '-Dfile.encoding=UTF8 -Xms2048M -Xmx2048M -Xss8M -XX:MaxPermSize=512M -XX:ReservedCodeCacheSize=256M'

# Expose relevant ports
# pio engine
EXPOSE 8000
# eventserver
EXPOSE 7070

ENTRYPOINT ["/init.sh"]
CMD 'bash'
