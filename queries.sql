/*
List the following details of each employee: 
employee number, last name, first name, gender, and salary.
*/

select salaries.emp_no, last_name, first_name, gender, salaries.salary
from employees
join salaries on employees.emp_no=salaries.emp_no;

/*
List employees who were hired in 1986.
*/

select *
from employees
where substring(cast(hire_date as varchar), 1, 4) = '1986';


/*
List the manager of each department 
with the following information: 
department number, department name, 
the manager's employee number, last name, first name, 
and start and end employment dates.
*/

select dept_manager.dept_no, departments.dept_name, 
employees.emp_no, employees.first_name, employees.last_name, dept_manager.from_date, dept_manager.to_date
from dept_manager
inner join departments on dept_manager.dept_no=departments.dept_no
inner join employees on dept_manager.emp_no=employees.emp_no;

/*

List the department of each employee with the following information: 
employee number, last name, first name, and department name.
*/


select employees.emp_no, employees.last_name, employees.first_name, sub1.dept_name
from employees
inner join 
(
  select * from dept_manager
  join 
  ( 
   select * from departments
   ) sub
  on sub.dept_no = dept_manager.dept_no
  ) sub1
on sub1.emp_no = employees.emp_no;

/*
List all employees whose 
first name is "Hercules" and last names begin with "B."
*/

select emp_no, first_name, last_name 
from employees
where first_name = 'Hercules' and last_name like 'B%';


/*
List all employees in the Sales department, 
including their employee number, last name, first name, and department name.
*/

select employees.emp_no, employees.last_name, employees.first_name, sub1.dept_name
from employees
inner join (
  select dept_manager.emp_no, sub.dept_name
  from dept_manager
  inner join 
  (
    select * from departments
    where departments.dept_name = 'Sales'
  ) sub
  on sub.dept_no = dept_manager.dept_no
) sub1
on sub1.emp_no = employees.emp_no;

/*
List all employees in the Sales and Development departments, 
including their employee number, last name, first name, and department name.
*/

select employees.emp_no, employees.last_name, employees.first_name, sub1.dept_name
from employees
inner join (
  select dept_manager.emp_no, sub.dept_name
  from dept_manager
  inner join 
  (
    select * from departments
    where departments.dept_name = 'Sales' or departments.dept_name = 'Development'
  ) sub
  on sub.dept_no = dept_manager.dept_no
) sub1
on sub1.emp_no = employees.emp_no;

/*
In descending order, 
list the frequency count of employee last names, i.e., 
how many employees share each last name.
*/
select last_name, count(*) as freq
 from   employees
 group by last_name
 order by freq desc;
 
