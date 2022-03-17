{{ 
    config(
        materialized='table'
    ) 
}}

with session_length as (
    select
        session_id
        , min(created_at_utc) as first_event
        , max(created_at_utc) as last_event
    from {{ ref('fct_events')}}
    group by 1

)

select 
    int_session_events_agg.session_id
    , int_session_events_agg.user_id
    , dim_customers.first_name
    , dim_customers.last_name
    , dim_customers.email
    , int_session_events_agg.page_view
    , int_session_events_agg.package_shipped
    , session_length.first_event as first_session_event
    , session_length.last_event as last_session_event
    --consider converting to minutes
    , session_length.last_event::timestamp - session_length.first_event::timestamp as session_length
from {{ ref('int_session_events_agg')}}
left join {{ ref('dim_customers') }}
    on int_session_events_agg.user_id = dim_customers.user_id
left join session_length
    on int_session_events_agg.session_id = session_length.session_id