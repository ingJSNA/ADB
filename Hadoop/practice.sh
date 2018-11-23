#!/bin/bash

# Enviroment variables
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")

echo "JAVA_HOME=$JAVA_HOME"

HADOOP_HOME="${HOME}/Programas/BDA/hadoop-3.1.1"

# Create house
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /casa/piso1/sala
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /casa/piso1/cocina
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /casa/piso2/alcoba

# Add furniture
$HADOOP_HOME/bin/hdfs dfs -put ./resources/mesa.jpg /casa/piso1/sala
$HADOOP_HOME/bin/hdfs dfs -put ./resources/estufa.jpg /casa/piso1/cocina
$HADOOP_HOME/bin/hdfs dfs -put ./resources/libro.doc /casa/piso2/alcoba
$HADOOP_HOME/bin/hdfs dfs -put ./resources/televisor.jpg /casa/piso2/alcoba

# Check
$HADOOP_HOME/bin/hdfs dfs -ls -R /casa
