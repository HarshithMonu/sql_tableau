SELECT 
    first_name, last_name, gender
FROM
    employees
where first_name='Kellie' and first_name='Aruna'
LIMIT 100;

use employees;

SELECT 
    dept_no
FROM
    departments;
SELECT 
    *
FROM
    departments;
    
SELECT 
    *
FROM
    employees
WHERE
    first_name = 'Denis'
        AND (gender = 'M' OR gender = 'F')
LIMIT 50;

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND (first_name = 'Kellie'
        OR first_name = 'Aruna');


SELECT 
    *
FROM
    employees
WHERE
    first_name NOT IN ('Aruna' , 'Kellie');
    
SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('Mark%'); #_ for exact search or % for anything before/after 
    
    
SELECT 
    *
FROM
    employees
WHERE
    hire_date LIKE ('%2000%');

SELECT 
    *
FROM
    employees
WHERE
    emp_no LIKE ('1000%');

SELECT 
    *
FROM
    employees
WHERE
    first_name LIKE ('%Jack%');
SELECT 
    *
FROM
    employees
WHERE
    first_name NOT LIKE ('%Jack%');


SELECT 
    *
FROM
    salaries
WHERE
    salary BETWEEN 66000 AND 70000;

SELECT 
    *
FROM
    employees
WHERE
    emp_no NOT BETWEEN 10004 AND 10012;

SELECT 
    *
FROM
    departments
WHERE
    dept_no BETWEEN 'd003' AND 'd006';

SELECT 
    *
FROM
    employees
WHERE
    first_name IS NOT NULL
LIMIT 100;

SELECT 
    *
FROM
    departments
WHERE
    dept_no IS NOT NULL;

SELECT 
    *
FROM
    employees
WHERE
    gender = 'F'
        AND hire_date >= '2000-01-01';

SELECT 
    *
FROM
    salaries
WHERE
    salary > '150000';

SELECT DISTINCT
    salary
FROM
    salaries;

SELECT DISTINCT
    hire_date
FROM
    employees;

SELECT 
    COUNT(DISTINCT hire_date)
FROM
    employees;

SELECT 
    COUNT(*)
FROM
    dept_manager;
SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary >= 100000;

SELECT 
    *
FROM
    employees
ORDER BY first_name , last_name ASC
LIMIT 100;

SELECT 
    first_name AS First_Name, COUNT(first_name) AS Count
FROM
    employees
GROUP BY first_name
ORDER BY first_name ASC
LIMIT 100;

SELECT 
    salary, COUNT(emp_no)
FROM
    salaries
where
    salary > 80000
GROUP BY salary
ORDER BY salary;

SELECT 
    salary, COUNT(emp_no)
FROM
    salaries
GROUP BY salary
having
   avg( salary) > 120000
ORDER BY salary;



SELECT 
    *
FROM
    employees
HAVING hire_date <= '1985-02-01';

SELECT 
    emp_no, AVG(salary)
FROM
    salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000;

SELECT 
    first_name, COUNT(first_name) AS Name_Count
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
ORDER BY COUNT(first_name) ASC;

SELECT 
    emp_no
FROM
    dept_emp
WHERE
    from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

/* INSERT */

insert into employees
(
emp_no,birth_date,first_name,last_name,gender,hire_date
)
 values
 (
 999901,'1973-04-03','Harshith','Beera','M','2011-01-01'
 );


insert into employees
 values
 (
 999911,'1970-04-03','Harshi','Beera','M','2011-01-21'
 );

insert into titles(emp_no,title,from_date) values(9999*3,'Sr Engineer','1997-10-01');
select * from titles where emp_no = 9999*3;


insert into dept_emp
(
                emp_no,
    dept_no,
    from_date,
    to_date
)
values
(
	 999903,
    'd005',
    '1997-10-01',
    '9999-01-01'
);

create table depart_dup(
dept_no char(4) not null,
dept_name varchar(40) not null
);

insert into depart_dup(dept_no, dept_name) select * from departments;

select * from depart_dup;

INSERT INTO departments VALUES ('d010', 'Business Analysis');

select * from departments order by dept_no;

update departments set dept_name = 'Data Analysis' where dept_no ='d010';

select * from titles where emp_no = 9999*3;
delete from employees where emp_no = 9999*3;

DELETE FROM departments
WHERE dept_no = 'd010';


select count(distinct dept_no) from dept_emp;

select round(avg(salary),2) from salaries where from_date>'1997-01-01';

select max(salary), min(salary),round(avg(salary),2) from salaries ;

select max(emp_no),min(emp_no) from employees;

select dept_no, ifnull(dept_name,'Dept Name N/A') from depart_dup;

select dept_no,dept_name,coalesce(dept_name,'Dept Name N/A') from depart_dup;


SELECT

    dept_no,

    dept_name,

    COALESCE(dept_no, dept_name) AS dept_info

FROM

    depart_dup

ORDER BY dept_no ASC;















    















