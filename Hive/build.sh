#!/bin/bash

# Download http://files.grouplens.org/datasets/movielens/ml-100k.zip

# Extract u.data

# Copy datetime mapper

cp /workspace/datetime_mapper.py $HIVE_HOME

cat /workspacedata/u.data  | python /workspace/datetime_mapper.py  > /workspace/data/u.data_new

# Build data base

hive -f /workspace/build_db.sql
