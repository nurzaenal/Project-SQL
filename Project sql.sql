--menampilkan data transaksi terakhir yang berisi user_id,
--first_name, email, kategori produk dan jumlah hari sejak terakhir kali belanja.
--Asumsikan hari ini adalah tanggal 9 September 2022
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

