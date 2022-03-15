# Week 2 Project

## (Part 1) Models 

**Q1 : What is our user repeat rate? (Repeat Rate = Users who purchased 2 or more times / users who purchased)**

A1 : 

```sql
select 
count(user_id) 
from dbt_carlos_a.stg_users
```

**Q2 : What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?**

A2 :

**Q3: Explain the marts models you added. Why did you organize the models in the way you did?**

A3 :


## (Part 2) Tests 

**Q1 : What assumptions are you making about each model? (i.e. why are you adding each test?)**

A1: 

**Q2 : Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?**

A2 :

**Q3 : Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.**

A3: 