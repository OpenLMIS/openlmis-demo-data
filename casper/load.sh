#!/usr/bin/env bash

PSQL="psql --single-transaction --set AUTOCOMMIT=off --set ON_ERROR_STOP=on"


${PSQL} -f /load_data_casper.sql
