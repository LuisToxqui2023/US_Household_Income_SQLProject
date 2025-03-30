-- US Household Income Data Cleaning 

SELECT * 
FROM us_project.us_household_income;

SELECT * 
FROM us_project.us_household_income_statistics;

-- Changing `ï»¿id`  into `id`
ALTER TABLE us_project.us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;

-- Checking the number of IDs for each table 
SELECT COUNT(id)
FROM us_project.us_household_income;

SELECT COUNT(id)
FROM us_project.us_household_income_statistics;

-- Checking for duplicates IDs from the us_household_income table
SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1; 

-- Removing the duplicates 
SELECT *
FROM (
SELECT row_id,
id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
FROM us_project.us_household_income
) AS duplicates
WHERE row_num > 1; 
 

DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id,
		id,
		ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) AS row_num
		FROM us_project.us_household_income
		) AS duplicates
	WHERE row_num > 1); 


-- Checking for duplicates IDs from the us_household_income_statistics table (none)
SELECT id, COUNT(id)
FROM us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1; 

--  Checking for State_Name spelling errors (georia and alabama)
SELECT State_Name, COUNT(State_Name)
FROM us_project.us_household_income
GROUP BY State_Name;

SELECT DISTINCT State_Name
FROM us_project.us_household_income
ORDER BY 1;

-- Changing/Correcting State Name error
UPDATE us_project.us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'; 

UPDATE us_project.us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama'; 

-- Checking State_ab for spelling errors (none)
SELECT DISTINCT State_ab
FROM us_project.us_household_income
ORDER BY 1; 

-- Checking for blanks in PLace
SELECT *
FROM us_household_income
WHERE Place = ''
ORDER BY 1; 

-- Updating blank in Place column
UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'; 

-- Checking Type column for errors
SELECT Type, COUNT(Type)
FROM us_project.us_household_income
GROUP BY Type; 

-- Updating Type error
UPDATE us_household_income 
SET Type = 'Borough'
WHERE  Type = 'Boroughs';
