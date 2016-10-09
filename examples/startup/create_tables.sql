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