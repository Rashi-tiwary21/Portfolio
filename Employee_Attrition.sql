SELECT * FROM portfolio_projects.hr_employee_attrition;
#1 Write an sql query to find the details of employees under attrition having 5+ years experience in between the age group of 27-35

select * 
From portfolio_projects.hr_employee_attrition
WHERE ï»¿Age between 27 and 35
AND Totalworkingyears >= 5;

#2 Fetch the details of employees having maximum and minimum salary working in different departments who recceived less than 13% salary hike

Select Department,
max(MonthlyIncome),min(MonthlyIncome)
FROM hr_employee_attrition
WHERE PercentSalaryHike < 13
group by Department;

#3 Fetch the details of employees having maximum  salary working in different departments who recceived less than 13% salary hike

SELECT Department,
max(MonthlyIncome)
FROM hr_employee_attrition
where percentsalaryhike < 13
group by Department
Order by max(MonthlyIncome) desc;

#4 calculate the average monthly income of all the employees who worked more than 3 years and whose education background is medical

Select avg(monthlyincome)
from hr_employee_attrition
where YearsAtCompany > 3
and EducationField = 'Medical'
Group by EducationField;

#5 identify the total no of male and female employees under atrrition whose marital satus is married and haven't recceived promotion in the last 2 years

Select gender, count(employeenumber)
FROM hr_employee_attrition
where MaritalStatus = 'Married'
and YearsSinceLastPromotion >2
and Attrition = 'Yes'
GROUP BY gender;

#6 employees with maximum performance rating but no promotion for 4 years and above

SELECT *
FROM hr_employee_attrition
WHERE PerformanceRating =(select max(PerformanceRating) from hr_employee_attrition)
AND YearsSinceLastPromotion >=4;

#7 who has maximum and minimum salary hike

SELECT YearsAtCompany, PerformanceRating, YearsSinceLastPromotion,
Max(PercentSalaryHike),
MIN(PercentSalaryHike)
FROM hr_employee_attrition 
GROUP BY YearsAtCompany, PerformanceRating, YearsSinceLastPromotion
ORDER BY MAX(PercentSalaryHike) asc, MIN(PercentSalaryHike) desc;

#8 Employees working overtime but given minimum salary  hike and are more than 5 years with the company

SELECT *
FROM hr_employee_attrition
WHERE OverTime = 'Yes'
AND PercentSalaryHike=(SELECT min(PercentSalaryHike) from hr_employee_attrition)
AND YearsAtCompany > 5;

#9 Employees working overtime but given maximum salary  hike and are more than 5 years with the company

SELECT *
FROM hr_employee_attrition
WHERE OverTime='Yes'
AND PercentSalaryHike=(SELECT max(PercentSalaryHike) FROM hr_employee_attrition)
AND YearsAtCompany > 5;

#10 Employees working  no overtime but given maximum salary  hike and are more than 5 years with the company

SELECT *
FROM hr_employee_attrition
WHERE OverTime='No'
AND PercentSalaryHike=(SELECT max(PercentSalaryHike) FROM hr_employee_attrition)
AND YearsAtCompany > 5;

#11 Employees working  no overtime but given minimum salary  hike and are more than 5 years with the company

SELECT *
FROM hr_employee_attrition
WHERE OverTime='No'
AND PercentSalaryHike=(SELECT min(PercentSalaryHike) FROM hr_employee_attrition)
AND YearsAtCompany > 5;

#12 find the maximum  and minimum realationship satisfaction as per employees marital status

SELECT MaritalStatus, max(RelationshipSatisfaction),min(RelationshipSatisfaction)
FROM hr_employee_attrition
GROUP BY MaritalStatus;
