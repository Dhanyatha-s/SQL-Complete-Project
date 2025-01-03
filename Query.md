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
