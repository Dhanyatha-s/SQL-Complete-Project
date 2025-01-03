-- DDL Commands
-- Create database
CREATE DATABASE company;
-- Employee Table
CREATE TABLE employees (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')), 
    date_of_birth DATE NOT NULL,
    hire_date DATE NOT NULL,
    department_id INT,
    job_title VARCHAR(100),
    salary INT,
    manager_id INT NULL,
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id) 
); 
INSERT INTO employees (name, gender, date_of_birth, hire_date, department_id, job_title, salary, manager_id) VALUES
('Alice Johnson', 'Female', '1985-07-23', '2010-06-15', 1, 'Software Engineer', 70000, NULL),
('Bob Smith', 'Male', '1980-04-12', '2008-09-22', 1, 'Team Lead', 90000, NULL),
('Charlie Brown', 'Male', '1990-03-03', '2015-01-10', 2, 'Accountant', 60000, 2),
('Diana White', 'Female', '1995-11-11', '2019-07-01', 2, 'Accountant', 50000, 3),
('Eve Davis', 'Female', '1988-08-25', '2013-03-18', 3, 'HR Manager', 75000, NULL);

-- Department table
CREATE TABLE departments (
    department_id INT  identity(1,1) PRIMARY KEY ,
    department_name VARCHAR(50) NOT NULL,
    budget INT NOT NULL,
    location VARCHAR(100)
);

INSERT INTO departments (department_name, budget, location) VALUES
('Engineering', 500000, 'New York'),
('Finance', 300000, 'Chicago'),
('Human Resources', 150000, 'Los Angeles');

-- Salary table
CREATE TABLE salaries (
    salary_id INT identity(1,1) PRIMARY KEY ,
    employee_id INT NOT NULL,
    effective_date DATE NOT NULL,
    salary INT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
); 
INSERT INTO salaries (employee_id, effective_date, salary) VALUES
(1, '2010-06-15', 70000),
(1, '2015-06-15', 80000),
(2, '2008-09-22', 90000),
(3, '2015-01-10', 60000),
(4, '2019-07-01', 50000),
(5, '2013-03-18', 75000);

-- Project Table
CREATE TABLE projects (
    project_id INT identity(1,1) PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE DEFAULT NULL,
    budget INT
); 
INSERT INTO projects (project_name, start_date, end_date, budget) VALUES
('AI Development', '2022-01-01', '2023-06-30', 200000),
('Financial Audit', '2021-05-01', NULL, 100000),
('HR System Overhaul', '2023-01-01', '2023-12-31', 50000); 

-- Employee Project table
CREATE TABLE employee_projects (
    employee_id INT NOT NULL,
    project_id INT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id),
    PRIMARY KEY (employee_id, project_id)
);

INSERT INTO employee_projects (employee_id, project_id) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3);

-- Performance Table
CREATE TABLE performance_reviews (
    review_id INT identity(1,1) PRIMARY KEY ,
    employee_id INT NOT NULL,
    review_date DATE NOT NULL,
    performance_rating INT CHECK (performance_rating BETWEEN 1 AND 5),
    feedback TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO performance_reviews (employee_id, review_date, performance_rating, feedback) VALUES
(1, '2023-06-30', 5, 'Excellent team player.'),
(2, '2023-06-30', 4, 'Good leadership skills.'),
(3, '2023-06-30', 3, 'Satisfactory performance.'),
(4, '2023-06-30', 2, 'Needs improvement in accuracy.'),
(5, '2023-06-30', 4, 'Very organized and proactive.');

-- Location Table
CREATE TABLE locations (
    location_id INT  identity(1,1) PRIMARY KEY ,
    location_name VARCHAR(100),
    country VARCHAR(50),
    region VARCHAR(50)
);

INSERT INTO locations (location_name, country, region) VALUES
('New York Office', 'USA', 'East Coast'),
('Chicago Office', 'USA', 'Midwest'),
('Los Angeles Office', 'USA', 'West Coast');

-- Leaves Table
CREATE TABLE leaves (
    leave_id INT  Identity(1,1) PRIMARY KEY ,
    employee_id INT NOT NULL,
    leave_start_date DATE NOT NULL,
    leave_end_date DATE NOT NULL,
    leave_type varchar(50) check(leave_type in ('Sick', 'Vacation', 'Unpaid')) Not Null,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO leaves (employee_id, leave_start_date, leave_end_date, leave_type) VALUES
(1, '2023-03-01', '2023-03-10', 'Vacation'),
(2, '2023-02-15', '2023-02-20', 'Sick'),
(3, '2023-04-01', '2023-04-05', 'Unpaid'),
(4, '2023-05-01', '2023-05-15', 'Vacation'),
(5, '2023-06-01', '2023-06-07', 'Sick');









