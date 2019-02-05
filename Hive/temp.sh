#!/bin/bash




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
