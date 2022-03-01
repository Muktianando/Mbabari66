/* 
    Name = Muktianando
    Project = Hotel_revenue
    date = 24/02/2022
 */

USE Hotel_Revenue ;

--- Union all table
select * into hotels from (
select DISTINCT * from dbo.[2018]
union 
select DISTINCT  * from dbo.[2019]
union 
select DISTINCT * from dbo.[2020] ) a
 ;

select * from hotels ;

select * into Hotels_all from ( hotels h
LEFT join dbo.market_segment ms on h.market_segment = ms.market_segment 
left join dbo.meal_cost mc on h.meal = mc.meal) ;

--- is revenue hotel growth per year ?

select DISTINCT
    Hotel,
    round(sum((stays_in_week_nights+stays_in_weekend_nights)*adr),2) as Revenue,
    arrival_date_year
from 
    hotels
GROUP by hotel, arrival_date_year 
ORDER BY hotel ;


--- Should we increase parking lot ?

Select DISTINCT
    hotel,
    sum(required_car_parking_spaces) as total_parking,
    arrival_date_year,
    arrival_date_month
FROM
    (
    select * from dbo.[2018]
    union 
    select * from dbo.[2019]
    union 
    select * from dbo.[2020]
    ) as hotels
GROUP by hotel, arrival_date_year, arrival_date_month 
ORDER By HOTEL ASC, arrival_date_year ASC, arrival_date_month ASC 

--- What trend can we see on data ? 

select
Hotel, 
round(AVG(adr),2) as total_revenue,
arrival_date_year,
arrival_date_month
from
(
select * from dbo.[2018]
union 
select * from dbo.[2019]
union 
select * from dbo.[2020]) as hotels
group by Hotel,arrival_date_year, arrival_date_month


--- Total of guest by customer type

Select 
    SUM(adults) as total_adults,
    sum(babies) as total_babies,
    sum(children) as total_children
from hotels ;

--- total of revenue by year

select* from hotels ;

select 
    MONTH(reservation_status_date),
    SUM((stays_in_week_nights+stays_in_weekend_nights)* (adr*discount)) as total_revenue
from hotels m
left join market_segment ms
on m.market_segment = ms.market_segment
group by MONTH(reservation_status_date)
ORDER BY MONTH(reservation_status_date)
;

select 
    SUM((stays_in_week_nights+stays_in_weekend_nights)* (adr*discount)) as total_revenue
from hotels m
left join market_segment ms
on m.market_segment = ms.market_segment
WHERE  YEAR(reservation_status_date) >= '2018'
;

select 
    SUM((stays_in_week_nights+stays_in_weekend_nights)* (adr*discount)) as total_revenue
from hotels m
left join market_segment ms
on m.market_segment = ms.market_segment
;