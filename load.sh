#!/usr/bin/env bash

# For each schema to load, need to drop any existing schema before loading
for file in data/schema/schema*.sql; do

    # See http://tldp.org/LDP/abs/html/string-manipulation.html
    noprefix=${file#*.}       # Remove prefix inclusively up to first dot
    schemaname=${noprefix%.*} # Remove suffix inclusively up to last dot

    psql -c "drop schema if exists ${schemaname} cascade;" 2>&1
    psql -f $file
done

psql -f data/load_data.sql