
{{
  config(
    materialized='view'
  )
}}

select 
    order_id
    , user_id
    , promo_id
    , address_id
    , created_at as created_at_utc
    , order_cost
    , shipping_cost
    , order_total
    , tracking_id
    , shipping_service
    , estimated_delivery_at as estimated_delivery_at_utc
    , delivered_at as delivered_at_utc
    , delivered_at - created_at as delivery_duration
    , delivered_at - estimated_delivery_at as diff_actual_estimated_delivery
    , status

from {{ source('tutorial', 'orders') }}


