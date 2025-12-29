select * from ecommerce_delivery_analytics;


select  Platform  , avg(`Order Value (INR)`)
over (partition by platform) platform_avg , 
avg(`Order Value (INR)`) over () as overall_avg
from ecommerce_delivery_analytics
where `Order Value (INR)` > (select avg(`Order Value (INR)`)from ecommerce_delivery_analytics);

select platform , avg(`Delivery Time (Minutes)`) as del_time from ecommerce_delivery_analytics group by platform ;

------------- Target 1 -------------

------------- Total Orders -------------
select Platform , count(Platform) as total_orders from ecommerce_delivery_analytics 
group by platform order by total_orders desc;

------------- Total Revenue -------------
select Platform , sum(`Order Value (INR)`) as Total_Revenue from ecommerce_delivery_analytics
group by platform order by total_Revenue desc;

------------- Avg Delivery Time -------------
select Platform , avg(`Delivery Time (Minutes)`) as avg_delivery_time from ecommerce_delivery_analytics
group by platform order by avg_delivery_time desc;

------------- Avg Rating -------------
select Platform , avg(`Service Rating`) as avg_rating from ecommerce_delivery_analytics
group by platform order by avg_rating desc;

------------- Refund % -------------
select Platform , (sum(case when `Refund Requested` = 'Yes' Then 1 else 0 end)/
count(`Order ID`))*100 as refund_percentage
from ecommerce_delivery_analytics
group by platform order by refund_percentage desc;

------------- Target 2 -------------

------------- Avg Delivery Time by platform with Rank () -------------
select Platform , avg(`Delivery Time (Minutes)`) as avg_delivery_time,
rank() over (order by avg(`Delivery Time (Minutes)`) desc) as Ranking 
from ecommerce_delivery_analytics
group by platform order by Ranking ;

------------- Target 3 -------------

------------- Avg Delivery Delay by platform -------------
select Platform , sum(case when `Delivery Delay` = 'Yes' Then 1 else 0 end)
as Delivery_delay , count(`Order ID`) as total_orders 
from ecommerce_delivery_analytics
group by platform order by Delivery_delay desc;

------------- Target 4 -------------

------------- Refund % by platform -------------
select Platform , (sum(case when `Refund Requested` = 'Yes' Then 1 else 0 end)/
count(`Order ID`))*100 as refund_percentage
from ecommerce_delivery_analytics
group by platform order by refund_percentage desc;

------------- Refund % by delay bucket -------------
select Platform , (sum(case when `Refund Requested` = 'Yes' Then 1 else 0 end)/
count(case when `Delivery Delay` = 'Yes' Then 1 else 0 end))*100 as refund_percentage_per_delay
from ecommerce_delivery_analytics
group by platform order by refund_percentage_per_delay desc;

------------- Refund % by product category -------------
select  `Product Category` , (sum(case when `Refund Requested` = 'Yes' Then 1 else 0 end)/
count(*) )*100 as refund_percentage_per_product_category
from ecommerce_delivery_analytics
group by `Product Category` order by refund_percentage_per_product_category desc;

------------- Target 5 -------------

------------- Avg delivery time by category -------------
select `Product Category` , avg(`Delivery Time (Minutes)`) as avg_delivery_time_per_product
from ecommerce_delivery_analytics 
group by `Product Category` order by avg_delivery_time_per_product desc;

------------- Refund % by product category -------------
select  `Product Category` , (sum(case when `Refund Requested` = 'Yes' Then 1 else 0 end)/
count(*) )*100 as refund_percentage_per_product_category
from ecommerce_delivery_analytics
group by `Product Category` order by refund_percentage_per_product_category desc;

------------- Revenue by category -------------
select `Product Category` , sum(`Order Value (INR)`) as total_revenue 
from ecommerce_delivery_analytics
group by `Product Category` order by total_revenue desc;

------------- Target 6 -------------

------------- Extract hour from order time-------------

------------- Data Missing-------------

------------- Define peak hours (12–2, 6–9) -------------

------------- Data Missing-------------

------------- Compare delivery & refunds -------------
select `Delivery Delay` as Delivery ,
sum(case when `Refund Requested` = 'Yes' Then 1 else 0 end) as Refund
from ecommerce_delivery_analytics
group by `Delivery Delay` ;

------------- Target 7 -------------

------------- Delay + low rating + refund -------------
select platform ,count(`Order ID`) as Worst_orders 
from ecommerce_delivery_analytics
where `Delivery Delay` = "Yes" and `Service Rating` <=2 and `Refund Requested` = "Yes"
group by platform ;


------------- All Combine -------------

select Platform , count(Platform) as total_orders,
sum(`Order Value (INR)`) as Total_Revenue ,
avg(`Delivery Time (Minutes)`) as avg_delivery_time ,
avg(`Service Rating`) as avg_rating ,
(sum(case when `Refund Requested` = 'Yes' Then 1 else 0 end)/
count(`Order ID`))*100 as refund_percentage
from ecommerce_delivery_analytics
group by platform ;
