'''1. Extracting Data'''

SELECT 
    sales.id,
    sales.date,
    sales.amount,
    customers.name AS customer_name,
    products.name AS product_name
FROM 
    sales
INNER JOIN 
    customers ON sales.customer_id = customers.id
INNER JOIN 
    products ON sales.product_id = products.id;

'''2. Transforming Data'''

SELECT 
    customers.name AS customer_name,
    SUM(sales.amount) AS total_sales
FROM 
    sales
INNER JOIN 
    customers ON sales.customer_id = customers.id
GROUP BY 
    customers.name;

'''3. Data Cleaning Techniques'''
--a. Handling Missing Values
SELECT 
    *
FROM 
    sales
WHERE 
    amount IS NULL;

--b. Removing Duplicates

UPDATE 
    sales
SET 
    amount = 0
WHERE 
    amount IS NULL;

--Remove duplicate rows while keeping the latest entry:
DELETE FROM 
    sales
WHERE 
    id NOT IN (
        SELECT 
            MAX(id)
        FROM 
            sales
        GROUP BY 
            customer_id, product_id
    );


--c.  Correcting Inconsistent Data

UPDATE 
    products
SET 
    name = LOWER(name);

'''4. Ensuring Data Quality'''
--a. Validating Data Integrity

ALTER TABLE 
    sales
ADD CONSTRAINT 
    positive_amount CHECK (amount >= 0);

--b. Using Transactions for Data Consistency
BEGIN TRANSACTION;

UPDATE 
    sales
SET 
    amount = amount * 1.1
WHERE 
    date >= '2023-01-01';

UPDATE 
    customers
SET 
    status = 'Active'
WHERE 
    id IN (SELECT customer_id FROM sales WHERE date >= '2023-01-01');

COMMIT;


-- roll back the transaction to maintain data consistency:

ROLLBACK;



'''
Displaying the latest transaction data that includes user_id, first_name, email, 
product category, and the number of days since the last purchase. 
Assume today is September 9, 2022.
'''
select  user_id,u.first_name,u.email,category,order_items_urutan.created_at,
p.category,
extract
(day from '2022-09-09' - order_items_urutan.created_at)jumlah_hari_2022_09_09
from
	(select
	*,
	rank() over(partition by user_id order by order_items.created_at desc)urutan_transaksi
from order_items
where extract(day from '2022-09-09' - order_items.created_at)< 90 
	)order_items_urutan
left join users u on u.id = order_items_urutan.user_id
left join products p on p.id = order_items_urutan.product_id
where urutan_transaksi = 1 
order by jumlah_hari_2022_09_09 desc ;

select * from
(select user_id,u.first_name,u.email,category ,
extract(day from '2022-09-09' - oi.created_at)selisih_hari,oi.created_at,
rank() over(partition by user_id order by oi.created_at desc)urutan_transaksi
from order_items oi
left join users u on u.id = oi.user_id
left join products pd on pd.id = oi.product_id
where extract(day from '2022-09-09' - oi.created_at)< 90
order by created_at desc)as subquery
where urutan_transaksi = 1 ;


select * from(
select oi.user_id,u.first_name,u.email,p.category,oi.created_at,
extract(day from'2022-09-09' - oi.created_at) as selisih_hari,
rank ()over(partition by user_id order by oi.created_at desc) as urutan_transaksi
from order_items oi
left join users u on u.id = oi.user_id
left join products p on p.id = oi.product_id
where extract(day from'2022-09-09' - oi.created_at) between 0 and 90
order by created_at desc
	)as subquery
where urutan_transaksi = 1;



select category,count (created_at) from(
select pd.category,oi.created_at,rank () over (partition by pd.category order by oi.created_at desc)
from order_items oi
left join products pd on pd.id = oi.product_id
	)as subquery
group by category
order by count(1) desc

