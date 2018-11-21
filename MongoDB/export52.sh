#!/bin/bash

HOST=localhost
PORT=27017

DATABASE=bda

# Export data
mkdir -p results52

cd './results52'

COLLECTIONS=("restaurants_count"
            "restaurants_count_sum"
            "restaurants_geo_count"
            "restaurants_avg_score"
            "restaurants_top_by_cuisine")

for c in "${COLLECTIONS[@]}"
do
  echo "Exporting ${c} ..."
  mongoexport --db $DATABASE --collection $c --out "${c}.json"

done
