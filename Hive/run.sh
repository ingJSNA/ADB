#!/bin/bash

# Download http://files.grouplens.org/datasets/movielens/ml-100k.zip

# Extract u.data

# Copy datetime mapper

cp /workspace/datetime_mapper.py $HIVE_HOME
hadoop fs -put /workspace/datetime_mapper.py /user/hive

# Build data base

hive -f /workspace/build_db.sql
