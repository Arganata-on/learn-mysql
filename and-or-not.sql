-- AND
SELECT *
FROM employees
WHERE hire_date < '2023-01-05' AND job = 'cook';

SELECT *
FROM employees
WHERE hire_date BETWEEN '2023-01-04' AND '2023-01-07';

-- OR
SELECT *
FROM employees
WHERE job = 'cook' OR job = "cashier";

SELECT *
FROM employees
WHERE job IN ('cook', 'cashier', 'janitor');

-- NOT
SELECT *
FROM employees
WHERE NOT job = 'manager' AND NOT job = 'asst. manager';