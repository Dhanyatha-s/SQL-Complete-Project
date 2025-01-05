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

## Query 6: List employees whose salary is above the average salary of their department.
```
select e.name, e.department_id, e.salary from employees e
join ( select department_id, avg(salary) as avg_salary  from employees group by department_id) as dept_avg
on
e.department_id = dept_avg.department_id
where salary > avg_salary 
```

## Query 7: Find the total number of employees hired each year.
```
select year(hire_date)as hired_year,count(*) as no_employees from employees
group by year(hire_date)
```
## Query 8: List departments with more than 2 employees.
```
select count(*) as no_employees, department_id from employees
group by department_id
having count(*) >= 2
```
##Query 9: Retrieve the details of the youngest employee (by hire date).
```
select * from employees
where hire_date = (select max(hire_date) from employees)
```
## Query 10: Retrieve the details of the oldest employee (by hire date).
```
select * from employees
where hire_date = (select min(hire_date)from employees)
```
## Query 11: Find the second-highest salary in the company.
```
select department_id, salary as secd_high_salary 
from 
	(select department_id, salary,
		ROW_NUMBER() over(order by salary desc) as rn from employees) ranked
where rn = 2
```
## Query 12: Find employees whose names start with the letter 'A'
```
select name from employees 
where name like 'A%'
```
## Query 13: Retrieve employees earning salaries within a range (e.g., 70,000 to 90,000).
```
select * from employees
where salary between '70000' and '90000'
```
## Query 14: Calculate the percentage of total salary expense contributed by each department.
```
SELECT department_id, 
       SUM(salary) AS department_salary, 
       (SUM(salary) / (SELECT SUM(salary) FROM employees) * 100) AS percentage_contribution
FROM employees
GROUP BY department_id;
```
## Query 15: Find employees with the same salary in different departments.
```
select e1.department_id as dept1, e1.name as empl1, 
		e2.department_id as dept2, e2.name as empl2, e1.salary 
from 
employees e1
join
employees e2
on e1.salary = e2.salary 
and e1.department_id != e2.department_id
```

## Query 16: List employees with unique salaries across the entire company.
```
select name, salary as unique_salary from employees
group by salary
having count(*) = 1
```


## Query 17: Find employees who have been with the company for more than 3 years.
```
SELECT name, department_id, hire_date, 
       DATEDIFF(DAY, hire_date, GETDATE()) / 365.0 AS years_in_company
FROM employees
WHERE DATEDIFF(DAY, hire_date, GETDATE()) / 365.0 > 3;
```

## Query 18: Calculate the average tenure of employees in each department.
```
select department_id, avg(DATEDIFF(DAY, hire_date, getdate()) /365) as tenure
from employees
group by department_id
```

## Query 19: Retrieve employees who are earning below the overall average salary.
```
SELECT name, department_id, salary
FROM employees
WHERE salary < (SELECT AVG(salary) FROM employees);
```

##Query 20: Identify departments where the total salary expense is above 250,000.
```
select department_id, sum(salary) as total_salary from employees
group by department_id
having sum(salary) > 250000
```

##Query 21: Retrieve the name and department of employees who have a salary that is at least 20% higher than their department's average salary.
```
select e.name, e.department_id, e.salary, dept_avg.avg_salary
from employees e
join
(select department_id, avg(salary) avg_salary from employees
group by department_id )  as dept_avg
on e.department_id = dept_avg.department_id
where e.salary > dept_avg.avg_salary * 1.2
```

##Query 22: Find the difference between the highest and lowest salaries in each department.
```
select department_id, max(salary) as highest_salary, min(salary) as lowest_salary,
max(salary) - min(salary) as diffrence from employees
group by department_id
```

##Query 23: Generate a report showing each department, the total salary, the average salary, and the number of employees.
```
select department_id, 
	sum(salary) as total_salry,
	avg(salary) as avg_salary,
	count(*) as no_employees
from employees
group by department_id
```
