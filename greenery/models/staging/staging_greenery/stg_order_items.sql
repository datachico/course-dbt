
{{
  config(
    materialized='view'
  )
}}

select 
    order_id
    , product_id
    , quantity

from {{ source('tutorial', 'order_items') }}