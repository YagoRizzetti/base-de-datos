# 1)

CREATE OR REPLACE VIEW list_of_customers AS
SELECT c.customer_id AS 'ID', CONCAT(c.first_name,'',c.last_name) AS 'Nombre Completo', a.address AS 'Direccion', a.postal_code AS 'Codigo Postal', a.phone AS 'Telefono', ci.city AS 'Ciudad', co.country AS 'Pais',IF (c.active IS FALSE, 'inactive', 'active') AS 'Status', c.store_id AS 'ID Store' 
FROM customer c
	INNER JOIN address a USING (address_id)
	INNER JOIN city ci USING (city_id)	
	INNER JOIN country co USING (country_id)
	ORDER BY c.customer_id ASC;

SELECT * FROM list_of_customers;

2)

#Create a view named film_details, it should contain the following columns:
#film id,  title, description,  category,  price,  length,  rating, actors  - as a string of all the actors separated by comma. Hint use 
#GROUP_CONCAT

CREATE OR REPLACE VIEW film_details AS
SELECT f.film_id AS 'Film ID', f.title AS 'Titulo', f.description AS 'Descripcion', c.name AS 'Categoria', f.replacement_cost AS 'Price', f.length AS 'Duracion', f.rating AS 'Calificacion', GROUP_CONCAT(DISTINCT a.last_name ORDER BY a.last_name DESC SEPARATOR ',')
FROM film f
	INNER JOIN film_actor fa USING (film_id)
	INNER JOIN actor a USING (actor_id)
	INNER JOIN film_category fc USING (film_id)
	INNER JOIN category c USING (category_id)
	GROUP BY 1,2,3,4,5,6,7;

3) 

#Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.

CREATE OR REPLACE VIEW sales_by_film_category 
SELECT c.name AS 'Categoria', SUM(p.amount) AS 'Total'
	FROM category c
	INNER JOIN film_category fc USING (category_id)
	INNER JOIN film f USING (film_id)
	INNER JOIN inventory i USING(film_id)
	INNER JOIN rental r USING (inventory_id)
	INNER JOIN payment p USING (rental_id)
	ORDER BY 2 ASC;	
    
    
4)

CREATE VIEW actor_information AS
SELECT actor.actor_id, CONCAT(actor.first_name, ' ', actor.last_name), COUNT(actor_id) AS cant_actuaciones
FROM actor
INNER JOIN film_actor USING(actor_id)
GROUP BY 1
ORDER BY 1 ASC

5)

CREATE DEFINER=CURRENT_USER SQL SECURITY INVOKER VIEW actor_info
AS
SELECT
a.actor_id,
a.first_name,
a.last_name,
GROUP_CONCAT(DISTINCT CONCAT(c.name, ': ',
		(SELECT GROUP_CONCAT(f.title ORDER BY f.title SEPARATOR ', ')
                    FROM sakila.film f
                    INNER JOIN sakila.film_category fc
                      ON f.film_id = fc.film_id
                    INNER JOIN sakila.film_actor fa
                      ON f.film_id = fa.film_id
                    WHERE fc.category_id = c.category_id
                    AND fa.actor_id = a.actor_id
                 )
             )
             ORDER BY c.name SEPARATOR '; ')
AS film_info
FROM sakila.actor a
LEFT JOIN sakila.film_actor fa
  ON a.actor_id = fa.actor_id
LEFT JOIN sakila.film_category fc
  ON fa.film_id = fc.film_id
LEFT JOIN sakila.category c
  ON fc.category_id = c.category_id
GROUP BY a.actor_id, a.first_name, a.last_name;

SELECT * FROM actor_information

6)

A Materialized View (MV) is the pre-calculated (materialized) 
result of a query. Unlike a simple VIEW the result of a Materialized 
View is stored somewhere, generally in a table. Materialized Views are 
used when immediate response is needed and the query where the Materialized
View bases on would take to long to produce a result.

DBMS: oracle, postgreSQL, SQL SERVER, MySQL doesn't support materialized views natively,
but workarounds can be implemented by using triggers or stored procedures