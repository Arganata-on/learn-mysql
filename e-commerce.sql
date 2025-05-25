CREATE DATABASE e_commerce;
USE e_commerce;
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
CREATE TABLE kategori (
    id_kategori INT PRIMARY KEY,
    nama_kategori VARCHAR(255)
);
CREATE TABLE produk (
    id_produk INT PRIMARY KEY,
    nama_produk VARCHAR(255),
    harga INT,
    id_kategori INT,
    Foreign Key (id_kategori) REFERENCES kategori(id_kategori)
);
CREATE TABLE detail_pesanan (
    id_pesanan INT,
    id_produk INT,
    jumlah INT,
    Foreign Key (id_pesanan) REFERENCES pesanan(id_pesanan),
    Foreign Key (id_produk) REFERENCES produk(id_produk)
);
INSERT INTO pelanggan VALUES 
(1, 'Andi', 'andi@mail.com'),
(2, 'Budi', 'budi@mail.com');
INSERT INTO kategori VALUES 
(101, 'Elektronik'),
(102, 'Pakaian');
INSERT INTO produk VALUES 
(201, 'Laptop', 10000000, 101),
(202, 'Kaos',50000, 102);
INSERT INTO pesanan VALUES 
(301, '2025-05-01', 1),
(302, '2025-05-02', 2);
INSERT INTO detail_pesanan VALUES 
(301, 201, 1),
(302, 202, 2);
SELECT 
p.nama AS 'Nama Pelanggan', 
ps.tgl_pesanan AS 'Tanggal Pesanan',
pr.nama_produk AS 'Nama Produk',
k.nama_kategori AS 'Kategori Produk',
dp.jumlah AS 'Jumlah',
CONCAT('Rp ', REPLACE(FORMAT(pr.harga,0), ',', '.')) AS 'Harga Produk',
CONCAT('Rp ', REPLACE(FORMAT(pr.harga * dp.jumlah,0), ',', '.')) AS 'Total Biaya'
FROM detail_pesanan dp
INNER JOIN pesanan ps ON dp.id_pesanan = ps.id_pesanan
INNER JOIN pelanggan p ON ps.id_pelanggan = p.id_pelanggan
INNER JOIN produk pr ON dp.id_produk = pr.id_produk
INNER JOIN kategori k ON pr.id_kategori = k.id_kategori;
