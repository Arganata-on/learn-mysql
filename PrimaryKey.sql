CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    ammount DECIMAL(5, 2)
); -- setiap id harus unik, dan tidak boleh ada  yang sama

SELECT * FROM transactions;

ALTER TABLE transactions
ADD CONSTRAINT
PRIMARY KEY (transaction_id); -- menambahkan primary key, ke  kolom transaction_id

INSERT INTO transactions
VALUES (NULL, 4.99); -- tidak boleh NULL atau kosong

SELECT ammount
FROM transactions
WHERE transaction_id = 1003;