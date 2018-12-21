#!/bin/bash

rm -vrf build
mkdir -p build

cd .demo-data-ref-distro
cp -v settings-sample.env settings.env

/usr/local/bin/docker-compose -f docker-compose.yml -p demodatarefdistro pull
/usr/local/bin/docker-compose -f docker-compose.yml -p demodatarefdistro up --no-start
cd ..

for cid in $(docker ps -a -q --filter name=demodatarefdistro); do
    docker cp "$cid":/schema build/data 2>/dev/null || true
    docker cp "$cid":/demo-data build/data 2>/dev/null || true
done

mv -v build/data/*schema.*.sql build/data/schema/

mkdir -vp build/data/demo-data/
cp -v data/*.csv build/data/demo-data/
cp -v data/load_data.sql build/data/load_data.sql

cd .demo-data-ref-distro
/usr/local/bin/docker-compose -f docker-compose.yml -p demodatarefdistro down -v
cd ..

docker build -t openlmis/demo-data .
