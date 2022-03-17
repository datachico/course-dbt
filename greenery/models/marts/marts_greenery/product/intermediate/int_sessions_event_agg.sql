{{ 
    config(
        materialized='table'
    ) 
}}

with fct_events as (
    select * from {{ ref('fct_events') }}
)

select 
    session_id
    , created_at_utc
    , user_id
    , sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped
    , sum(case when event_type = 'page_view' then 1 else 0 end) as page_view
    --add in 'checkout' and 'add_to_cart' - or macro
from fct_events
group by 1, 2, 3