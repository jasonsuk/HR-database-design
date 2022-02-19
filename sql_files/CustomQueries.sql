-- Create a view that returns all attributes; 
-- which resemble initial Excel file
CREATE VIEW original_dataset AS
SELECT 
    emp.emp_id, 
    emp.emp_nm, 
    emp.email,
    rec.hire_dt,
    job.title_nm as job_title,
    sal.salary_amt as salary,
    dep.dept_nm as department,
    mng.emp_nm as manager,
    rec.start_dt,
    rec.end_dt,
    loc.loc_nm as location,
    loc.address,
    loc.city,
    loc.state,
    edu.edu_lvl as education_level
FROM employee_record as rec
LEFT JOIN job_title as job ON job.title_id = rec.title_id
LEFT JOIN salary as sal ON sal.salary_id = rec.salary_id
LEFT JOIN department as dep ON dep.dept_id = rec.dept_id
LEFT JOIN employee as emp ON emp.emp_id = rec.emp_id
LEFT JOIN employee as mng ON mng.emp_id = rec.mngr_id
LEFT JOIN education as edu ON edu.edu_lvl_id = emp.edu_lvl_id
LEFT JOIN location as loc ON loc.loc_id = emp.loc_id;


-- Create a stored procedure with parameters that returns 
-- current and past jobs (include employee name, job title,
-- department, manager name, start and end date for position) 
-- when given an employee name.

-- stored procedure is not avaiable in postgresql
-- CREATE OR REPLACE PROCEDURE employee_job_history (
--     emp_nm varchar(50)
-- )
-- LANGUAGE plpgsql
-- AS $$
-- BEGIN 
--     SELECT 
--         emp.emp_nm, 
--         job.title_nm, 
--         dep.dept_nm, 
--         mng.emp_nm,
--         rec.start_dt,
--         rec.end_dt
--     FROM employee_record as rec
--     LEFT JOIN employee as emp ON emp.emp_id = rec.emp_id
--     LEFT JOIN employee as mng ON mng.emp_id = rec.mngr_id
--     LEFT JOIN job_title as job ON job.title_id = rec.title_id
--     LEFT JOIN department as dep ON dep.dept_id = rec.dept_id
--     WHERE emp.emp_nm = emp_nm;
    
--     COMMIT;
-- END;$$

-- Use function instead
CREATE FUNCTION employee_job_history (employee_name varchar(50))
RETURNS TABLE (
    employee_name varchar(50),
    job_title varchar(100),
    department varchar(50),
    manager varchar(50),
    start_dt date,
    end_dt date
) AS $$
SELECT 
    emp.emp_nm, 
    job.title_nm, 
    dep.dept_nm, 
    mng.emp_nm,
    rec.start_dt,
    rec.end_dt
FROM employee_record as rec
LEFT JOIN employee as emp ON emp.emp_id = rec.emp_id
LEFT JOIN employee as mng ON mng.emp_id = rec.mngr_id
LEFT JOIN job_title as job ON job.title_id = rec.title_id
LEFT JOIN department as dep ON dep.dept_id = rec.dept_id
WHERE emp.emp_nm = employee_name;
$$ LANGUAGE SQL;


-- Create user NoMgr 
-- Grant access to the database
-- Revoke access to salary table\
CREATE USER NoMgr;
GRANT connect ON DATABASE postgres TO NoMgr;
REVOKE CONNECT ON DATABASE postgres FROM PUBLIC;
REVOKE ALL ON TABLE salary FROM NoMgr;