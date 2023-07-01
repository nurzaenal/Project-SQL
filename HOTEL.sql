create table hotel
with hotels as (
select * from "2018" 
	union 
select * from "2019"
	union 
select * from "2020" 
)
select * from hotels as ho
left join  market_segment as mks
on ho.market_segment = mks.market_segment
left join meal_cost as mls
on mls.meal = ho.hotel


CREATE TABLE hotels AS 
WITH hotels AS (
  SELECT * FROM "2018"
  UNION 
  SELECT * FROM "2019"
  UNION 
  SELECT * FROM "2020"
)
SELECT *
FROM hotels
LEFT JOIN market_segment ON hotels.market_segment = market_segment.market_segment
LEFT JOIN meal_cost ON meal_cost.meal = hotels.meal


CREATE TABLE hotels AS 
WITH hotels AS (
  SELECT * FROM "2018"
  UNION 
  SELECT * FROM "2019"
  UNION 
  SELECT * FROM "2020"
)
SELECT hotels.*, a.market_segment,b.hotels
FROM hotels
LEFT JOIN market_segment ON hotels.market_segment = market_segment.market_segment
LEFT JOIN meal_cost ON meal_cost.meal = hotels.meal;

























CREATE TABLE hotel AS 
with hotels as (
select * from "2018" 
	union 
select * from "2019"
	union 
select * from "2020" 
)
SELECT ho.hotel_id, ho.arrival_date, ho.departure_date, ho.market_segment, ho.meal AS hotel_meal, mks.market_segment_desc, mls.cost
FROM hotels AS ho
LEFT JOIN market_segment AS mks
  ON ho.market_segment = mks.market_segment
LEFT JOIN meal_cost AS mls
  ON mls.meal = ho.meal;


