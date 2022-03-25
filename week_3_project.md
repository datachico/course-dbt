
# Week 3 Project

## (Part 1) Conversion Rate 

---

**Q1 : What is our overall conversion rate?**

A1 : 62.5 %

```sql
with calculation_table as (
  select 
    count(distinct session_id) as distinct_sessions
    , sum(checkout) as purchased_sessions 
  from "dbt"."dbt_patrick_n"."int_session_events_agg"
)

select 
  purchased_sessions / distinct_sessions * 100 as conversion_rate
from calculation_table 
```

---

**Q2 : What is our conversion rate by product?**

A2 : See file fct_product_conversion.sql

```sql
with unique_sessions_by_product as (
  select 
    product_id
    , count(distinct session_id) as unique_sessions
  from {{ ref('stg_events')}}
  group by 1
),

purchased_products as (
  select
    session_id
    , events.order_id
    , order_items.product_id
  from {{ ref('stg_events')}} events
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

```


## (Part 2)  

**Q1 : Create a macro to simplify part of a model(s)**

A1: See 'int_session_events_agg.sql'. I found this a bit challenging to initially set up. I'm used to being able to print / debug in python so I'm still figuring out the best ways to do it in the dbt / jinja world. I'm curious as to if there is a more efficient elegant way to do this. 

---

## (Part 3)  

**Q1 : Create Post-hook**

A1: Added. I'm still unclear on the exact use cases for running a post-hook at the model level vs. run-end (at the end of all the models.) As I start to use dbt more, I'm sure I'll see some examples for why this would be useful.

---

## (Part 4)  

**Q1 : Try dbt packages**

A1: =

---

## (Part 5)  

**Q1 : Show new DAG.**

A1: =

---