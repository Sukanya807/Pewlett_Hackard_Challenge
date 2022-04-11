
--Deliverable 1

-- Creating table for retiring employees with title
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       t.titles,
       t.from_date,
       t.to_date
INTO retirement_titles
FROM employees AS e
LEFT JOIN titles AS t
ON (e.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
                            rt.first_name,
                            rt.last_name,
                            rt.titles
INTO unique_titles
FROM retirement_titles AS rt
WHERE rt.to_date=('9999-01-01')
ORDER BY rt.emp_no ASC, rt.to_date DESC;


--Count number of employees by retirement title
SELECT COUNT(ut.titles),ut.titles
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.titles
ORDER BY COUNT(ut.titles) DESC;

--End of Deliverable 1

--Deliverable 2

--Employees eligible to participate in a Mentorship Program
SELECT DISTINCT ON (e.emp_no) e.emp_no,
                              e.first_name,
                              e.last_name,
                              e.birth_date,
                              de.from_date,
                              de.to_date,
                              t.titles
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no=de.emp_no
INNER JOIN titles AS t
ON e.emp_no=t.emp_no
WHERE de.to_date=('9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no ASC

--End of Deliverable 2

--Deliverable 3.1

--Number of employees retiring with department name
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
                            rt.first_name,
                            rt.last_name,
                            rt.titles,
                            d.dept_name
INTO retirement_dept
FROM retirement_titles AS rt
INNER JOIN dept_emp AS de
ON (rt.emp_no=de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no=d.dept_no)
WHERE rt.to_date=('9999-01-01')
ORDER BY rt.emp_no ASC, rt.to_date DESC;


--Future Vacancies by Department and Title
SELECT COUNT(rd.emp_no),rd.dept_name
INTO retirement_dept_dev3_1
FROM retirement_dept AS rd
GROUP BY rd.dept_name
ORDER BY rd.dept_name

--Deliverable 3.2

--Employees eligible to participate in a Mentorship Program
SELECT DISTINCT ON (me.emp_no) me.emp_no,
                            me.first_name,
                            me.last_name,
                            me.titles,
                            d.dept_name
INTO mentorship_dept
FROM mentorship_eligibility AS me
INNER JOIN dept_emp AS de
ON (me.emp_no=de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no=d.dept_no)
ORDER BY me.emp_no ASC;

--Mentors Available by Department 
SELECT COUNT(md.emp_no),md.dept_name
INTO mentorship_title_dept_dev3_2
FROM mentorship_dept AS md
GROUP BY md.dept_name
ORDER BY md.dept_name
