# HBase homework

## Demo

* Install hbase

```bash
cd "${HOME}/worskpace/BDA"

git clone https://github.com/big-data-europe/docker-hbase.git

# Install docker-compose
conda create --name docker
conda activate docker
conda install -c conda-forge docker-compose

# Run HBase standalone
docker-compose -f docker-compose-standalone.yml up -d
```

* Open the url http://localhost:16010/.

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
