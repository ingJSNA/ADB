CREATE TABLE u_data (
  userid INT,
  movieid INT,
  rating INT,
  unixtime STRING)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE;


LOAD DATA LOCAL INPATH '/workspace/data/u.data' OVERWRITE INTO TABLE u_data;

SELECT COUNT(1) FROM u_data;

add FILE /workspace/datetime_mapper.py;

CREATE TABLE u_data_new (
  userid INT,
  movieid INT,
  rating INT,
  weekday STRING)
ROW FORMAT DELIMITED
  FIELDS TERMINATED BY '\t';

/*
INSERT OVERWRITE TABLE u_data_new
  SELECT
  TRANSFORM (userid, movieid, rating, unixtime)
  USING 'python datetime_mapper.py'
  AS (userid, movieid, rating, weekday)
  FROM u_data;
*/

LOAD DATA LOCAL INPATH '/workspace/data/u.data_new' OVERWRITE INTO TABLE u_data_new;

SELECT weekday, COUNT(1)
  FROM u_data_new
  GROUP BY weekday;
