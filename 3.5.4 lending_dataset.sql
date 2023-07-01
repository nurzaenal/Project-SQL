Drop table if exists public.lending_dataset;
Create table if not exists public.lending_dataset(
loan_number integer NOT NULL,
amount_borrowed numeric(11,2),
term integer,
borrower_rate numeric(8,7),
installment numeric (11,2),
grade text COLLATE pg_catalog."default",
origination_date timestamp(0) without time zone,
listing_title text COLLATE pg_catalog."default",
principal_balance numeric(11,2),
principal_paid numeric(11,2),
interest_paid numeric(11,2),
late_fess_paid numeric(11,2),
debt_sale_procceeds_received numeric(11,2),
last_payment_date timestamp(0) without time zone,
next_payment_due_date timestamp(0) without time zone,
days_past_due integer,
loan_status_description text COLLATE pg_catalog."default",
data_source text COLLATE pg_catalog."default")
TABLESPACE pg_default;
ALTER table if exists public.lending_dataset
OWNER to postgres;




select * from lending_dataset

/*rata-rata persentase outstanding balance dari setiap status pinjaman, 
dimana persentase outstanding balance didefinisikan sebagai
principal balance dibagi amount borrowed */

select loan_status_description,
avg(principal_balance/amount_borrowed) as percentage_out_standing_blanace
from lending_dataset
group by loan_status_description
order by percentage_out_standing_blanace desc


/*
 Dimana status pinjaman ‘defaulted’, urutan grade berdasarkan rata-rata
persentase outstanding balance tertinggi ke terendah, serta munculkan
juga jumlah pinjaman dan rata-rata suku bunga pinjaman (borrower rate)*/
select loan_status_description,
AVG(principal_balance/amount_borrowed) as percentage_out_standing_balance,
COUNT(loan_number)jumlah_pinjaman, AVG(amount_borrowed)rata_rata_jumlahpinjaman,
AVG(borrower_rate)avg_borrower_rate
from lending_dataset
where loan_status_description = 'DEFAULTED'
group by loan_status_description
order by percentage_out_standing_balance desc


/*group by loan status*/
SELECT loan_status_description,COUNT(loan_number) AS loan_count,
AVG(amount_borrowed) AS avg_amount_borrowed, AVG(borrower_rate) AS avg_interest_rate, AVG(principal_balance/amount_borrowed) AS avg_outstanding_balance_percentage 
FROM lending_dataset  
GROUP BY loan_status_description
ORDER BY avg_outstanding_balance_percentage DESC;



/* 3.5.8 a. total pinjaman yang telah diberikan ke setiap
nasabah berdasarkan tahun di kolom origination_date */

Select 
SUM(amount_borrowed)jumlah_pinjaman,EXTRACT(YEAR FROM origination_date)years
from lending_dataset
--listing_title where listing_title ilike '%home%'
group by years

/*3.5.8 b. total pinjaman yang telah diberikan pada nasabah dengan
peruntukan kebutuhan yang berkaitan dengan rumah, yang dapat kamu
temukan dari listing_title yang mengandung kata “home”.*/

Select listing_title,
SUM(amount_borrowed)jumlah_pinjaman
from lending_dataset
listing_title where listing_title ilike '%home%'
group by listing_title
