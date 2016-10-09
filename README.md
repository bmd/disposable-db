DisposableDb
==============

A Docker Container for Running MySQL Locally. For when Excel just won't cut it™

### Requirements

Note: This docuemtation is targeted specifically at mac OS users (10.10 and above), so ymmv on other unix operating systems, but the logic should be about the same - `docker-compose` takes care of all of the heavy lifting here.

The only thing you'll need to install on your local machine is the Docker for Mac app. See [the Docker for Mac website](https://www.docker.com/products/docker#/mac) for instructions. 

### Getting Started

DisposableDb is designed to be as flexible as possible, so you'll need to do a bit of work to get it up and running for your specific data.

1) Add the delimited file (or files) `whatever.csv` to the `startup` directory. Files in `startup` will be automatically mounted to the Docker container, and the image will scan for SQL files in that directory that it can execute.

2) Write the SQL to load your data and add it into the startup directory. The only requirement is that the file extension is ".sql". In most cases, though, you're going to be doing two things - creating a table or tables to hold your data and then running a `LOAD DATA LOCAL INFLE ...` command to insert the data into your database. Note that the infile absolute path starts with `/docker-entrypoint-initdb.d`, which maps to the `startup` directory locally.

```sql
CREATE TABLE emails (
    id INT NOT NULL PRIMARY KEY,
    email VARCHAR(128)
);

LOAD DATA 
  LOCAL INFILE '/docker-entrypoint-initdb.d/emails.csv' 
  INTO TABLE emails
  FIELDS TERMINATED BY ','
  LINES TERMINATED BY '\n'
;
```

3) Run `make install` to build and run your container. You can then run `make mysql` from another session to connect to the database, or stop the running container with `ctrl-c` and run `make start && make mysql` to restart the container in the background.
