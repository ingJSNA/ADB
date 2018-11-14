#!/bin/bash

HOST=localhost
PORT=27017

DATABASE=bda
COLLECTION=restaurants

# Extract data
unzip -u "data.zip"

mongoimport --host $HOST:$PORT --drop -d $DATABASE -c $COLLECTION data.json

# Run queries

mkdir -p results

echo "RUNNING QUERIES"
mongo $HOST:$PORT/$DATABASE 1.js > ./results/1.json
