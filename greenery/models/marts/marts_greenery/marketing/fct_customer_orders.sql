{{ 
    config(
        materialized='table'
    ) 
}}

with customers as (
    select * from {{ ref('stg_customers') }} 
)

, orders as (
    select * from {{ ref('stg_orders') }} 
)

, all_time_purchases as (
    select
        user_id
        , count(distinct order_id) as all_time_purchases
        , count(distinct case 
            when promo_id is not null then order_id 
            else null end) as promo_purchases
    from orders
    group by 1
)


, order_timing_by_customer as (
    select 
        user_id
        , avg(delivery_duration) as avg_delivery_duration
        , avg(diff_actual_estimated_delivery) as avg_diff_actual_est_delivery
    from orders
    group by 1
)


select 
    customers.user_id
    , first_name
    , last_name
    , email
    , all_time_purchases
    , promo_purchases
    , avg_delivery_duration
    , avg_diff_actual_est_delivery
from customers 
left join all_time_purchases
    on customers.user_id = all_time_purchases.user_id
left join order_timing_by_customer
    on customers.user_id = order_timing_by_customer.user_id
