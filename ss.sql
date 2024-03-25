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



















