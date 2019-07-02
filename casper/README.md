# Notes on demo data for Casper Project

This docker image contains demo data for project casper ( More about this project can be found on this link
(https://github.com/OpenLMIS/openlmis-ref-distro/tree/casper-wip/reporting)

## Configuration

This image is based off of openlmis/demo-data image, and so the environment variables needed for that
image are needed here.


## How to update

SQL scripts can be updated on load_data.sql file, once update normal process of building and pushing docker image
to docker hub can be followed ( Note: docker image must have casper tag )


## Example on using

Lets presume environment variables are defined in:

* settings.env - has settings such as
  [these](https://github.com/OpenLMIS/openlmis-ref-distro/blob/master/settings-sample.env).

With those we can load demo into a database with:

```
docker run -it --rm --env-file settings.env openlmis/demo-data:casper
```

Or if the database is running as a container in the ref-distro:

```
docker run -it --rm --env-file settings.env --network openlmis-ref-distro_default openlmis/demo-data:casper
```
