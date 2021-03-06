# Hadoop homework

## Learn

1. [Basic commands](https://youtu.be/l0I_2nyPNZM)
2. [Run job](https://youtu.be/WyEkdh1Qptk)


## Demo

* Install Hadoop

```bash

cd "${HOME}/worskpace/BDA"

git clone https://github.com/big-data-europe/docker-hadoop.git

# Install docker-compose
conda create --name docker python=3.6
conda activate docker
conda install -c conda-forge docker-compose

# Run local
cd docker-hadoop
docker-compose -f docker-compose-local.yml up -d
```

* Open the url http://localhost:58188/.

* Copy to container and Upload data to hdfs. The hdfs definition is in
docker-hadoop/hadoop.env

```bash
cd "${HOME}/worskpace/BDA/ADB/"

docker cp Hadoop/ namenode:/Example/

# Upload to hdfs
docker exec -it namenode bash
cd /Example

hadoop fs -mkdir hdfs://namenode:9000/bda
hadoop fs -put ./data/purchases.txt hdfs://namenode:9000/bda
hadoop fs -ls hdfs://namenode:9000/bda

hadoop fs -tail hdfs://namenode:9000/bda/purchases.txt
```

* Run the mapper and reducer written in python. [Hadoop Streaming](https://hadoop.apache.org/docs/r2.7.1/hadoop-streaming/HadoopStreaming.html)

```bash
docker exec -it namenode bash
cd /Example/src/store-totals

# Run job
pip3 install mrjob

python store_totals.py -r hadoop hdfs://namenode:9000/bda/purchases.txt > /Example/data/mrjob_out.txt
```
