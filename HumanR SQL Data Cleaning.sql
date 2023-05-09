CREATE DATABASE projects;

USE projects;

SELECT * FROM HumanR;

ALTER TABLE HumanR
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE HumanR;

SELECT birthdate FROM HumanR;

SET sql_safe_updates = 0;

UPDATE HumanR
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE HumanR
MODIFY COLUMN birthdate DATE;

UPDATE HumanR
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE HumanR
MODIFY COLUMN hire_date DATE;

SELECT hire_date
From HumanR

UPDATE HumanR
SET termdate =date(str_to_date(termdate, '%Y-%m-%d%H:%i:%s UTC')) 
WHERE termdate IS NOT NULL AND termdate!='';

ALTER TABLE HumanR
MODIFY COLUMN termdate DATE;

ALTER TABLE HumanR
MODIFY COLUMN Age INT;

SELECT termdate 
FROM HumanR;

UPDATE HumanR
SET age = timestampdiff(YEAR, birthdate, CURDATE());


SELECT * FROM HumanR;

SELECT 
	min(age) AS youngest,
    max(age) AS oldest
FROM HumanR;

SELECT count(*) FROM HumanR WHERE age < 18;

SELECT COUNT(*) FROM HumanR WHERE termdate > CURDATE();

SELECT COUNT(*)
FROM HumanR
WHERE termdate IS NULL

SELECT location FROM HumanR;