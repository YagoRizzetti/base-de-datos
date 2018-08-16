1)
    select CONCAT(first_name, last_name) as "Nombre y Apellido", address , city 
    from customer, address, city, country 
    where customer.address_id = address.address_id 
    and address.city_id=city.city_id 
    and city.country_id=country.country_id 
    and country.country="ARGENTINA";
    
2)

    SELECT title, language.name,  
        (CASE rating
            WHEN "G" THEN "General Audiences"
            WHEN "PG" THEN "Parental Guidance Suggested"
            WHEN "PG-13" THEN "Parents Strongly Cautioned"
            WHEN "R" THEN "Restricted"
            WHEN "NC-17" THEN "Adults Only"
        END) AS "rating"
    FROM film
    INNER JOIN `language` USING(language_id)

3)

    SELECT title, release_year
    FROM film
    INNER JOIN film_actor USING(film_id)
    INNER JOIN actor USING(actor_id)
    WHERE TRIM(LOWER(CONCAT(actor.first_name))) 
    LIKE TRIM(LOWER('Egg'))

4)
    SELECT film.title as "titulo", customer.first_name as "cliente", 
    IF(return_date IS NULL, 'No', 'Yes') as "devuelto"
    FROM film
    INNER JOIN inventory USING(film_id)
    LEFT JOIN rental USING(inventory_id)
    INNER JOIN customer USING(customer_id)
    WHERE MONTH(rental_date) IN('5', '6')

5)
#The CAST() function converts a value from one datatype to another datatype:
    SELECT CAST(customer_id AS CHAR)
    FROM customer
    WHERE first_name LIKE "%a"; 

#The MySQL CONVERT() function converts a value 
#from one datatype to another, or one character set to another.
    SELECT CONVERT(return_date , DATE)
    FROM rental
    WHERE return_date IS NOT NULL;

6)
#The MySQL IFNULL() function lets you return an alternative value if an expression is NULL:
    SELECT IFNULL(NULL, "Es null"), return_date
    FROM rental
    WHERE return_date IS NULL

#ISNULL() function is used to specify how we want to treat NULL values.
    SELECT ISNULL(return_date)
    FROM rental
    WHERE return_date IS NULL

#The NVL() and COALESCE() functions can also be used to achieve the same result.

    SELECT rental_date, rental_id, COALESCE(return_date, "no devuelta")
    FROM rental
    WHERE return_date IS NULL

#oracle
    SELECT rental_date, rental_id, NVL(return_date, "no devuelta")
    FROM rental
    WHERE return_date IS NULL


    SELECT ISNULL(return_date)
    FROM rental
    WHERE return_date IS NULL
    