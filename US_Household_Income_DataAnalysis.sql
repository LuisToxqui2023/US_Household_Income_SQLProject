-- Us Household Income Exploratory Data Analysis 

-- Checking the highest sum of land or water by each state
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 2 DESC; 

SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 3 DESC; 

-- Checking the Top 10 sum of land by state
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10;  

-- Checking the Top 10 sum of water by state
SELECT State_Name, SUM(ALand), SUM(AWater)
FROM us_project.us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10;

-- Generally checking the State Nme, County, Type, Primary, Mean and Median from both tables without 0 as the Mean 
SELECT u.State_Name, County, Type, `Primary`, Mean, Median 
FROM us_project.us_household_income u 
INNER JOIN us_project.us_household_income_statistics us 
	ON u.id = us.id
WHERE Mean <> 0; 

-- Checking the average mean and median for each state from both tables 
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1) 
FROM us_project.us_household_income u 
INNER JOIN us_project.us_household_income_statistics us 
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2; 

-- Cheking for the bottom 5 states based on average income
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1) 
FROM us_project.us_household_income u 
INNER JOIN us_project.us_household_income_statistics us 
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2
LIMIT 5; 

-- Checking for the top 5 states based on average income
SELECT u.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1) 
FROM us_project.us_household_income u 
INNER JOIN us_project.us_household_income_statistics us 
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 5;

-- Checking the top 5 types based on average income from both tables 
SELECT Type, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_project.us_household_income u
INNER JOIN us_project.us_household_income_statistics us 
	ON u.id = us.id 
WHERE Mean <> 0
GROUP BY Type 
ORDER BY 2 DESC
LIMIT 5; 

-- Checking the highest average income cities
SELECT u.State_Name, City, ROUND(AVG(Mean),1)
FROM us_project.us_household_income u 
JOIN us_household_income_statistics us 
	ON u.id = us.id 
GROUP BY u.State_Name, City 
ORDER BY ROUND(AVG(Mean),1) DESC;