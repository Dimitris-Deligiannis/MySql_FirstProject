use sql_store;

-- where clause 
SELECT 
	first_name, 
	last_name, 	
    points ,
	(points +10) *100 as discount_factor
from customers
Where points > 3000;

select * 
from Customers 
 where state NOT IN ( 'ma','ga') and birth_date>'1990-01-01';
 
 select *
 from customers 
 where birth_date>'1990-01-01' or points >1000 and state = "va";
 
  select *
 from customers 
 where phone is NULL;

-- Between  
 select * 
 from customers 
 where points between 1000 and 3000 ; -- values also inclusive;
 
-- like
 select * 
 from customers 
 where last_name like 'b%' and first_name like 'F____i';
 
 
 -- Regexp
 select * 
 from customers
 where last_name Regexp 'field$|^mac|rose'; 
 
 select * 
 from customers
 where last_name regexp '[gim]e' or last_name regexp 'e[fmq]';
 
-- order by

 select first_name, last_name, 10 as points
 from customers 
 order by birth_date desc;
 
 select first_name, last_name, birth_date
 from customers 
 order by 1,2;
 
 -- limit
 
 select * 
 from customers 
limit 6 , 3;-- skip 6 records and show 3 after 6th

-- left join
select
	c.customer_id,
	c.first_name,
    c.last_name,
    o.order_id
from customers c
left join orders o 
	on c.customer_id = o.customer_id
order by c.customer_id;

use sql_hr;

select 
	e.employee_id,
    e.first_name,
    m.first_name as manager
from employees e
left join employees m
	ON e.reports_to = m.employee_id;
    
-- Return all the products 
select 
	name,
	unit_price,
	unit_price * 1.1 as new_price 
    From products; 
    
-- Get the orders placed 2019
select *
from orders 
where order_date >= '2019-01-01';

-- from the order items table get the items 
select * 
from order_items 
where order_id = 6 and unit_price*quantity > 30;

-- return the products with quantity in stock equal to 49,38,72
select * 
from products 
where quantity_in_stock IN (49, 38, 72);


-- return customers born between 1/1/90 and 1/1/2000
select * 
from customers 
where birth_date between '1990-01-01' and '2000-01-01';

-- get the customers whose adresses contain Trail or Avenue  
select * 
from customers 
where address like '%Trail%' OR address like '%Avenue%' or phone like '%9';

-- get the customers 
select * 
from customers
where first_name regexp 'ELKA|Ambur';
select * 
from customers 
where last_name regexp 'ey$|on$' or last_name regexp '^my|se';
select * 
from customers 
where last_name regexp 'b[ru]';

-- select not shipped orders
select *
from orders 
where shipper_id is null; 

-- 
select * , quantity*unit_price as total_price
from order_items 
where order_id = 2 
order by total_price desc;

-- get the top 3 loyal customers 
select * 
from customers 
order by points desc 
limit 3 ;

-- combine order_items with product_name
select o.order_id, o.product_id, p.name as product_name, o.quantity, o.unit_price, o.quantity*o.unit_price as total_price
from order_items as o
join products as p on o.product_id=p.product_id;

-- combine data from different tables
use sql_invoicing;

select
	p.date,
    p.invoice_id,
    p.amount,
    c.name,
    pm.name
from payments p
join clients c
	on p.client_id = c.client_id
join payment_methods pm
	on p.payment_method = pm.payment_method_id;
    
-- left join 
select 
	p.product_id,
    p.name,
    oi.quantity
from products p
left join order_items oi
	on p.product_id = oi.product_id;
    
-- inner and outter joins with multiple tables

select 
	o.order_date,
    o.order_id,
    c.first_name as customer,
    s.name as shipper,
    os.name as status
from orders o
join customers c
	on o.customer_id = c.customer_id
left join shippers s 
	on o.shipper_id = s.shipper_id
join order_statuses os
	on o.status = os.order_status_id;
    
-- inner join (using)
use sql_invoicing;

select 
	p.date,
    c.name as client,
    p.amount,
    pm.name
from payments p
join clients c
	using(client_id)
join payment_methods pm
	on p.payment_method = pm.payment_method_id;
    
-- union 
use sql_store;

select 
	customer_id,
    first_name,
    points,
    'Bronze' AS type
from customers
where points < 2000
union
select 
	customer_id,
    first_name,
    points,
    'silver' AS type
from customers
where points between 2000 and 3000
union
select 
	customer_id,
    first_name,
    points,
    'glod' AS type
from customers
where points > 3000
order by first_name;

-- insert 3 rows in products table
insert into products(name,quantity_in_stock,unit_price)
values('Product_1','70','1.5'),('Product_2','88','12.8'),('Product_3','700','1.1');

