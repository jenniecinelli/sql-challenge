--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM salaries AS s
JOIN employees AS e
on (e.emp_no = s.emp_no)

--2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1986-01-01'
	AND hire_date < '1987-01-01';
	
--3. List the manager of each department with the following information:
--department number, department name, the manager's employee number, last name, first name.
SELECT ma.dept_no, d.dept_name, ma.emp_no, e.last_name, e.first_name
FROM dept_manager AS ma
JOIN employees AS e
ON (e.emp_no = ma.emp_no)
	JOIN departments AS d
	ON(ma.dept_no = d.dept_no)


--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
	JOIN departments AS d
	ON(de.dept_no = d.dept_no)

--5. List first name, last name, and sex for employees whose first name is "Hercules" 
--and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
	AND last_name LIKE 'B%';

--6. List all employees in the Sales department, including their employee number, 
--last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
	JOIN departments AS d
	ON(de.dept_no = d.dept_no)
	WHERE dept_name = 'Sales'

--7. List all employees in the Sales and Development departments, including their employee number, 
--last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
	JOIN departments AS d
	ON(de.dept_no = d.dept_no)
	WHERE dept_name = 'Sales'
		OR dept_name = 'Development'

--8. In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS count_of_last_names
FROM employees
GROUP BY last_name;

--Epilogue ("Search your ID number.")
SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no = 499942;


--histogram to visualize the most common salary ranges for employees
CREATE VIEW salary_count AS
SELECT salary, COUNT(salary) AS count_of_salaries
FROM salaries
GROUP BY salary;

--bar chart of average salary by title
CREATE VIEW avg_salary AS
SELECT  t.title, avg(s.salary) as average_salary
FROM employees AS e
JOIN salaries AS s
ON (e.emp_no = s.emp_no)
	JOIN titles AS t
	ON(e.title_id = t.title_id)
	GROUP BY t.title
