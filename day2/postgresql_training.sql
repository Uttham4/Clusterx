SELECT 
    c.name AS Category, 
    f.title AS Film, 
    STRING_AGG(CONCAT(a.first_name, ' ', a.last_name), ', ') AS Actors, 
    l.name AS Language
FROM 
    film f
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
JOIN 
    film_actor fa ON f.film_id = fa.film_id
JOIN 
    actor a ON fa.actor_id = a.actor_id
JOIN 
    language l ON f.language_id = l.language_id
GROUP BY 
    c.name, f.title, l.name;


SELECT 
    c.name AS Category, 
    f.release_year AS Year, 
    COUNT(*) AS Number_of_Films 
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name, f.release_year
ORDER BY Number_of_Films DESC;




SELECT
	c.name as Category,
	f.title as Film,
	STRING_AGG(CONCAT(a.first_name,' ',last_name),',') as Actors,
	l.name as Language,
	f.release_year as Year,
	COUNT(r.rental_id) as Number_of_Rental,
	SUM(p.amount) as Total_Rental
FROM film f
JOIN film_category fc ON f.film_id=fc.film_id
JOIN category c ON fc.category_id=c.category_id
JOIN film_actor fa ON f.film_id=fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
JOIN language l ON f.language_id=l.language_id
JOIN inventory i ON f.film_id=i.film_id
JOIN rental r ON i.inventory_id=r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name,f.title,l.name,f.release_year
ORDER BY Total_Rental DESC



SELECT
	c.name as Category,
	f.title as Film,
	STRING_AGG(CONCAT(a.first_name,' ',a.last_name),',') as Actors,
	l.name as Language,
	f.release_year as Year,
	r.rental_date as Rental_Date,
	r.return_date as Return_Date,
	(r.return_date-r.rental_date) as Rental_Days,
	s.store_id as Store,
	CONCAT(cu.first_name, ' ', cu.last_name) AS Customer,
	SUM(p.amount) as Total_Payment,
	CONCAT(ci.city,' ',co.country) as City_Country
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN language l ON f.language_id = l.language_id
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
JOIN customer cu ON r.customer_id = cu.customer_id
JOIN address ad ON cu.address_id = ad.address_id
JOIN city ci ON ad.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
JOIN store s ON i.store_id = s.store_id
GROUP BY c.name,f.title,l.name,f.release_year,r.rental_date,r.return_date,s.store_id,cu.customer_id,ci.city,co.country
ORDER BY Rental_Date

