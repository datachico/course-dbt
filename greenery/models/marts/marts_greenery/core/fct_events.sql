{{ 
    config(
        materialized='table'
        ) 
}}

with stg_events as (
    select * from {{ ref('stg_events') }}
)

select 
    session_id
    , user_id
    , page_url
    , created_at_utc
    , event_type
    , order_id
    , product_id
from stg_events