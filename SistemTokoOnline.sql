CREATE DATABASE toko_online;
USE toko_online;
CREATE TABLE pelanggan (
    id_pelanggan INT PRIMARY KEY,
    nama VARCHAR(255),
    email VARCHAR(255)
);
CREATE TABLE pesanan (
    id_pesanan INT PRIMARY KEY,
    tgl_pesanan DATE,
    id_pelanggan INT,
    Foreign Key (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
);
INSERT INTO pelanggan VALUES (
    1, 'Andi', 'andi@mail.com'
), (
    2, 'Budi', 'budi@mail.com'
);
INSERT INTO pesanan VALUES (
    1001, '2025-04-26', 1
),(
    1002, '2025-04-26', 2
);
SELECT pelanggan.email, pesanan.tgl_pesanan FROM pesanan INNER JOIN pelanggan ON pesanan.id_pelanggan = pelanggan.id_pelanggan;