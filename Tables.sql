CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hourly_pay DECIMAL(5, 2),
    hire_date DATE
);
SELECT * FROM employees;
RENAME TABLE workers TO employees;
DROP TABLE employees;
ALTER TABLE employees
ADD phone_number VARCHAR(15);
ALTER TABLE employees
RENAME COLUMN phone_number to email;
ALTER TABLE employees
MODIFY COLUMN email VARCHAR(100);
ALTER TABLE employees
MODIFY email VARCHAR(100)
after last_name;

ALTER TABLE employees
drop column email;