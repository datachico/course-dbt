{{ config(materialized='table') }}

with orders as (
    select * from {{ ref('stg_orders') }} 
)

, promos as (
    select * from {{ ref('stg_promos') }} 
)

, order_items as (
    select
        order_id
        , count(distinct product_id) as count_unique_products
        , sum(quantity) as count_total_products
    from {{ ref('stg_order_items') }} 
    group by 1
)



select 
  orders.*
  , count_unique_products
  , count_total_products
  , promo_discount
  , promo_status
from orders 
left join order_items
    on orders.order_id = order_items.order_id
left join promos
    on orders.promo_id = promos.promo_id
