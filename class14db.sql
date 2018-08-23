
1)Escriba una consulta que obtenga todos los clientes que viven en Argentina. Mostrar el nombre y apellido en una columna, la dirección y la ciudad.

2)Escribe una consulta que muestre el título de la película, el idioma y la calificación. La calificación se mostrará como el texto completo descrito aquí: https://en.wikipedia.org/wiki/Motion_picture_content_rating_system#United_States . Sugerencia: caso de uso.

3)Escriba una consulta de búsqueda que muestre todas las películas (título y año de publicación) de las que participó un actor. Supongamos que el actor proviene de un cuadro de texto introducido a mano desde una página web. Asegúrese de "ajustar" el texto de entrada para tratar de encontrar las películas de la manera más efectiva de lo que cree posible.

4)Encuentra todos los alquileres realizados en los meses de mayo y junio. Muestre el título de la película, el nombre del cliente y si fue devuelto o no. Debería haber una columna devuelta con dos posibles valores 'Sí' y 'No'.

5)Investigar las funciones CAST y CONVERT. Explique las diferencias si las hay, escriba ejemplos basados en sakila DB.

6)Investigar tipo de función NVL, ISNULL, IFNULL, COALESCE, etc. Explica lo que hacen. Cuáles no están en MySql y ejemplos de uso de escritura.
-----------------------------------------------------------------------------------------------------------------------------------------------------

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
    INNER JOIN rental USING(inventory_id)
    INNER JOIN customer USING(customer_id)
    WHERE MONTH(rental_date) IN('5', '6')

5)
#The CAST() function converts a value from one datatype to another datatype:

función convierte un valor de un tipo de datos a otro tipo de datos:


    SELECT CAST(customer_id AS CHAR)
    FROM customer
    WHERE first_name LIKE "%a"; 

#The MySQL CONVERT() function converts a value 
#from one datatype to another, or one character set to another.

    la función convierte un valor
de un tipo de datos a otro, o un conjunto de caracteres a otro

    SELECT CONVERT(return_date , DATE)
    FROM rental
    WHERE return_date IS NOT NULL;

6)
#The MySQL IFNULL() function lets you return an alternative value if an expression is NULL:

función le permite devolver un valor alternativo si una expresión es NULL

    SELECT IFNULL(NULL, "Es null"), return_date
    FROM rental
    WHERE return_date IS NULL

#ISNULL() function is used to specify how we want to treat NULL values.

función le permite devolver un valor alternativo si una expresión es NULL

    SELECT ISNULL(return_date)
    FROM rental
    WHERE return_date IS NULL

#The NVL() and COALESCE() functions can also be used to achieve the same result.

las funciones también se pueden usar para lograr el mismo resultado

    SELECT rental_date, rental_id, COALESCE(return_date, "no devuelta")
    FROM rental
    WHERE return_date IS NULL

#oracle
    SELECT rental_date, rental_id, NVL(return_date, "no devuelta")
    FROM rental
    WHERE return_date IS NULL

Practica:

1)
    select CONCAT(first_name,Last_name) as "nombre completo" , address.address , city.city
    from customer
    inner join address using(address_id)
    inner join city using(city_id)
    inner join country using(country_id)
    where country.country = "ARGENTINA"
    
2)  
    select title, lenguage.lenguage ,
        (case rating
            WHEN "G" THEN "General Audiences"
            WHEN "PG" THEN "Parental Guidance Suggested"
            WHEN "PG-13" THEN "Parents Strongly Cautioned"
            WHEN "R" THEN "Restricted"
            WHEN "NC-17" THEN "Adults Only"
        END) AS "rating"
        from film 
        inner join lenguage using(lenguage_id);
        
3) 
    select title, release_year
    from film
    inner join film_actor using(film_actor_id)
    inner join actor using(actor_id)
    where trim(lower(actor.film_id))
    and like trim(lower("pepe"))
    
4)
    select film.title , concat(customer.first_name,customer.last_name) as "nombre completo", 
    IF (return_date is null, "no", "yes") as "devuelto"
    from rental 
    inner join inventory using(inventory_id)
    inner join film using(film_id)
    inner join customer using(customer_id)
    where month(rental_date) in(5,6);
    
5)
    