-- QN NO - 1
-- 1. Write a SQL query to remove the details of an employee whose first name ends in ‘even
SELECT * from EMPLOYEES where FIRST_NAME like '%even';
SELECT * from EMPLOYEES;
INSERT INTO EMPLOYEES(EMPLOYEE_ID,FIRST_NAME,LAST_NAME,EMAIL,PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMMISSION_PCT,MANAGER_ID,DEPARTMENT_ID)
values (203,'Steven','Grant','VBNM','622.373.7567','1999-05-21','SH_CLERK',2000,null,124,70);

-- QN NO - 2
-- 2. Write a query in SQL to show the three minimum values of the salary from the table.
SELECT FIRST_NAME,LAST_NAME,DEPARTMENT_ID,SALARY from EMPLOYEES ORDER BY SALARY ASC LIMIT 3;

-- QN NO - 3
-- 3. Write a SQL query to remove the employees table from the database
DROP TABLE EMPLOYEES;

-- QN NO - 4
-- 4. Write a SQL query to copy the details of this table into a new table with table name as Employee table and to delete the records in employees table
CREATE TABLE EMPLOYEE AS (SELECT * from EMPLOYEES);
DELETE FROM EMPLOYEES;

-- QN NO - 5
-- 5. Write a SQL query to remove the column Age from the table
ALTER TABLE EMPLOYEE DROP COLUMN AGE;

-- QN NO - 6
-- 6. Obtain the list of employees (their full name, email, hire_year) where they have joined the firm before 2000
SELECT concat(FIRST_NAME,' ',LAST_NAME) as FULL_NAME,EMAIL,YEAR(HIRE_DATE) as HIRE_YEAR from EMPLOYEES where YEAR(HIRE_DATE)<2000;

-- QN NO - 7
-- 7. Fetch the employee_id and job_id of those employees whose start year lies in the range of 1990 and 1999
SELECT EMPLOYEE_ID,JOB_ID from EMPLOYEES where YEAR(HIRE_DATE) between 1990 and 1999;

-- QN NO - 8
-- 8. Find the first occurrence of the letter 'A' in each employees Email ID
-- Return the employee_id, email id and the letter position
SELECT EMPLOYEE_ID,EMAIL,charindex('A',EMAIL) as LETTER_POSITION from EMPLOYEES;

-- QN NO - 9
-- 9. Fetch the list of employees(Employee_id, full name, email) whose full name holds characters less than 12
SELECT EMPLOYEE_ID,concat(FIRST_NAME,' ',LAST_NAME) as FULL_NAME,EMAIL from EMPLOYEES where LEN(FULL_NAME)<12;

-- QN NO - 10
-- 10. Create a unique string by hyphenating the first name, last name , and email of the employees to obtain a new field named UNQ_ID
-- Return the employee_id, and their corresponding UNQ_ID;
SELECT EMPLOYEE_ID,concat_ws('-',FIRST_NAME,LAST_NAME,EMAIL) as UNQ_ID from EMPLOYEES;

-- QN NO - 11
-- 11. Write a SQL query to update the size of email column to 30
ALTER TABLE HR.PUBLIC.EMPLOYEES ALTER COLUMN EMAIL varchar(30);

-- QN NO - 12
-- 12. Fetch all employees with their first name , email , phone (without extension part) and extension (just the extension)
-- Info : this mean you need to separate phone into 2 parts
-- eg: 123.123.1234.12345 => 123.123.1234 and 12345 . first half in phone column and second half in extension column
SELECT left(PHONE_NUMBER,(len(PHONE_NUMBER)-charindex('.',reverse(PHONE_NUMBER)))) as without_extension,
split_part(PHONE_NUMBER,'.',-1) as with_extension from EMPLOYEES;

-- QN NO - 13
-- 13. Write a SQL query to find the employee with second and third maximum salary.
SELECT SALARY from EMPLOYEES where SALARY < (SELECT max(SALARY) from EMPLOYEES) ORDER BY SALARY DESC limit 2;

-- QN NO - 14
-- 14. Fetch all details of top 3 highly paid employees who are in department Shipping and IT
SELECT * from EMPLOYEES,DEPARTMENTS where EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID 
and DEPARTMENTS.DEPARTMENT_NAME = 'Shipping' 
or DEPARTMENTS.DEPARTMENT_NAME = 'IT' order by SALARY DESC limit 3;

-- QN NO - 15
-- 15. Display employee id and the positions(jobs) held by that employee (including the current position)
SELECT EMPLOYEE_ID,JOB_TITLE from EMPLOYEES,JOBS where EMPLOYEES.JOB_ID = JOBS.JOB_ID 
UNION 
SELECT EMPLOYEE_ID,JOB_TITLE from JOBS,JOB_HISTORY where JOBS.JOB_ID = JOB_HISTORY.JOB_ID order by EMPLOYEE_ID;

-- QN NO - 16
-- 16. Display Employee first name and date joined as WeekDay, Month Day, Year
-- Eg :
-- Emp ID Date Joined
-- 1 Monday, June 21st, 1999
SELECT EMPLOYEE_ID,
case when dayofmonth(HIRE_DATE)%10=1 and dayofmonth(HIRE_DATE)!=11 then concat(DAYNAME(HIRE_DATE),',',MONTHNAME(HIRE_DATE),',',dayofmonth(HIRE_DATE),'st',',',YEAR(HIRE_DATE)) 
when dayofmonth(HIRE_DATE)%10=2 and dayofmonth(HIRE_DATE)!=12 then concat(DAYNAME(HIRE_DATE),',',MONTHNAME(HIRE_DATE),',',dayofmonth(HIRE_DATE),'nd',',',YEAR(HIRE_DATE))
when dayofmonth(HIRE_DATE)%10=3 and dayofmonth(HIRE_DATE)!=13 then concat(DAYNAME(HIRE_DATE),',',MONTHNAME(HIRE_DATE),',',dayofmonth(HIRE_DATE),'rd',',',YEAR(HIRE_DATE))
else concat(DAYNAME(HIRE_DATE),',',MONTHNAME(HIRE_DATE),',',dayofmonth(HIRE_DATE),'th',',',YEAR(HIRE_DATE)) end as DOJ from EMPLOYEES;

-- QN NO - 17
-- 17. The company holds a new job opening for Data Engineer (DT_ENGG) with a minimum salary of 12,000 and maximum salary of 30,000 . The job position might be removed based on market trends (so, save the changes) . - Later, update the maximum salary to 40,000 . - Save the entries as well.
-- - Now, revert back the changes to the initial state, where the salary was 30,000
ALTER SESSION SET AUTOCOMMIT = false;
INSERT INTO JOBS VALUES('DT_ENG','Data Engineer',12000,30000);
UPDATE JOBS set MAX_SALARY = 30000 where JOB_ID = 'DT_ENGG';
ROLLBACK;

SELECT * FROM JOBS;

-- QN NO - 18
-- 18. Find the average salary of all the employees who got hired after 8th January 1996 but before 1st January 2000 and round the result to 3 decimals
SELECT round(avg(SALARY),3) FROM EMPLOYEES where HIRE_DATE BETWEEN '08-JAN-1996' and '01-JAN-2000';

-- QN NO - 19 (A)
-- 19. Display Australia, Asia, Antarctica, Europe along with the regions in the region table (Note: Do not insert data into the table)
-- A. Display all the regions
-- B. Display all the unique regions

SELECT REGION_NAME from REGIONS 
union all SELECT 'Australia' 
union all SELECT 'Asia'  
union all SELECT 'Antartica'  
union all SELECT 'Europe';

-- QN NO - 19 (B)
SELECT REGION_NAME from REGIONS 
union SELECT 'Australia' 
union SELECT 'Asia' 
union SELECT 'Antartica' 
union SELECT 'Europe';







