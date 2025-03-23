CREATE DATABASE tokopedia;

use tokopedia;

CREATE TABLE produk (
    id INT,
    nama_produk VARCHAR(255),
    kategori VARCHAR(255),
    harga DECIMAL(10, 2),
    stok INT
);

INSERT INTO
    produk
VALUES (
        1,
        "Laptop",
        "Elektronik",
        15000000.00,
        5
    ),
    (
        2,
        "Headset",
        "Aksesoris",
        350000.00,
        20
    ),
    (
        3,
        "Meja Belajar",
        "Furnitur",
        500000.00,
        10
    ),
    (
        4,
        "Buku Tulis",
        "Alat Tulis",
        12000.00,
        100
    ),
    (
        5,
        "Smartphone",
        "Elektronik",
        10000000.00,
        8
    );

SELECT * FROM produk;

SELECT *FROM produk
WHERE harga > 1000000.00;

SELECT *FROM produk
WHERE kategori = "Elektronik";

UPDATE produk
SET harga= 550000.00 
WHERE id = 3;

UPDATE produk
SET stok = 10
where id = 2;

DELETE FROM produk
WHERE stok <10;