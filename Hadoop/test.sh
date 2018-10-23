#!/bin/bash

# Read parameter
FOLDER="$1"
FOLDER="store-totals"

# Test mapper and reducer
cat data/purchases.txt | python3 src/$FOLDER/mapper.py | python3 src/$FOLDER/reducer.py > data/$FOLDER.txt

tail ./data/$FOLDER.txt
