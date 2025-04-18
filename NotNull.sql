-- fungsi dari NOT NULL itu buat memastikan bahwa kolom yang dikasih constraint ini nggak boleh kosong
-- alias nggak boleh diisi dengan nilai NULL.

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(25),
    product_price DECIMAL(4, 2) NOT NULL
);

ALTER TABLE products MODIFY product_price DECIMAL(4, 2) NOT NULL;

INSERT INTO products VALUES (104, "Cookie", NULL); -- ini gabisa, kenapa? karena product_price itu make NOT NULL