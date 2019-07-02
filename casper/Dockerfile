FROM openlmis/demo-data:latest

COPY load.sh /load.sh
RUN chmod u+x /load.sh

COPY wait-for-postgres.sh /wait-for-postgres.sh
RUN chmod u+x /wait-for-postgres.sh


COPY load_data.sql /load_data_casper.sql

CMD /load.sh
