#!/bin/bash

cd .demo-data-ref-distro

/usr/local/bin/docker-compose -f docker-compose.yml -p demodatarefdistro up -d db
/usr/local/bin/docker-compose -f docker-compose.yml -f docker-compose.demo-data.yml -p demodatarefdistro up demo-data

CONTAINER_ID=`docker ps -a -q --filter "name=demodatarefdistro_demo-data"`
EXIT_CODE=`docker inspect ${CONTAINER_ID} --format='{{.State.ExitCode}}'`

/usr/local/bin/docker-compose -f docker-compose.yml -f docker-compose.demo-data.yml -p demodatarefdistro rm -f demo-data
/usr/local/bin/docker-compose -f docker-compose.yml -p demodatarefdistro down -v

cd ..

exit ${EXIT_CODE}
