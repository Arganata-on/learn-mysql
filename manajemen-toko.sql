-- Active: 1748068829425@@127.0.0.1@3306@manajemen_toko
CREATE DATABASE manajemen_toko;

USE manajemen_toko;

CREATE TABLE user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    password VARCHAR(50),
    nama VARCHAR(60),
    role VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    last_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(60),
    alamat VARCHAR(255),
    no_telp VARCHAR(12),
    email VARCHAR(255) UNIQUE,
    tgl_registrasi DATE DEFAULT CURRENT_DATE,
    poin INT UNSIGNED,
    level ENUM('Bronze', 'Silver', 'Gold')
);

CREATE TABLE transaction (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    invoice_no VARCHAR(20) UNIQUE,
    tanggal DATE DEFAULT(CURRENT_DATE),
    total_harga DECIMAL(10, 2),
    diskon_global DECIMAL(4, 2),
    pajak DECIMAL(4, 2),
    metode_bayar ENUM('Cash', 'Cashless'),
    status ENUM('Berhasil', 'Gagal'),
    customer_id INT,
    user_id INT,
    CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES user (user_id)
);

CREATE TABLE installment (
    installment_id INT PRIMARY KEY AUTO_INCREMENT,
    jumlah DECIMAL(10, 2),
    tanggal_bayar DATE,
    metode ENUM('Transfer', 'Tunai'),
    status ENUM('Lunas', 'Belum Lunas'),
    transaction_id INT,
    CONSTRAINT fk_transaction_id FOREIGN KEY (transaction_id) REFERENCES transaction (transaction_id)
);

CREATE TABLE discount (
    discount_id INT PRIMARY KEY AUTO_INCREMENT,
    nama_program VARCHAR(255),
    tipe VARCHAR(255),
    nilai DECIMAL(5, 2),
    start_date DATE DEFAULT CURRENT_DATE,
    end_date DATE,
    min_pembelian INT DEFAULT 0
);

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    tanggal DATE DEFAULT CURRENT_DATE,
    tipe ENUM(
        'Masuk',
        'Keluar',
        'Penyesuaian'
    ),
    keterangan TEXT
);

CREATE TABLE category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    nama_kategori VARCHAR(255) UNIQUE,
    deskripsi TEXT,
    icon VARCHAR(255)
);

CREATE TABLE supplier (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(60),
    alamat VARCHAR(255),
    kota VARCHAR(255),
    kode_pos VARCHAR(10),
    no_telp VARCHAR(12),
    email VARCHAR(255) UNIQUE,
    npwp VARCHAR(15) UNIQUE,
    rekening_bank VARCHAR(255)
);

CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    barcode VARCHAR(255),
    nama VARCHAR(60),
    harga_beli DECIMAL(5, 2),
    harga_jual DECIMAL(5, 2),
    stok INT,
    min_stok INT,
    satuan VARCHAR(255),
    berat DECIMAL(8, 2),
    foto VARCHAR(255),
    is_active BOOLEAN,
    category_id INT,
    supplier_id INT,
    CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES category (category_id),
    CONSTRAINT fk_supplier_id FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id)
);

CREATE TABLE purchase (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    no_faktur INT,
    tanggal DATE DEFAULT CURRENT_DATE,
    total_harga DECIMAL(5, 2),
    status enum('Berhasil', 'Gagal'),
    jatuh_tempo DATE,
    supplier_id INT,
    user_id INT,
    FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id),
    FOREIGN KEY (user_id) REFERENCES user (user_id)
);

CREATE TABLE retur (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    tanggal DATE,
    jenis VARCHAR(255),
    status VARCHAR(255),
    transaction_id INT,
    purchase_id INT,
    user_id INT,
    FOREIGN KEY (transaction_id) REFERENCES transaction (transaction_id),
    CONSTRAINT fk_purchase_id FOREIGN KEY (purchase_id) REFERENCES purchase (purchase_id),
    FOREIGN KEY (user_id) REFERENCES user (user_id)
);

CREATE TABLE inventory_detail (
    inventory_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    qty_sebelum INT,
    qty_sesudah INT,
    selisih INT,
    inventory_id INT,
    product_id INT,
    CONSTRAINT fk_inventory_id FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id),
    CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES product (product_id)
);

CREATE TABLE purchase_detail (
    purchase_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    qty INT,
    harga_satuan DECIMAL(10, 2),
    expired_date DATE,
    subtotal DECIMAL(10, 2),
    purchase_id INT,
    product_id INT,
    FOREIGN KEY (purchase_id) REFERENCES purchase (purchase_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

CREATE TABLE return_detail (
    return_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    qty INT,
    alasan_detail TEXT,
    action VARCHAR(255),
    return_id INT,
    product_id INT,
    CONSTRAINT fk_return_id FOREIGN KEY (return_id) REFERENCES retur (return_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

CREATE TABLE transaction_detail (
    detail_id INT PRIMARY KEY AUTO_INCREMENT,
    qty INT,
    harga_satuan DECIMAL(10, 2),
    diskon DECIMAL(5, 2),
    subtotal DECIMAL(10, 2),
    transaction_id INT,
    product_id INT,
    FOREIGN KEY (transaction_id) REFERENCES transaction (transaction_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

INSERT INTO
    user (
        username,
        password,
        nama,
        role,
        email,
        last_login,
        is_active
    )
VALUES (
        'Woz',
        'woz123',
        'Arganata',
        'Admin',
        'arganata@gmail.com',
        CURRENT_TIMESTAMP,
        1
    ),
    (
        'Amarai',
        'amarai123',
        'Fadil',
        'Gudang',
        'amarai@gmail.com',
        CURRENT_TIMESTAMP,
        1
    ),
    (
        'Ked',
        'ked123',
        'Eko',
        'Manajer',
        'ked@gmail.com',
        CURRENT_TIMESTAMP,
        1
    ),
    (
        'Aestra',
        'aestra123',
        'Abbad',
        'Customer Service',
        'aestra@gmail.com',
        CURRENT_TIMESTAMP,
        1
    ),
    (
        'Mas San',
        'firman123',
        'Firman',
        'Kasir',
        'massan@gmail.com',
        CURRENT_TIMESTAMP,
        1
    );