sdddssds(1)How many users do we have?
    130
    select count(distinct user_id) from dbt_patrick_n."stg_users"

(2)On average, how many orders do we receive per hour?
    7.52

    with count_orders_by_hour as (
    select 
        date_trunc('hour', created_at) as distinct_hour,
        count(distinct order_id) as count_orders
    from
        dbt_patrick_n."stg_orders"
    group by 1
    )


    select avg(count_orders) from count_orders_by_hour

(3) On average, how long does an order take from being placed to being delivered?
    3 days 21:24:11.803279

    with delivery_duration as (
    select 
        order_id,
        created_at,
        delivered_at,
        delivered_at - created_at as delivery_duration
    from
        dbt_patrick_n."stg_orders"
    )

    select avg(delivery_duration) from delivery_duration

(4) How many users have only made one purchase? Two purchases? Three+ purchases?

    1 - 25
    2 - 28
    3+ - 71

with user_order_sum as (
  select 
    user_id, 
    count(distinct order_id) as order_count
  from dbt_patrick_n.stg_orders
  group by 1
  )
  
select 
  case 
  when order_count = 1 then '1'
  when order_count = 2 then '2'
  when order_count >= 3 then '3+'
  end
  , count(*)
from user_order_sum
group by 1
order by 1

(5) On average, how many unique sessions do we have per hour?

    16.32
    with count_sessions_by_hour as (
        select 
            date_trunc('hour', created_at) as distinct_hour,
            count(distinct session_id) as count_sessions
        from
            dbt_patrick_n."stg_events"
        group by 1
        )

        select avg(count_sessions) from count_sessions_by_hour