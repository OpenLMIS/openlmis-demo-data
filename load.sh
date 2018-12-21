#!/usr/bin/env bash

PSQL="psql --single-transaction --set AUTOCOMMIT=off --set ON_ERROR_STOP=on"

# For each schema to load, need to drop any existing schema before loading
for file in data/schema/schema*.sql; do

    # See http://tldp.org/LDP/abs/html/string-manipulation.html
    noprefix=${file#*.}       # Remove prefix inclusively up to first dot
    schemaname=${noprefix%.*} # Remove suffix inclusively up to last dot

    ${PSQL} -c "drop schema if exists ${schemaname} cascade;" 2>&1
    ${PSQL} -f $file
done

${PSQL} -f data/load_data.sql
