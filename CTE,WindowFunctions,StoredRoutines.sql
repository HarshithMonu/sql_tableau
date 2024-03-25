use employees;

delimiter $$
create procedure select_employees()
begin
 select * from employees limit 100;
end $$
delimiter ;

call employees.select_employees();

call select_employees();

delimiter $$
create procedure avg_sal()
begin
select avg(salary) from salaries;
end $$
delimiter ;

call avg_sal();

call new_sal();

drop procedure new_sal;

DELIMITER $$

CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)
BEGIN               SELECT 
    e.emp_no
INTO p_emp_no FROM
    employees e
WHERE		
    e.first_name = p_first_name
        AND e.last_name = p_last_name;
END$$
DELIMITER ;

set @v_avg_sal = 0;
call employees.emp_sal();

set @v_emp_n = 0;
call emp_info('Aruna','Journel',@v_emp_n);
select @v_emp_n;

select * from employees where hire_date>'2000-01-01';
create index i_hire_date on employees(hire_date);

show index from employees from employees;

alter table employees drop index i_hire_date;

SELECT 
    emp_no,
    first_name,
    last_name,
    CASE gender
        WHEN 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;
    
SELECT 
    emp_no,
    first_name,
    last_name,
    IF(gender = 'M', 'Male', 'Female') AS gender
FROM
    employees;


SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN dm.emp_no IS NOT NULL THEN 'Manager'
        ELSE 'Employee'
    END AS is_manager
FROM
    employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE
    e.emp_no > 109990;
    
SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'
        ELSE 'Salary was NOT raised by more then $30,000'
    END AS salary_raise
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;  

   

SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    IF(MAX(s.salary) - MIN(s.salary) > 30000,
        'Salary was raised by morethan 30,000',
        'Salary was NOT raised by morethan 30,000') AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;

select emp_no, salary , 
row_number() over(partition by emp_no order by salary desc) as row_num from salaries limit 100;

select emp_no,dept_no, row_number() over(order by emp_no) as row_num from dept_manager;

select emp_no, first_name, last_name , row_number() over(partition by first_name order by last_name) as row_num from employees;

SELECT
emp_no,
first_name,
ROW_NUMBER() OVER w AS row_num
FROM
employees
WINDOW w AS (PARTITION BY first_name ORDER BY emp_no);

SELECT
emp_no,
salary,
RANK() OVER w AS rank_num
#rank123356
#denserank1233456
FROM
salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

SELECT
emp_no,
    salary,
    LAG(salary) OVER w AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    salary - LAG(salary) OVER w AS diff_salary_current_previous,
LEAD(salary) OVER w - salary AS diff_salary_next_current
FROM
salaries
    WHERE emp_no =10500 WINDOW w AS (PARTITION BY emp_no ORDER BY salary);
    
    
SELECT 
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
        JOIN
    (SELECT 
        emp_no, Max(from_date) AS from_date
    FROM
        salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.from_date = s1.from_date;


SELECT
    de2.emp_no, d.dept_name, s2.salary, AVG(s2.salary) OVER w AS average_salary_per_department
FROM
    (SELECT
    de.emp_no, de.dept_no, de.from_date, de.to_date
FROM
    dept_emp de
        JOIN
(SELECT
emp_no, MAX(from_date) AS from_date
FROM
dept_emp
GROUP BY emp_no) de1 ON de1.emp_no = de.emp_no
WHERE
    de.to_date < '2002-01-01'
AND de.from_date > '2000-01-01'
AND de.from_date = de1.from_date) de2
JOIN
    (SELECT
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM
    salaries s
    JOIN
    (SELECT
emp_no, MAX(from_date) AS from_date
FROM
salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE
    s.to_date < '2002-01-01'
AND s.from_date > '2000-01-01'
AND s.from_date = s1.from_date) s2 ON s2.emp_no = de2.emp_no
JOIN
    departments d ON d.dept_no = de2.dept_no
GROUP BY de2.emp_no, d.dept_name
WINDOW w AS (PARTITION BY de2.dept_no)
ORDER BY de2.emp_no, salary;


WITH cte AS (
SELECT AVG(salary) AS avg_salary FROM salaries
)
SELECT
SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg_w_sum,
# COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_salaries_below_avg_w_count,
COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' CROSS JOIN cte c;


create temporary table f_max_sal
SELECT 
    s.emp_no, MAX(s.salary)
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND gender = 'f'
GROUP BY s.emp_no;

select * from f_max_sal limit 100;

CREATE TEMPORARY TABLE dates

SELECT

    NOW(),

    DATE_SUB(NOW(), INTERVAL 2 MONTH) AS two_months_earlier,

    DATE_SUB(NOW(), INTERVAL -2 YEAR) AS two_years_later;
    
select * from dates;








