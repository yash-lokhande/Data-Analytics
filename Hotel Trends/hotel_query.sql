-- Getting data insights
select * from Hotel..[2018]

select * from Hotel..[2019]

select * from Hotel..[2020];


-- Combing all the 3 tables into 1, as all of them have same columns with same data type (Creating temp table)
select * into hotels
from (
select * from Hotel..[2018]
union all
select * from Hotel..[2019]
union
select * from Hotel..[2020]
) as tmp


-- Getting Revenue column
select hotel, arrival_date_year, (stays_in_week_nights + stays_in_weekend_nights) * adr as revenue
from hotels


-- EDA
select arrival_date_year, round(sum((stays_in_week_nights + stays_in_weekend_nights) * adr),4) as revenue
from hotels
group by arrival_date_year
order by arrival_date_year desc;
-- The revenue for the hotel is low than the previous year.
-- adr = Average daily rates


-- Breaking it down by hotel type
select hotel, arrival_date_year, round(sum((stays_in_week_nights + stays_in_weekend_nights) * adr),4) as revenue
from hotels
group by hotel, arrival_date_year
order by arrival_date_year desc;
-- The revenue for the hotel is low than the previous year.


-- The data for 2020 is only limited to 8 months and 6 months for 2018
select count(distinct arrival_date_month) from Hotel..[2020] -- 8 months
select count(distinct arrival_date_month) from Hotel..[2019] -- 12 months
select count(distinct arrival_date_month) from Hotel..[2018] -- 6 months


-- Joining other 2 tables to the new table
select * from hotels h
join Hotel..market_segment ms
on h.market_segment = ms.market_segment
join Hotel..meal_cost mc
on h.meal = mc.meal;