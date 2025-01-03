## 1 Find the Avg Salary in each department
```
select department_id, avg(salary) as Avg_salary from employees group by department_id
```

## 2 List all employees hired after 2019
```
select employee_id, hire_date from employees where hire_date > '2019-01-01'
```
## 3 Find highest salary in each department
```
select department_id, name, salary as high_salary
 from (
        select department_id, name, salary,
        row_number() over (partition by department_id order by salary desc) as rn
        from employees ) ranked
where rn = 1
```
## Query 4: Count the number of employees in each department.
```
select department_id, count(*) as No_employees from employees group by department_id
```
## Query 5: Retrieve the total salary expense for the company
```
select sum(e.salary) as total_salary_for_employees,
		sum(s.salary) as gross_salary_from_company 
from employees e 
inner join 
salaries s on  e.employee_id = s.employee_id
```

## Query 6: List employees whose salary is above the average salary of their department.
``` 
select e.name, e.department_id, e.salary from employees e
join (select  department_id, avg(salary)as Avg_salry from employees
group by department_id)as dept_avg on e.department_id = dept_avg.department_id
where e.salary > dept_avg.Avg_salry
```
