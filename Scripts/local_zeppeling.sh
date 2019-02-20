#!/bin/sh

ZEPPELIN_HOME="${HOME}/Programas/BDA/zeppelin-0.8.1-bin-all"
SPARK_HOME="${HOME}/Programas/BDA/spark-2.3.3-bin-hadoop2.7"

export SPARK_HOME

SPARK_SUBMIT_OPTIONS="--packages mysql:mysql-connector-java:8.0.15"

export SPARK_SUBMIT_OPTIONS

if [ "$1" == "start" ]
then
  # Start spark
  cd $SPARK_HOME
  ./sbin/start-master.sh
  ./sbin/start-slave.sh spark://0.0.0.0:7077

  # Start Zeppelin
  cd $ZEPPELIN_HOME
  ./bin/zeppelin-daemon.sh start

elif [ "$1" == "stop" ]
then
  # stop Zeppelin
  cd $ZEPPELIN_HOME
  ./bin/zeppelin-daemon.sh stop

  # stop spark
  cd $SPARK_HOME
  ./sbin/stop-slave.sh spark://0.0.0.0:7077
  ./sbin/stop-master.sh
else
  echo "Use start or stop"
fi
