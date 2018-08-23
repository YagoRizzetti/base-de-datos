Excersises

Escriba las declaraciones con todas las subconsultas necesarias, no use identificadores codificados a menos que se especifique. Verifique qué campos son obligatorios y cuáles se pueden omitir (use el valor predeterminado).



1-Agregar un nuevo cliente

Para almacenar 1
Para la dirección use una dirección existente. El que tiene el address_id más grande en 'Estados Unidos'

2-Añadir un alquiler

Haga fácil seleccionar cualquier título de la película. Es decir, debería ser capaz de poner 'película' en el lugar, y no en la identificación.
No verifique si la película ya está alquilada, solo use alguna del inventario, por ejemplo, la que tenga la identificación más alta.
Seleccione cualquier staff_id de la Tienda 2. 

3-Actualizar año película basado en la calificación

Por ejemplo, si la calificación es 'G', la fecha de lanzamiento será '2001'
Puede elegir la asignación entre calificación y año.
Escriba todas las declaraciones que sean necesarias.

4-Devuelve una película

Escriba las declaraciones y consultas necesarias para los siguientes pasos.
Encuentra una película que aún no fue devuelta. Y usa esa identificación de alquiler. Elija el último que fue alquilado, por ejemplo.
Usa la identificación para regresar la película.

5-Intenta eliminar una película

Verifique qué sucede, describa qué hacer.
Escriba todas las declaraciones de eliminación necesarias para eliminar por completo la película de la base de datos.

6-Alquile una película

Encuentre una identificación de inventario que esté disponible para alquilar (disponible en la tienda) y seleccione cualquier película. Guarde esta identificación en alguna parte.
Añadir una entrada de alquiler
Agregue una entrada de pago
Utilice subconsultas para todo, excepto para el identificador de inventario que se puede usar directamente en las consultas.

Una vez que hayas terminado. Restaure los datos de la base de datos utilizando el script populate de la clase 3.

-----------------------------------------------------------------------------------------------------------------------------------------------------

Resultados:

1-
    insert into customer(store_id,first_name,last_name,address_id) 
    select  1,"tobi","palanca",address_id 
    from address 
    inner join city using (city_id)  
    inner join country using (country_id) 
    where country.country = "United states" 
    order by address_id desc 
    limit 1;

2-
    INSERT INTO rental(rental_date,inventory_id,customer_id,staff_id)
    VALUES(CURRENT_DATE(),
        (SELECT inventory_id FROM inventory INNER JOIN film USING (film_id) WHERE title = "ZOOLANDER FICTION" LIMIT 1),
        (SELECT customer_id FROM customer WHERE store_id = 2 LIMIT 1),
        (SELECT staff_id FROM staff WHERE store_id = 2 LIMIT 1));
        
3-UPDATE film
  SET release_year =
 (CASE
  WHEN rating = "G" THEN 2001
  WHEN rating = "PG" THEN 2002
  WHEN rating = "PG-13" THEN 2003
  WHEN rating = "R" THEN 2004
  WHEN rating = "NC-17" THEN 2005
  END);
  
4-
    update rental set return_date = current_date() where rental_id = 16050;

5-
    delete from film_actor
    where film_id=1;
    
    delete from film_category
    where film_id=1;
    
    delete from rental 
    where inventory_id in (select inventory_id from inventory where film_id=1);
    
    delete from inventory 
    where film_id=1;
    
    delete from film
    where film_id=1;
    
6-
    INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id,)
    VALUES(CURRENT_DATE(),
    (SELECT inventory_id FROM rental INNER JOIN inventory using (inventory_ID) WHERE inventory_id=4581 and (SELECT film_id FROM inventory
    INNER JOIN film using (film_ID) WHERE film_id=1000)),
    (SELECT customer_id FROM rental INNER JOIN customer using (customer_id) WHERE customer_id=1)
    (SELECT staff_id FROM rental INNER JOIN staff using(staff_id) WHERE staff_id=1));
              
Ejercitacion:

1)
    insert into customer (first_name,last_name,address_id)
    select "pepe", "argento", address_id
    from address
    inner join city using(city_id)
    inner join country using (country_id)
    where country.country="United States"
    order by address_id desc
    limit 1;
    
    
2)
    insert into rental(rental_date,inventory_id,customer_id,store_id)
    values(current_date,
          (select inventory_id from inventory inner join film using(film_id) where title = "ZOOLANDER FICTION" limit 1)
          (select customer_id from customer where store_id = 2 limit 1)
          (select store_id from store where store_id=2 limit 1));
          
3)
    update film
    set release_year
    (case
    when rating = "G" then 2001
    when rating = "PG" then 2002
    when rating = "PG_13" then 2003
    when rating = "R" then 2004
    when rating = "NC_17" then 2005
    end);
    
4)
    update rental
    set return_date = current_date 
    where rental_id = 14769;
    
5)

    delete from film_actor
    where film_id = 1;
    
    delete from film_category
    where film_id=1;
    
    delete from rental 
    where inventoria_id in (select inventory_id from inventory where film_id=1);
    
    delete from film
    where film_id=1
    
6)
    insert into rental(rental_date,inventory_id,customer_id,staff_id)
    values(current_date,
           (select inventory_id from rental inner join inventory using(inventory_id) where inventory_id=4581 and (select film_id from inventory inner join film using(film_id)where film_id=1000)),
           (select customer_id from rental inner join customer using(customer_id) where customer_id=1),
           (select staff_id from rental inner join staff using(staff_id) where staff_id=1));
    
    