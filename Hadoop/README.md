# Hadoop homework

## Learn

1. [Basic commands](https://youtu.be/l0I_2nyPNZM)
2. [Run job](https://youtu.be/WyEkdh1Qptk)


## Demo

* Install Hadoop

```bash

docker pull images/hadoop-docker:latest

cd "${HOME}/worskpace/BDA"

git clone https://github.com/big-data-europe/docker-hadoop.git

# Install docker-compose
conda create --name docker python=3.6
conda activate docker
conda install -c conda-forge docker-compose

# Run HBase standalone
cd docker-hadoop
docker-compose -f docker-compose-local.yml up -d
```

* Open the url http://localhost:50070/dfshealth.html#tab-overview.

* Copy the script to the container

```bash
cd "${HOME}/worskpace/BDA/ADB/HBase/"

docker cp Agenda.sh hbase:/Agenda.sh

# Run the script to load the table
docker exec -it hbase sh -c "hbase shell /Agenda.sh"
```

Open a shell

```
docker exec -it hbase bash
```
