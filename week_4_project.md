
# Week 4 Project

## Part 2. Modeling challenge

---

**Q1 : How are our users moving through the product funnel?**

A1 : Was not able to complete.

---

**Q2 : Which steps in the funnel have largest drop off points?**

A2 : Was not able to complete.


## Part 3: Reflection questions -- please answer 3A or 3B, or both!

**Q1 : if your organization is thinking about using dbt, how would you pitch the value of dbt/analytics engineering to a decision maker at your organization?**

A1 : 

---

**Q2 : if your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?**

A2 : We are beginning to use it. One thing I plan to do differently is to document the models as much as possible and adapt a coherent SQL style guide to help make things as uniform as possible. 

---

**Q3 : if you are thinking about moving to analytics engineering, what skills have you picked that give you the most confidence in pursuing this next step?**

A3 : The confidence to build models, answer questions, write tests, ask for help in dbt chat, utilize dbt packages.

---

**4. Setting up for production / scheduled dbt run of your project And finally, before you fly free into the dbt night, we will take a step back and reflect: after learning about the various options for dbt deployment and seeing your final dbt project, how would you go about setting up a production/scheduled dbt run of your project in an ideal state? You don’t have to actually set anything up - just jot down what you would do and why and post in a README file. Hints: what steps would you have? Which orchestration tool(s) would you be interested in using? What schedule would you run your project on? Which metadata would you be interested in using? How/why would you use the specific metadata? , etc.**

A4: I would start the orchestration using the dbt cloud scheduling function. I would do a nightly run to start and if the stakeholders need more recent data I would explore doing it every 3-4 hours. If the orchestration becames overly complex, I would use Dagster to help organize.

