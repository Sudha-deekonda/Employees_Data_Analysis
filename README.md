# Employees_Data_Analysis
Employees_Data_Analysis

Finding trends in the number of employees from 1990 according to department, gender, pay, and the number of managers in each.

 

I chose this database since I worked on it while completing my course certification, so I think I am familiar with its contents by this point.
Our analysis in question will be carried with SQL, Excel and Tableau. SQL will serve as first repository for our data, Excel will be used to store the output of the queries in the form of tables (rows and columns) and Tableau will give a clear face to our data. 
As I already possess expertise from the Google Data Analytics Course, I will adhere to the guidelines provided. As a result, the following employees’ data analysis on gender will follow the 6 steps of Data Analysis which are: Ask, Prepare, Process, Analysis, Share and Act.

Step-1: Ask
In this step, we will define the business problem given to us which was interpreted as 
Business Objectives:
•	Find the trends in the employees of the organization based on gender since 1990.
•	Average annual salaries of each gender and also in each department.
•	Number of managers in each department and for each gender.
Deliverables:
•	A clear summary of the business objectives.
•	A full documentation of all the data manipulation and analysis.
•	A dashboard with visualizations and main outcomes.
•	Recommendations based on our insights and analysis.

Step-2: Prepare
In this phase, we will identify and assess the features of our Employees database:
•	The data is publicly available through GitHub under https://github.com/datacharmer/test_db/blob/master/employees.sql
Or you can directly download the database using the link https://www.dropbox.com/scl/fi/cs4nvueufh97f1oi9592t/employees.sql?rlkey=im4n5ff00ik69g2nfugrwdhk4&e=1&dl=0
•	Content:
The database contains simulated data about employees, departments, salaries, and titles, encompassing several million records. It's ideal for testing queries on a large scale.
•	Structure:
Tables include employees, departments, salaries, titles, dept_emp, and dept_manager.


 



•	It contains data records of employees hired between 01 January 1985 and 28 January 2000.
•	It contains the data records of 300024 employees and 967331 salary entries.
•	All these tables consists employee and department details like employee ID (emp_no), name (first_name, last_name), DOB (birth_date), gender, hire date, worked/working department, department ID (dept_no), department name (dept_name), work duration in that department (from_date, to_date), employee designation titles (title), salary, and so on. 
•	The only limitations of our dataset is that it is not current mean the most recent data point was almost 13 years ago. However, our data is quite reliable, original, and comprehensive. 

Step-3: Process
•	The database I use here is already in clean format ideal for analysis to discover relationships, trends and patterns that will help us in finding the business objectives. So we’ll directly move on to the analysis process.
•	However, we can always cross-check for any duplicates, missing values, data type conversions, standardizing formats, date formats, splitting or merging data using SQL statements like UPDATE, ALTER, DELETE, DROP, SELECT, CREATE, DISTINCT and so on.

Step-4: Analyze
In this phase, we will perform SQL query analysis on our database Employees. All the business objectives will be answered here. We will save the query result in Excel for easy access. At the end of our analysis, we will transition to a dashboard reflecting the answers to the most important components that will solve the business problems.
1.	Create a visualization that provides a breakdown between the male and female employees working in the company each year, starting from 1990. 
For this, we need to join the employees and dept_emp tables. We used COUNT function to get the total number of employees. And also created a calculated field labelled calendar year.

 
The query produced the following result
 

This query result table shows the breakdown of the employees based on gender from 1990 to 2002. 

2.	Compare the number of male managers to the number of female managers from different departments for each year, starting from 1990.
For this, we should join employees, dept_manager, departments tables. We used CASE statement to get an additional column which shows when the employee was serving as manager. 1 indicates active and 0 when employee is not manager. We also created sub query (inner query) where we joined all the required tables.

 

The query produced the following result

 

•	The total number of employees who were appointed managers in each year is now displayed in this table. Here, the active column provides us the overall manager duration picture.
•	This query result table shows a difference between number of male manager employees and female manager employees from different departments since 1990. 


3.	Compare the average salary of female versus male employees in the entire company until year 2002, and add a filter allowing you to see that per each department.
For this, we joined employees, dept_emp, departments, salaries tables to produce the required output. We used ROUND function to round off the decimals and used GROUP BY, HAVING clauses to group the data. 

 
The query produced the following result

 
•	The query result table holds the data of the company employees since 1990 to 2002 detailed by gender and department. The data in table format may be a bit complicated to analyse the trends in the annual salary but when this data transferred to Tableau, the data visualisation will help us in analysing the trend. 

4.	Create an SQL stored procedure that will allow you to obtain the average male and female salary per department within a certain salary range. Let this range be defined by two values the user can insert when calling the procedure.
To create an SQL stored procedure, we will follow the syntax of the same. I find it helpful to first drop any existing procedures to avoid misconception. So I used drop procedure statement. Delimiter has to be changed when you are creating procedure and do not forget to set back the delimiter. Then I created procedure named filter_salary with 2 input parameters. The actual query is written between BEGIN and END statements.

 

The query produced the following result

 
The stored procedure filter_salary when called with parameters (50000, 90000) produced the above table. We can see that there a very minimal difference between the average annual salaries of the male and female employees among various departments of the company. Although, the number of employees undertaken for this average calculation was unknown. To know that, we can add another in the query to show the number of employees. But, Tableau will help us in understanding the trends through visualizations with already existing data.

Step-5: Share
Onto sharing our observations, below you will find a picture of the interactive dashboard that represents the information collected from Employees database which was realised and demonstrated with Tableau.
You can also find the link to the interactive dashboard under the screenshot below. 
Here are our findings:

 
EMPLOYEES DATABASE ANALYSIS DASHBOARD

https://public.tableau.com/app/profile/sudha.deekonda/viz/SQL_employees_db/EmployeeAnalysis
Finally, let’s establish suggestions based on our observations and analysis

Step-6: Act
With everything that was covered, here are our conclusions and future recommendations for the success of our Company.
•	There was a significant growth in the numbers of male and female employees since 1990. The approx. proportion of male and female employees was 60% and 40% respectively throughout the time analysis.
•	When you filter data with single department, you will find that Quality Management department has the highest number of managers in sum of all years.
•	With the exception of the customer service department, male managers outnumbered female managers in practically every area.
•	When looking at the number of managers in each department, the most male managers where present in the Sales department in contrast to the other departments. And most female managers in the Customer Service department.
•	We can infer from the visualization that the yearly compensation of female employees has been steadily increasing. Nevertheless, there were some fluctuations in the yearly income of male employees between 1990 and 2002.
•	The average annual salary difference between male and female employees from 1990 to 1993 was practically less than $300. However, there was a notable difference from 1994. 
•	When the departments were added to the data, it became evident that the annual income of male employees was higher than that of female employees in every department.
•	Under categorising the salaries with departments, Quality Management and Sales departments have female employees’ annual salary more than that of male employees during initial years. But it eventually dropped.

I appreciate you taking the time to read my analysis and for your commitment to my project.


