{{ 
    config(
        materialized='table'
    ) 
}}

with fct_events as (
    select * from {{ ref('fct_events') }}
)

{% set sql_statement %}
    select distinct event_type from {{ ref('fct_events') }}
{% endset %}

{%- set events = dbt_utils.get_query_results_as_dict(sql_statement) -%}

select
     session_id
     , created_at_utc
     , user_id
    {% for event_type in events['event_type']  -%}
      , sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}
    {% endfor %}
from fct_events
{{ dbt_utils.group_by(3) }}
