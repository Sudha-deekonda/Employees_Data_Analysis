USE employees;

-- USING aggregate functions in MySQL
-- count the number of employees worked/ working currently in the organization
SELECT COUNT(DISTINCT emp_no) AS Total_no_of_Employees FROM employees.employees;

-- count the number of male and female employees of the organization
SELECT gender, COUNT(emp_no) total_employees FROM employees 
GROUP BY gender;

-- using JOIN command clause to join multiple tables
-- select all managers’ first and last name, hire date, job title, start date, and department name.
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    dm.from_date,
    d.dept_name
FROM
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
        JOIN
    titles t ON dm.emp_no = t.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
WHERE
    t.title = 'Manager'
ORDER BY dm.emp_no;

-- nested subquries
-- Assign employee number 110022 as a manager to all employees from 10001 to 10020, and employee number 110039 as a manager to all employees from 10021 to 10040
SELECT 
    A.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS A 
UNION SELECT 
    B.*
FROM
    (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no BETWEEN 10021 AND 10040
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS B;

-- creating VIEW and calling it
-- create a view for all employees having latest from and to date and deliver the desired result
CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
    SELECT 
        emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY emp_no;
SELECT 
    *
FROM
    employees.v_dept_emp_latest_date;

-- Creating Stored Procedure
-- Create a procedure that will provide the average salary of all employees.
-- Then, call the procedure.
DELIMITER $$
CREATE PROCEDURE stored_procedure_avg_salary()
BEGIN
		SELECT
			AVG(salary)
		FROM
			salaries;
END$$
DELIMITER ;
CALL stored_procedure_avg_salary();

-- create a procedure
DROP PROCEDURE IF EXISTS emp_info;
DELIMITER $$
CREATE PROCEDURE emp_info(IN p_first_name VARCHAR(255), IN p_last_name VARCHAR(255), OUT p_emp_no INTEGER)
BEGIN 
SELECT 
    e.emp_no
INTO p_emp_no FROM
    employees e
WHERE
    e.first_name = p_first_name
        AND e.last_name = p_last_name;
END$$
DELIMITER ;

-- SQL Variables 
-- Create a local variable named v_emp_no containing the integer 10004.
-- Retrieve the employee number, first name, last name, and hire date of the employee with the employee number stored in v_emp_no.
-- To obtain the desired output, use the data from the employees table.
SET @v_emp_no = 10004;

SELECT e.emp_no, e.first_name, e.last_name, e.hire_date 
FROM employees e 
WHERE e.emp_no = @v_emp_no;

-- SQL Triggers
-- Create a trigger that checks if the hire date of an employee is higher than the current date. 
-- If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).
DELIMITER $$
CREATE TRIGGER trig_hire_date  
BEFORE INSERT ON employees
FOR EACH ROW  
BEGIN  
		IF NEW.hire_date > date_format(sysdate(), '%Y-%m-%d') THEN     
						SET NEW.hire_date = date_format(sysdate(), '%Y-%m-%d');     
		END IF;  
END $$  
DELIMITER ;  

INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  

SELECT  
    *  
FROM  
    employees
WHERE emp_no = 999904;

-- SQL CASE Statement
-- Salary details of the employees
SELECT 
    d.emp_no,
    e.first_name,
    e.last_name,
    e.hire_date,
    MIN(s.salary) AS min_salary,
    MAX(s.salary) AS max_salary,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN
            MAX(s.salary) - MIN(s.salary) > 0
                AND MAX(s.salary) - MIN(s.salary) <= 10000
        THEN
            'insignificant'
        WHEN MAX(s.salary) - MIN(s.salary) > 10000 THEN 'significant'
        ELSE 'salary decrease'
    END AS salary_raise
FROM
    dept_manager d
        JOIN
    employees e ON e.emp_no = d.emp_no
        JOIN
    salaries s ON s.emp_no = d.emp_no
WHERE
    d.emp_no > 10005
GROUP BY s.emp_no , e.first_name , e.last_name , e.hire_date
ORDER BY d.emp_no ASC;

-- Employee currently working or not
SELECT e.emp_no, e.first_name, e.last_name, 
CASE 
WHEN Max(d.to_date) >= sysdate() THEN "Currently working"
ELSE "No longer with the company"
END AS current_status
FROM dept_emp d 
JOIN employees e ON e.emp_no = d.emp_no
GROUP BY e.emp_no, e.first_name, e.last_name;
