FROM alpine:3.12

RUN apk update && apk add postgresql-client openjdk8 git bash

WORKDIR /

COPY entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh
COPY sql /sql

ENTRYPOINT ["/entrypoint.sh"]

COPY load.sh /load.sh
RUN chmod u+x /load.sh

COPY wait-for-postgres.sh /wait-for-postgres.sh
RUN chmod u+x /wait-for-postgres.sh

COPY build/data /data

CMD /load.sh
