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

for i in {1..7}
do
  echo "Running query ${i} ..."
  mongo $HOST:$PORT/$DATABASE "q${i}.js" > "./results/r${i}.json"
done
