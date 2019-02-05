#!/bin/bash

echo '1) Las 10 Películas con mayor calificación'

hive -S -e 'SELECT *
              FROM (
                SELECT movieid, AVG(rating) AS avg_rating
                FROM u_data_new
                GROUP BY movieid
                ) data
            ORDER BY avg_rating DESC
            LIMIT 10;'


echo '2) Las 10 películas con más votos'

hive -S -e 'SELECT *
              FROM (
                SELECT movieid, COUNT(rating) AS votes
                FROM u_data_new
                GROUP BY movieid
                ) data
            ORDER BY votes DESC
            LIMIT 10;'


echo '3) Los 10 usuarios con más votos'

hive -S -e 'SELECT *
              FROM (
                SELECT userid, COUNT(rating) AS votes
                FROM u_data_new
                GROUP BY userid
                ) data
            ORDER BY votes DESC
            LIMIT 10;'


echo '4) Puntaje promedio por película y año'

hive -S -e 'SELECT  year, movieid, avg_rating
              FROM (
                SELECT movieid, AVG(rating) AS avg_rating,
                      YEAR(cast(weekday as date)) AS year
                FROM u_data_new
                GROUP BY movieid, YEAR(cast(weekday as date))
                ) data
            ORDER BY year DESC;'


echo '5) La película con mejor puntaje por año'

hive -S -e 'SELECT data.year, movieid, avg_rating
              FROM (
                SELECT movieid, AVG(rating) AS avg_rating,
                      YEAR(cast(weekday as date)) AS year
                FROM u_data_new
                GROUP BY movieid, YEAR(cast(weekday as date))
                ) data
              INNER JOIN (
                SELECT MAX(avg_rating) AS max_avg,  year
                FROM (
                    SELECT movieid, AVG(rating) AS avg_rating,
                      YEAR(cast(weekday as date)) AS year
                    FROM u_data_new
                    GROUP BY movieid, YEAR(cast(weekday as date))
                    ) avg
                GROUP BY year
                ) data_max
                on data.year = data_max.year
            WHERE data.avg_rating = data_max.max_avg
            ORDER BY data.year DESC;'
