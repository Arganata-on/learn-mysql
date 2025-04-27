SELECT COUNT(ammount) AS count
FROM transactions;
SELECT MAX(ammount) AS maximum
FROM transactions;
SELECT MIN(ammount) AS minimum
FROM transactions;
SELECT AVG(ammount) AS average
FROM transactions;
SELECT SUM(ammount) AS sum
FROM transactions;
SELECT * FROM employees;
SELECT CONCAT(first_name, ' ' ,last_name) AS full_name
FROM employees;