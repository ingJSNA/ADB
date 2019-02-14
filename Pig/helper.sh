#!/bin/bash

export PATH="${HADOOP_HOME}/bin/":$PATH

export PIG_HOME="$HOME/Programas/BDA/pig-0.17.0"
export PATH=$PIG_HOME/bin:$PATH

DATA_DIR="$HOME/workspace/BDA/ADB/Pig/data"

if [ "$1" == "start" ]
then
  # Start hadoop
  $HADOOP_HOME/bin/hdfs namenode -format
  $HADOOP_HOME/sbin/start-dfs.sh

  # Load data
  hdfs dfs -mkdir hdfs://localhost:9000/Pig_Data

  hdfs dfs -put $DATA_DIR/u.data /Pig_Data
  hdfs dfs -put $DATA_DIR/u.user /Pig_Data

elif [ "$1" == "stop" ]
then
  # Stop hadoop
  $HADOOP_HOME/sbin/stop-dfs.sh

else
  echo "Use start or stop"
fi
