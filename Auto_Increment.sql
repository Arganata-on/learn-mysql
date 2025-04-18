CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    ammount DECIMAL (5, 2)
);

INSERT INTO transactions (ammount)
VALUES (4.49);

ALTER TABLE transactions
AUTO_INCREMENT = 100;