-- Fungsi DEFAULT di SQL itu buat menetapkan nilai standar (default) untuk suatu kolom
-- ketika tidak mengisinya saat melakukan INSERT data. Jadi, jika tidak menyediakan nilai untuk kolom itu, 
-- SQL secara otomatis akan memberikan nilai default yang sudah ditentukan.

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(25),
    price DECIMAL(4, 2) DEFAULT 0.00
);

ALTER TABLE products ALTER price SET DECIMAL(4, 2) DEFAULT 0.00;

INSERT INTO
    products (product_id, product_name)
VALUES (104, "straw"),
    (105, "napkin"),
    (106, "fork"),
    (107, "spoon");

SELECT * FROM products;

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    ammount DECIMAL(5, 2),
    transaction_date DATETIME DEFAULT NOW()
);

INSERT INTO transactions (ammount) VALUES (8.37)

SELECT * FROM transactions;

DROP TABLE transactions;