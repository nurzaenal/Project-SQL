----Crash_clean dengan colom timestamp_local
create table crash_clean AS(
select*,
case
when state_name in('Oklahoma','Colorado','North Carolina',
'Mississippi','Florida','Vermont','Delaware','Nevada',
'Louisiana','New York','West Virginia',
'South Carolina','New Jersey','Hawaii','New Mexico',
'Arkansas','Missouri','Connecticut','South Dakota','District of Columbia',
'Indiana','Iowa','Massachusetts','Rhode Island','Ohio',
'Michigan','Minnesota','Pennsylvania','Washington','Kentucky','Wisconsin',
'Montana','Arizona','Illinois','Virginia','Maryland','Georgia','Utah',
'Wyoming','New Hampshire','North Dakota','North','Dakot','Nebraska',
'Maine','California','Tennessee','Kansas',
'Oregon','Texas','Idaho','Alaska','Alabama')then timestamp_of_crash at time zone'est'
 when state_name in('Oklahoma','Colorado','North Carolina',
'Mississippi','Florida','Vermont','Delaware','Nevada',
'Louisiana','New York','West Virginia',
'South Carolina','New Jersey','Hawaii','New Mexico',
'Arkansas','Missouri','Connecticut','South Dakota','District of Columbia',
'Indiana','Iowa','Massachusetts','Rhode Island','Ohio',
'Michigan','Minnesota','Pennsylvania','Washington','Kentucky','Wisconsin',
'Montana','Arizona','Illinois','Virginia','Maryland','Georgia','Utah',
'Wyoming','New Hampshire','North Dakota','North','Dakot','Nebraska',
'Maine','California','Tennessee','Kansas',
'Oregon','Texas','Idaho','Alaska','Alabama') then timestamp_of_crash at time zone'cst'
 when state_name in('Oklahoma','Colorado','North Carolina',
'Mississippi','Florida','Vermont','Delaware','Nevada',
'Louisiana','New York','West Virginia',
'South Carolina','New Jersey','Hawaii','New Mexico',
'Arkansas','Missouri','Connecticut','South Dakota','District of Columbia',
'Indiana','Iowa','Massachusetts','Rhode Island','Ohio',
'Michigan','Minnesota','Pennsylvania','Washington','Kentucky','Wisconsin',
'Montana','Arizona','Illinois','Virginia','Maryland','Georgia','Utah',
'Wyoming','New Hampshire','North Dakota','North','Dakot','Nebraska',
'Maine','California','Tennessee','Kansas',
'Oregon','Texas','Idaho','Alaska','Alabama')  then timestamp_of_crash at time zone'ast'
 when state_name in('Oklahoma','Colorado','North Carolina',
'Mississippi','Florida','Vermont','Delaware','Nevada',
'Louisiana','New York','West Virginia',
'South Carolina','New Jersey','Hawaii','New Mexico',
'Arkansas','Missouri','Connecticut','South Dakota','District of Columbia',
'Indiana','Iowa','Massachusetts','Rhode Island','Ohio',
'Michigan','Minnesota','Pennsylvania','Washington','Kentucky','Wisconsin',
'Montana','Arizona','Illinois','Virginia','Maryland','Georgia','Utah',
'Wyoming','New Hampshire','North Dakota','North','Dakot','Nebraska',
'Maine','California','Tennessee','Kansas',
'Oregon','Texas','Idaho','Alaska','Alabama')  then timestamp_of_crash at time zone'mst' 
 when state_name in('Oklahoma','Colorado','North Carolina',
'Mississippi','Florida','Vermont','Delaware','Nevada',
'Louisiana','New York','West Virginia',
'South Carolina','New Jersey','Hawaii','New Mexico',
'Arkansas','Missouri','Connecticut','South Dakota','District of Columbia',
'Indiana','Iowa','Massachusetts','Rhode Island','Ohio',
'Michigan','Minnesota','Pennsylvania','Washington','Kentucky','Wisconsin',
'Montana','Arizona','Illinois','Virginia','Maryland','Georgia','Utah',
'Wyoming','New Hampshire','North Dakota','North','Dakot','Nebraska',
'Maine','California','Tennessee','Kansas',
'Oregon','Texas','Idaho','Alaska','Alabama')  then timestamp_of_crash at time zone'pst'
 when state_name in('Oklahoma','Colorado','North Carolina',
'Mississippi','Florida','Vermont','Delaware','Nevada',
'Louisiana','New York','West Virginia',
'South Carolina','New Jersey','Hawaii','New Mexico',
'Arkansas','Missouri','Connecticut','South Dakota','District of Columbia',
'Indiana','Iowa','Massachusetts','Rhode Island','Ohio',
'Michigan','Minnesota','Pennsylvania','Washington','Kentucky','Wisconsin',
'Montana','Arizona','Illinois','Virginia','Maryland','Georgia','Utah',
'Wyoming','New Hampshire','North Dakota','North','Dakot','Nebraska',
'Maine','California','Tennessee','Kansas',
'Oregon','Texas','Idaho','Alaska','Alabama') then timestamp_of_crash at time zone'akst' 
 when state_name in('Oklahoma','Colorado','North Carolina',
'Mississippi','Florida','Vermont','Delaware','Nevada',
'Louisiana','New York','West Virginia',
'South Carolina','New Jersey','Hawaii','New Mexico',
'Arkansas','Missouri','Connecticut','South Dakota','District of Columbia',
'Indiana','Iowa','Massachusetts','Rhode Island','Ohio',
'Michigan','Minnesota','Pennsylvania','Washington','Kentucky','Wisconsin',
'Montana','Arizona','Illinois','Virginia','Maryland','Georgia','Utah',
'Wyoming','New Hampshire','North Dakota','North','Dakot','Nebraska',
'Maine','California','Tennessee','Kansas',
'Oregon','Texas','Idaho','Alaska','Alabama') then timestamp_of_crash at time zone'hst'
 end timestamp_local
 from crash)

--tampilkan
select * from crash_clean
--filter duplicate 
select * from crash clean 
where consecutive_number in(280587,481975,280595,481976)

--delete duplicate
DELETE FROM crash  WHERE consecutive_number IN (280595, 481976)

-- Nomor 1. kondisi yang meningkatkan resiko kecelakaan

-- Kombinasi Kondisi
SELECT atmospheric_conditions_1_name, light_condition_name, manner_of_collision_name, type_of_intersection_name, functional_system_name, COUNT(*) as total_accidents, Sum(number_of_fatalities) as Jumlah_fatal
FROM crash_clean
WHERE EXTRACT(YEAR FROM timestamp_local) = 2021 
AND light_condition_name NOT IN ('Not Reported', 'Dark - Unknown Lighting', 'Other', 'Reported as Unknown')
AND atmospheric_conditions_1_name NOT IN ('Not Reported', 'Reported as Unknown','Other')
AND manner_of_collision_name NOT IN ('Other', 'Not Reported', 'Reported as Unknown')
AND type_of_intersection_name NOT IN ('Not Reported','Reported as Unknown')
AND functional_system_name NOT IN ('Not Reported', 'Unknown')
GROUP BY atmospheric_conditions_1_name, light_condition_name, manner_of_collision_name, type_of_intersection_name, functional_system_name
ORDER BY total_accidents DESC;

--Cara kecelakaan
select manner_of_collision_name, count (*) as total_accidents
from crash_clean 
where extract (year from timestamp_local) = 2021
AND light_condition_name NOT IN ('Not Reported', 'Dark - Unknown Lighting', 'Other', 'Reported as Unknown')
AND atmospheric_conditions_1_name NOT IN ('Not Reported', 'Reported as Unknown','Other')
AND manner_of_collision_name NOT IN ('Other', 'Not Reported', 'Reported as Unknown')
AND type_of_intersection_name NOT IN ('Not Reported','Reported as Unknown')
AND functional_system_name NOT IN ('Not Reported', 'Unknown')
group by manner_of_collision_name
ORDER BY total_accidents DESC;

--kondisi cuaca
select atmospheric_conditions_1_name, count (*) as total_accidents
from crash_clean 
where extract (year from timestamp_local) = 2021
AND light_condition_name NOT IN ('Not Reported', 'Dark - Unknown Lighting', 'Other', 'Reported as Unknown')
AND atmospheric_conditions_1_name NOT IN ('Not Reported', 'Reported as Unknown','Other')
AND manner_of_collision_name NOT IN ('Other', 'Not Reported', 'Reported as Unknown')
AND type_of_intersection_name NOT IN ('Not Reported','Reported as Unknown')
AND functional_system_name NOT IN ('Not Reported', 'Unknown')
group by atmospheric_conditions_1_name
ORDER BY total_accidents DESC;

--tipe persimpangan
select type_of_intersection_name, count (*) as total_accidents
from crash_clean 
where extract (year from timestamp_local) = 2021
AND light_condition_name NOT IN ('Not Reported', 'Dark - Unknown Lighting', 'Other', 'Reported as Unknown')
AND atmospheric_conditions_1_name NOT IN ('Not Reported', 'Reported as Unknown','Other')
AND manner_of_collision_name NOT IN ('Other', 'Not Reported', 'Reported as Unknown')
AND type_of_intersection_name NOT IN ('Not Reported','Reported as Unknown')
AND functional_system_name NOT IN ('Not Reported', 'Unknown')
group by type_of_intersection_name
ORDER BY total_accidents DESC;


--kondisi cahaya
select light_condition_name, count (*) as total_accidents
from crash_clean 
where extract (year from timestamp_local) = 2021
AND light_condition_name NOT IN ('Not Reported', 'Dark - Unknown Lighting', 'Other', 'Reported as Unknown')
AND atmospheric_conditions_1_name NOT IN ('Not Reported', 'Reported as Unknown','Other')
AND manner_of_collision_name NOT IN ('Other', 'Not Reported', 'Reported as Unknown')
AND type_of_intersection_name NOT IN ('Not Reported','Reported as Unknown')
AND functional_system_name NOT IN ('Not Reported', 'Unknown')
group by light_condition_name
ORDER BY total_accidents DESC;


-- Functional system name
select functional_system_name, count (*) as total_accidents
from crash_clean 
where extract (year from timestamp_local) = 2021
AND light_condition_name NOT IN ('Not Reported', 'Dark - Unknown Lighting', 'Other', 'Reported as Unknown')
AND atmospheric_conditions_1_name NOT IN ('Not Reported', 'Reported as Unknown','Other')
AND manner_of_collision_name NOT IN ('Other', 'Not Reported', 'Reported as Unknown')
AND type_of_intersection_name NOT IN ('Not Reported','Reported as Unknown')
AND functional_system_name NOT IN ('Not Reported', 'Unknown')
group by functional_system_name
ORDER BY total_accidents DESC;

--2. 10 teratas negara bagian di mana kecelakaan paling banyak terjadi
select state_name,
count (*) as jumlah_kecelakaan
from crash_clean
where extract (year from timestamp_local) = 2021
group by state_name
order by jumlah_kecelakaan desc
limit 10

--3. Jumlah rata-rata kejadian kecelakaan perhari berdasarkan jam terjadinya kecelakaan
--select to_char(timestamp_local, 'hh') 
--as jam, (count(1)/365) as kecelakaan
--from crash_clean
--group by jam
--order by jam
select EXTRACT(HOUR FROM timestamp_local) as hour,
(count(*) /365.00 ) as kecelakaan
from crash_clean
where extract (year from timestamp_local) = 2021
group by hour 
order by hour desc
--4. Persentase kecelakaan yang disebabkan oleh pengemudi yang mabuk
select to_char(timestamp_local, 'YYYY') AS year,

count (*) as jumlah_pmeabuk,
count (*) / (sum(count(*)) over())*100 As Persentage
from crash_clean
WHERE date_part('year', timestamp_local) = 2021
group by number_of_drunk_drivers
order by 4 desc


--

SELECT to_char(timestamp_local, 'YYYY') AS year,
count(*) total_report_accident,
  COUNT(CASE WHEN number_of_drunk_drivers > 0 THEN 1 END) AS drunk_driver,
  COUNT(CASE WHEN number_of_drunk_drivers = 0 THEN 1 END) AS no_drunk_driver,
  CAST(COUNT(CASE WHEN number_of_drunk_drivers > 0 THEN 1 END) * 100.0 / COUNT(*) AS decimal(5, 2)) AS percentage_drunk_drivers
FROM crash_clean
WHERE EXTRACT(YEAR FROM timestamp_local) = 2021
GROUP BY year

--5. Persentasi kecelakaan di daerah pedesaan dan perkotaan
select land_use_name,
2021 as Year,
count (*) as jumlah_kecelakaan,
count (*) / (sum(count(*)) over())*100 As Persentage
from crash_clean
WHERE date_part('year', timestamp_local) = 2021
group by land_use_name
order by 4 desc

--6. Jumlah kecelakaan berdasarkan hari
SELECT 
count(*),
to_char( timestamp_of_crash, 'Day') days
--cast (count(*) as float) / 365 as rata2_perhari 
FROM crash_clean
WHERE date_part('year', timestamp_local) ='2021'
group by days
order by 1 desc
