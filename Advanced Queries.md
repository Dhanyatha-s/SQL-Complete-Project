
##Query 24: Rank employees based on their salary within their department.
```
select name, department_id,salary,
rank() over(partition by department_id order by salary desc) as rank_of_employees
from employees
```

##Query 25: Calculate the running total of salaries across the company.
```
select name, department_id,salary,
sum(salary) over(order by salary desc) as running_total
from employees
```

## Query 26: Calculate the average salary within each department and show it alongside each employee’s details.
```
select name, department_id, salary,
avg(salary) over(partition by department_id) as avg_dept_salary
from employees
```

## Query 27: Find the top 2 earners in each department using a CTE.\
```
with ranked_employees as (
select name, department_id, salary,
rank() over(partition by department_id order by salary desc) as rn from employees)
select name, department_id, salary
from ranked_employees
where rn <= 2
```

## Query 28: Calculate the percentage of total salary expense contributed by each department using a CTE.
```
with expense_contribution as(
select  department_id, sum(salary) as total_dept_salary
from employees
group by department_id)
select  department_id, total_dept_salary, (total_dept_salary * 100 / (select sum(salary) from employees)) as pct_contributon
from expense_contribution
```
## Query 30: Retrieve the names of employees whose salary is the highest in their respective departments.
```
select name, department_id, salary from employees
where salary = (select max(salary)  from employees e1
where e1.department_id = employees.department_id )
```

##Query 31: Create a view showing each department’s total salary and average salary.
```
create view each_dept_summary as 
select department_id, 
sum(salary) as total_salary,
avg(salary) as avg_salary 
from employees
group by department_id

SELECT * FROM each_dept_summary;
```

## Query 32: Create a view showing the top earner in each department.
```
create view top_earners_summary as 
select name as top_earners, department_id, salary from
employees
where salary = (select max(salary) as top_salary from employees as e2
					where e2.department_id = employees.department_id)
					
select * from top_earners_summary
```

## Query 33: Generate a monthly hiring trend report for employees.
```
SELECT 
    FORMAT(hire_date, 'yyyy-MM') AS hire_month,
    COUNT(*) AS no_employees
FROM employees
GROUP BY FORMAT(hire_date, 'yyyy-MM')
ORDER BY hire_month;
```

## Query 34: Generate a detailed salary report with department contributions.
```
SELECT e.department_id, e.salary, 
(e.salary / d.total_salary) * 100 as pct_contribution
from employees e
join(
select department_id, sum(salary) as total_salary from employees  group by department_id) as d
on
e.department_id = d.department_id
order by e.department_id, pct_contribution desc
```

## Query 35: Generate an overall company performance summary report.
```
create view  Company_summary  as
select 
count(*) as no_employee,
min(salary) as min_salary,
avg(salary) as avg_salary,
max(salary) as max_salary,
sum(salary) as total_salary
from employees
```
