CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

INSERT INTO customers (first_name, last_name)
VALUES  ("Fred", "Fish"),
        ("Larry", "Lobster"),
        ("Bubble", "Bass");

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    ammount DECIMAL(5, 2),
    customer_id INT,
    Foreign Key (customer_id) REFERENCES customers(customer_id)
);

ALTER TABLE transactions
ADD CONSTRAINT fk_customer_id
Foreign Key (customer_id) REFERENCES customers(customer_id);

INSERT INTO transactions (ammount, customer_id)
VALUES  (4.99, 3),
        (2.89, 2),
        (3.38, 3),
        (4.99, 1);