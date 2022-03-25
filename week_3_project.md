
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

A2 :  

* indicators of likely repurchase
    * promo used
    * *lower* than average delivery time (delivered_at - created_at)
    * order arrives *earlier* than expected (delivered_at < estimated_delivery_at)
    * has previously purchased
    * frequency - every month? every year? 
* indicators of likely to NOT purchase again
    * *higher* than average delivery time (delivered_at - created_at)
    * order arrives *later* than expected (delivered_at < estimated_delivery_at)
* Additional questions
    * Are there differences in cost, delivery time or accuracy of estimated delivery time between shpping services?
    * What is the user repeat purchase rate by *product*? Is it possible that if a certain product is purchased first, there is a higher liklihood of repeat purchase?
    * Define 'retention rate' - some amount of days - 90 days - did they make another purchase?
    * Does the amount of products ordered and total cost of order influence repeat purchasing behavior?
    * Can we tie events (website activity) to help predict repeat user purchase behavior?
* General questions
    * How long are people spending on our site?



---

**Q3: Explain the marts models you added. Why did you organize the models in the way you did?**

A3 : I relied heavily on the above exercise to build out my models. For example, I started with the customers model - and brought in information on purchasing behavior of the customer (total purchases, total unique products, etc). That way, this data would be available for easy analysis on repeat purchase rate. I followed a similar framework for fct_orders table - I pulled in additional data on each order (which in theory would help with analysis on repeat purchase rate) such as total # of products purchases, # unique products, delivery time, delivery actual vs. estimate, etc. 

---

## (Part 2) Tests 

**Q1 : What assumptions are you making about each model? (i.e. why are you adding each test?)**

A1: This was a challenging one. I didn't dig in enough to find specific instances of bad data - therefore most of my tests were very generic. In my experience, tests have been created after bad data enters in order to prevent it in the future. 

---

**Q2 : Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?**

A2 : No bad data was found.

---

**Q3 : Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.**

A3: I would set up scheduled jobs to refresh the models, and include tests. I would then set up an alerting system so that an analtyics engineer would see the alert and address the issue. 

---

