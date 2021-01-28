/* select * from rental limit 4;
inventory - inventory_id, film_id, store_id,
film_category - fc.film_id, category_id
category - category_id, name
film - film_id, rental_duration, release_year, rating, special_features;
*/
drop view if exists Needed_info;
create view needed_info as 
select r.rental_id as Rental_ID, r.Inventory_id as INV_ID, r.Customer_id, r.rental_date, r.Return_date, i.film_id, i.store_id, c.category_id, c.name, f.rental_duration, f.release_year, f.rating, f.special_features from rental as r
join inventory as i on i.inventory_id=r.inventory_id
join film_category as fc on fc.film_id=i.film_id
join category as c on c.category_id =fc.category_id
join film as f on f.film_id = fc.film_id
where rental_date >= 20050730 and rental_date <= 20050830
Order by rental_date ASC;


drop view if exists rental_per_ct;
create view rental_per_ct as 
select customer_id as CT , count(film_id) as Movies_rented from needed_info
where rental_date >= 20050730 and rental_date <= 20050830
group by Customer_id
Order by Movies_rented ASC;
select * from rental_per_ct;

drop view if exists most_rented;
create view most_rented as
select film_id as Movie, count(rental_id) as times_rented from needed_info
group by film_id
order by times_rented ASC;
select * from most_rented;
