-- Create tables
create table Job_title (
    title_id serial primary key,
    title_nm varchar(50)
);

create table Salary (
    salary_id serial primary key,
    salary_amt float
);

create table Department (
    dept_id serial primary key,
    dept_nm varchar(100)
);

create table Education (
    edu_lvl_id serial primary key,
    edu_lvl varchar(50)
);

create table Location (
    loc_id serial primary key,
    loc_nm varchar(50),
    address varchar(200),
    city varchar(50),
    state varchar(50)
);

-- Create employee table
-- Many forien keys exists so done last
create table Employee (
    emp_id varchar(20) not null primary key,
    emp_nm varchar(50),
    email varchar(100),
    edu_lvl_id int references Education(edu_lvl_id),
    loc_id int references Location(loc_id)
);

create table Employee_record (
    record_id serial primary key,
    emp_id varchar(50) references employee(emp_id),
    hire_dt date,
    start_dt date,
    end_dt date,
    title_id int references job_title(title_id),
    salary_id int references salary(salary_id),
    dept_id int references department(dept_id),
    mngr_id varchar(50) references employee(emp_id)
);



-- Insert data into new tables from stage table (proj_stg)
INSERT INTO job_title (title_nm)
SELECT DISTINCT job_title FROM proj_stg;

INSERT INTO salary (salary_amt) 
SELECT DISTINCT salary FROM proj_stg;

INSERT INTO department (dept_nm)
SELECT DISTINCT department_nm FROM proj_stg;

INSERT INTO education (edu_lvl)
SELECT DISTINCT education_lvl FROM proj_stg;

INSERT INTO location (loc_nm, address, city, state)
SELECT DISTINCT location, address, city, state FROM proj_stg;

INSERT INTO employee (emp_id, emp_nm, email, edu_lvl_id, loc_id)
SELECT DISTINCT Emp_ID, Emp_NM, Email, edu.edu_lvl_id, loc.loc_id
FROM proj_stg as stg 
JOIN education as edu ON edu.edu_lvl = stg.education_lvl
JOIN location as loc 
    ON loc.loc_nm = stg.location
    AND loc.address = stg.address
    AND loc.city = stg.city
    AND loc.state = stg.state;

-- There are some duplicated records for Emp_ID, Emp_NM 
-- possibly resulted from internal transfer, promotion, etc.
-- SELECT Emp_ID, Emp_NM, COUNT(*)
-- FROM proj_stg
-- GROUP BY Emp_ID, Emp_NM
-- HAVING COUNT(*) > 1;

-- Insert into employee record table
INSERT INTO employee_record ( emp_id, hire_dt, start_dt, end_dt, title_id, salary_id, dept_id, mngr_id )
SELECT DISTINCT 
    emp.emp_id,
    stg.hire_dt,
    stg.start_dt,
    stg.end_dt,
    job.title_id,
    sal.salary_id,
    dep.dept_id,
    mng.emp_id
FROM proj_stg AS stg
LEFT JOIN employee AS emp ON emp.emp_id = stg.emp_id
LEFT JOIN job_title AS job ON job.title_nm = stg.job_title
LEFT JOIN salary AS sal ON sal.salary_amt = stg.salary
LEFT JOIN department AS dep ON dep.dept_nm = stg.department_nm
LEFT JOIN employee AS mng ON mng.emp_nm = stg.manager;

-- One record with emp_id = 'E17054' does not have mngr_id
-- It is for the President who does not have a manager
SELECT employee.emp_nm, proj_stg.job_title FROM employee
JOIN proj_stg ON employee.emp_id = proj_stg.emp_id
WHERE employee.emp_id = 'E17054';

----------------------------------------------------------------
-- CRUD 
-- 1. Return a list of employees with job titles and dept names
SELECT rec.emp_id, emp.emp_nm, job.title_nm, dep.dept_nm
FROM employee_record as rec
JOIN employee as emp ON emp.emp_id = rec.emp_id
JOIN job_title as job ON job.title_id = rec.title_id
JOIN department as dep ON dep.dept_id = rec.dept_id;

-- 2. Insert Web Programmer as a new job title
INSERT INTO Job_title (title_nm)
VALUES ('Web Programmer');

-- 3. Correct the job title web programmer to web developer
UPDATE Job_title 
SET title_nm = 'Web Developer'
WHERE title_nm = 'Web Programmer';

-- 4. Delete the job title web developer
DELETE FROM Job_title
WHERE title_nm = 'Web Developer';

-- 5. How many employees are in each department?
SELECT dep.dept_id, dep.dept_nm, COUNT(*)
FROM Employee_record as rec
JOIN Department as dep ON dep.dept_id = rec.dept_id
GROUP BY 1,2;

-- 6.Write a query that returns current and past jobs 
-- (include employee name, job title, department, manager name, start and end date for position) 
-- for employee Toni Lembeck.\

SELECT 
    emp.emp_nm as employee_nm, 
    job.title_nm as job_title, 
    dep.dept_nm as department,
    mng.emp_nm as manager_nm,
    rec.start_dt,
    rec.end_dt
FROM Employee_record as rec
JOIN Employee as emp ON emp.emp_id = rec.emp_id
JOIN Job_title as job ON job.title_id = rec.title_id
JOIN Department as dep ON dep.dept_id = rec.dept_id
JOIN Employee as mng ON mng.emp_id = rec.mngr_id
WHERE emp.emp_nm = 'Toni Lembeck';








