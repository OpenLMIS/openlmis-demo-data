#!/usr/bin/env bash

for file in data/schema/*.sql; do
    psql -f $file
done

psql -f data/load_data.sql