#!/bin/bash
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

USAGE=$"Usage: run_docker <meta> <event> <model> <command>
  Where:
    meta         = [PGSQL,ELASTICSEARCH,ELASTICSEARCH1]
    event        = [PGSQL,HBASE]
    model        = [PGSQL,LOCALFS,HDFS]
    command      = command to run in the container"

if ! [[ "$1" =~ ^(PGSQL|ELASTICSEARCH|ELASTICSEARCH1)$ ]]; then
  echo "$USAGE"
  exit 1
fi

if ! [[ "$2" =~ ^(PGSQL|HBASE|ELASTICSEARCH)$ ]]; then
  echo "$USAGE"
  exit 1
fi

if ! [[ "$3" =~ ^(PGSQL|LOCALFS|HDFS)$ ]]; then
  echo "$USAGE"
  exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker-compose -f $DIR/docker-compose.yml run \
  -e PIO_STORAGE_REPOSITORIES_METADATA_SOURCE=$1 \
  -e PIO_STORAGE_REPOSITORIES_EVENTDATA_SOURCE=$2 \
  -e PIO_STORAGE_REPOSITORIES_MODELDATA_SOURCE=$3 \
  pio-testing $4
