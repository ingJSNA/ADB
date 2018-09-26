SELECT 
    rent.rental_id,
    inv.film_id,
    rent.customer_id,
    ad.district AS store_district,
    cit.city AS store_city,
    coun.country AS store_country,
    ad.postal_code AS store_postal_code,
    customer_address.district AS customer_district,
    customer_city.city AS customer_city,
    customer_country.country AS customer_country,
    customer_address.postal_code AS customer_postal_code,
    (SELECT 
            dat.date_id
        FROM
            sakila_warehouse.date dat
        WHERE
            dat.year = EXTRACT(YEAR FROM rent.rental_date)
                AND dat.month = EXTRACT(MONTH FROM rent.rental_date)
                AND dat.day = EXTRACT(DAY FROM rent.rental_date)) rent_date,
    CASE
        WHEN rent.return_date IS NULL THEN CURDATE() + 0
        ELSE (SELECT 
                dat.date_id
            FROM
                sakila_warehouse.date dat
            WHERE
                dat.year = EXTRACT(YEAR FROM rent.return_date)
                    AND dat.month = EXTRACT(MONTH FROM rent.return_date)
                    AND dat.day = EXTRACT(DAY FROM rent.return_date))
    END ret_date,
    cust.store_id,
    1,
    CASE
        WHEN rent.return_date IS NULL THEN 0
        ELSE DATEDIFF(rent.return_date, rent.rental_date)
    END AS count_days_rent
FROM
    sakila.rental rent,
    sakila.inventory inv,
    sakila.customer cust,
    sakila.store store,
    sakila.country coun,
    sakila.city cit,
    sakila.address ad,
    sakila.address customer_address,
    sakila.city customer_city,
    sakila.country customer_country
WHERE
    rent.inventory_id = inv.inventory_id
        AND inv.store_id = store.store_id
        AND rent.customer_id = cust.customer_id
        AND ad.address_id = store.address_id
        AND cit.city_id = ad.city_id
        AND cit.country_id = coun.country_id
        AND cust.address_id = customer_address.address_id
        AND customer_address.city_id = customer_city.city_id
        AND customer_city.country_id = customer_country.country_id;