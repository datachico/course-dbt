{{ 
    config(
        materialized='table'
    ) 
}}

with unique_sessions_by_product as (
  select 
    product_id
    , count(distinct session_id) as unique_sessions
  from {{ ref('fct_events')}}
  group by 1
),

purchased_products as (
  select
    session_id
    , events.order_id
    , order_items.product_id
  from {{ ref('fct_events')}} events
    left join {{ ref('stg_order_items')}} order_items on events.order_id = order_items.order_id
),

sessions_purchase_event_agg as (
  select 
    product_id
    , count(distinct session_id) as purchase_event_sessions 
  from purchased_products
  group by 1
),

conversion_rate as (
select 
   unique_sessions_by_product.product_id,
   unique_sessions,
   purchase_event_sessions
from unique_sessions_by_product
join sessions_purchase_event_agg
  on unique_sessions_by_product.product_id = sessions_purchase_event_agg.product_id
)


select 
  a.product_id,
  b.name,
  purchase_event_sessions,
  unique_sessions,
  round(purchase_event_sessions * 1.0 / unique_sessions * 100, 1) as conversion_rate
from conversion_rate a
left join "dbt"."dbt_patrick_n"."stg_products" b on a.product_id = b.product_id
