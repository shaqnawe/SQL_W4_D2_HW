-- Question 1
-- List all customers who live in Texas (use JOINs)
select c.first_name, c.last_name, c.customer_id, city.city from customer c
join address a on a.address_id = c.address_id
join city on city.city_id = a.city_id 
where city.city = 'Texas'
group by c.customer_id, city.city

-- Question 2
-- Get all payments above $6.99 with the Customer's Full Name
select c.first_name, c.last_name, amount from payment p 
join customer c on c.customer_id = p.customer_id
where amount > 6.99
group by c.first_name, c.last_name, amount
order by amount desc

-- Question 3
-- Show all customers names who have made payments over $175(use subqueries)
select first_name, last_name, totals.total from 
(
	select sum(amount) as total, first_name, last_name from payment p 
	join customer c on p.customer_id = c.customer_id
	group by first_name, last_name
	order by total desc
) as totals
where total > 175


-- Question 4
-- List all customers that live in Nepal (use the city table)
select c.first_name, c.last_name, c.customer_id from customer c
join address a on a.address_id = c.address_id
join city on city.city_id = a.city_id
join country c2 on c2.country_id = city.country_id 
where country = 'Nepal'
group by c.first_name, c.last_name, c.customer_id

-- Question 5
-- Which staff member had the most transactions?
select first_name, last_name, sum(amount) from staff s
join payment p on p.staff_id = s.staff_id
group by first_name, last_name
order by sum(amount) desc limit 1

-- Question 6
-- How many movies of each rating are there?
select f.rating, count(f.film_id) from film f
group by f.rating
order by count(f.film_id) desc

-- Question 7
-- Show all customers who have made a single payment above $6.99 (Use Subqueries)
select distinct customer_id from
(
	select amount, c.customer_id from payment p
	join customer c on c.customer_id = p.customer_id
	where amount > 6.99
	group by p.amount, c.customer_id
) as payments
group by customer_id
having count(amount) = 1


-- Question 8
-- How many free rentals did our stores give away?
select count(r.rental_id) from rental r
join customer c on c.customer_id = r.customer_id
join payment p on p.customer_id = c.customer_id 
where p.amount = 0
group by p.amount 