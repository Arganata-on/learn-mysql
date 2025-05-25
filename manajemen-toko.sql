-- Active: 1748068829425@@127.0.0.1@3306@phpmyadmin
CREATE DATABASE manajemen_toko;

USE manajemen_toko;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50),
    password VARCHAR(255),
    nama VARCHAR(60),
    role VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    last_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    nama VARCHAR(60),
    alamat VARCHAR(255),
    no_telp VARCHAR(15),
    email VARCHAR(255) UNIQUE,
    tgl_registrasi DATE DEFAULT CURRENT_DATE,
    poin INT UNSIGNED DEFAULT 0,
    level ENUM('Bronze', 'Silver', 'Gold') DEFAULT 'Bronze'
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
    npwp VARCHAR(20) UNIQUE,
    rekening_bank VARCHAR(255)
);

CREATE TABLE product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    barcode VARCHAR(255),
    nama VARCHAR(60),
    harga_beli DECIMAL(10, 2),
    harga_jual DECIMAL(10, 2),
    stok INT NOT NULL,
    min_stok INT DEFAULT 0,
    satuan VARCHAR(50),
    berat DECIMAL(8, 2),
    foto VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    category_id INT NOT NULL,
    supplier_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category (category_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id)
);

CREATE TABLE transaction (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    invoice_no VARCHAR(20) UNIQUE,
    tanggal DATE DEFAULT CURRENT_DATE,
    total_harga DECIMAL(12, 2),
    diskon_global DECIMAL(5, 2),
    pajak DECIMAL(5, 2),
    metode_bayar ENUM('Cash', 'Cashless'),
    status ENUM('Berhasil', 'Gagal'),
    customer_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE purchase (
    purchase_id INT PRIMARY KEY AUTO_INCREMENT,
    no_faktur VARCHAR(20),
    tanggal DATE DEFAULT CURRENT_DATE,
    total_harga DECIMAL(12, 2),
    status enum('Berhasil', 'Gagal'),
    jatuh_tempo DATE,
    supplier_id INT NOT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE discount (
    discount_id INT PRIMARY KEY AUTO_INCREMENT,
    nama_program VARCHAR(255),
    tipe VARCHAR(50),
    nilai DECIMAL(10, 2),
    start_date DATE DEFAULT CURRENT_DATE,
    end_date DATE,
    min_pembelian INT DEFAULT 0
);

CREATE TABLE installment (
    installment_id INT PRIMARY KEY AUTO_INCREMENT,
    jumlah DECIMAL(12, 2),
    tanggal_bayar DATE DEFAULT CURRENT_DATE,
    metode ENUM('Transfer', 'Tunai'),
    status ENUM('Lunas', 'Belum Lunas'),
    transaction_id INT NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES transaction (transaction_id)
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

CREATE TABLE inventory_detail (
    inventory_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    qty_sebelum INT,
    qty_sesudah INT,
    selisih INT,
    inventory_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

CREATE TABLE purchase_detail (
    purchase_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    qty INT,
    harga_satuan DECIMAL(12, 2),
    expired_date DATE,
    subtotal DECIMAL(12, 2),
    purchase_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (purchase_id) REFERENCES purchase (purchase_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

CREATE TABLE transaction_detail (
    detail_id INT PRIMARY KEY AUTO_INCREMENT,
    qty INT,
    harga_satuan DECIMAL(10, 2),
    diskon DECIMAL(5, 2),
    subtotal DECIMAL(12, 2),
    transaction_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES transaction (transaction_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

CREATE TABLE `return` (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    tanggal DATE,
    jenis VARCHAR(255),
    status VARCHAR(255),
    transaction_id INT NULL,
    purchase_id INT NULL,
    user_id INT NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES transaction (transaction_id),
    FOREIGN KEY (purchase_id) REFERENCES purchase (purchase_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE return_detail (
    return_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    qty INT,
    alasan_detail TEXT,
    action VARCHAR(255),
    return_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (return_id) REFERENCES `return` (return_id),
    FOREIGN KEY (product_id) REFERENCES product (product_id)
);

INSERT INTO
    users (
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

INSERT INTO
    customer (
        nama,
        alamat,
        no_telp,
        email,
        tgl_registrasi,
        poin,
        level
    )
VALUES (
        'Budi Santoso',
        'Jl. Sudirman No. 45, Jakarta',
        '081234567890',
        'budi@email.com',
        '2023-05-25',
        100,
        'Silver'
    ),
    (
        'Siti Aisyah',
        'Jl. Merdeka No. 12, Bandung',
        '081234567891',
        'siti@email.com',
        '2023-05-20',
        250,
        'Gold'
    ),
    (
        'Andi Wijaya',
        'Jl. Asia Afrika No. 88, Surabaya',
        '081234567892',
        'andi@email.com',
        '2023-05-10',
        50,
        'Bronze'
    ),
    (
        'Rizky Pratama',
        'Jl. Gatot Subroto No. 30, Semarang',
        '081234567893',
        'rizky@email.com',
        '2023-05-18',
        180,
        'Silver'
    ),
    (
        'Dewi Lestari',
        'Jl. Diponegoro No. 77, Yogyakarta',
        '081234567894',
        'dewi@email.com',
        '2023-05-22',
        320,
        'Gold'
    );

INSERT INTO
    category (
        nama_kategori,
        deskripsi,
        icon
    )
VALUES (
        'Elektronik',
        'Kategori untuk produk elektronik seperti laptop, smartphone, dan TV.',
        'icon_electronics.png'
    ),
    (
        'Perabotan',
        'Kategori untuk perabotan rumah tangga seperti meja, kursi, dan lemari.',
        'icon_furniture.png'
    ),
    (
        'Fashion',
        'Kategori untuk pakaian, sepatu, dan aksesoris.',
        'icon_fashion.png'
    ),
    (
        'Makanan & Minuman',
        'Kategori untuk produk makanan dan minuman kemasan.',
        'icon_food.png'
    ),
    (
        'Otomotif',
        'Kategori untuk aksesoris kendaraan dan suku cadang.',
        'icon_automotive.png'
    );

INSERT INTO
    supplier (
        nama,
        alamat,
        kota,
        kode_pos,
        no_telp,
        email,
        npwp,
        rekening_bank
    )
VALUES (
        'PT Elektronik Jaya',
        'Jl. Sudirman No. 12',
        'Jakarta',
        '10110',
        '081234567890',
        'elektronikjaya@email.com',
        '12.345.678.9-012.000',
        '123-456-789'
    ),
    (
        'CV Sukses Makmur',
        'Jl. Diponegoro No. 34',
        'Bandung',
        '40235',
        '081234567891',
        'suksesmakmur@email.com',
        '98.765.432.1-234.000',
        '987-654-321'
    ),
    (
        'UD Berkah Sejahtera',
        'Jl. Ahmad Yani No. 78',
        'Surabaya',
        '60123',
        '081234567892',
        'berkahsejahtera@email.com',
        '56.789.012.3-456.000',
        '567-890-123'
    ),
    (
        'Toko Sumber Indah',
        'Jl. Gatot Subroto No. 55',
        'Semarang',
        '50241',
        '081234567893',
        'sumberindah@email.com',
        '34.567.890.5-678.000',
        '345-678-901'
    ),
    (
        'PT Mega Sentosa',
        'Jl. Merdeka No. 99',
        'Yogyakarta',
        '55122',
        '081234567894',
        'megasentosa@email.com',
        '78.901.234.7-890.000',
        '789-012-345'
    );

INSERT INTO
    product (
        barcode,
        nama,
        harga_beli,
        harga_jual,
        stok,
        min_stok,
        satuan,
        berat,
        foto,
        is_active,
        category_id,
        supplier_id
    )
VALUES (
        '123456789012',
        'Laptop ASUS X450',
        500000,
        500000,
        10,
        2,
        'Unit',
        2.5,
        'laptop_asus.jpg',
        1,
        1,
        2
    ),
    (
        '987654321098',
        'Smartphone Samsung A55',
        750000,
        750000,
        15,
        3,
        'Unit',
        0.5,
        'samsung_a55.jpg',
        1,
        2,
        3
    ),
    (
        '567890123456',
        'Printer Epson L310',
        250000,
        250000,
        20,
        5,
        'Unit',
        3.2,
        'printer_epson.jpg',
        1,
        3,
        4
    ),
    (
        '654321789012',
        'Keyboard Mechanical RGB',
        180000,
        180000,
        50,
        10,
        'Unit',
        0.8,
        'keyboard_rgb.jpg',
        1,
        4,
        1
    ),
    (
        '112233445566',
        'Monitor LG 24 Inch',
        400000,
        400000,
        12,
        2,
        'Unit',
        5.5,
        'monitor_lg.jpg',
        1,
        5,
        2
    );

INSERT INTO
    transaction (
        invoice_no,
        tanggal,
        total_harga,
        diskon_global,
        pajak,
        metode_bayar,
        status,
        customer_id,
        user_id
    )
VALUES (
        'INV-001',
        '2023-05-25',
        900000,
        10.00,
        5.00,
        'Cash',
        'Berhasil',
        1,
        5
    ),
    (
        'INV-002',
        '2023-05-24',
        712500,
        5.00,
        2.50,
        'Cashless',
        'Berhasil',
        2,
        5
    ),
    (
        'INV-003',
        '2023-05-23',
        637500,
        20.00,
        10.00,
        'Cash',
        'Gagal',
        3,
        3
    ),
    (
        'INV-004',
        '2023-05-22',
        918000,
        15.00,
        7.50,
        'Cashless',
        'Berhasil',
        4,
        5
    ),
    (
        'INV-005',
        '2023-05-21',
        1235200,
        8.00,
        3.20,
        'Cash',
        'Berhasil',
        5,
        5
    );

INSERT INTO
    transaction_detail (
        qty,
        harga_satuan,
        diskon,
        subtotal,
        transaction_id,
        product_id
    )
VALUES (
        2,
        500000,
        10.00,
        2 * 500000 * (1 -0.10),
        1,
        1
    ),
    (
        1,
        750000,
        5.00,
        1 * 750000 * (1 -0.05),
        2,
        2
    ),
    (
        3,
        250000,
        15.00,
        3 * 250000 * (1 -0.15),
        3,
        3
    ),
    (
        5,
        180000,
        8.00,
        5 * 180000 * (1 -0.08),
        4,
        4
    ),
    (
        4,
        400000,
        12.50,
        4 * 400000 * (1 -0.125),
        5,
        5
    );

INSERT INTO
    installment (
        jumlah,
        tanggal_bayar,
        metode,
        status,
        transaction_id
    )
VALUES (
        900000,
        '2023-05-25',
        'Transfer',
        'Lunas',
        1
    ),
    (
        712500,
        '2023-05-24',
        'Transfer',
        'Belum Lunas',
        2
    ),
    (
        637500,
        '2023-05-23',
        'Transfer',
        'Lunas',
        3
    ),
    (
        918000,
        '2023-05-22',
        'Tunai',
        'Belum Lunas',
        4
    ),
    (
        1235200,
        '2023-05-21',
        'Transfer',
        'Belum Lunas',
        5
    );

INSERT INTO
    inventory (tanggal, tipe, keterangan)
VALUES (
        '2025-05-25',
        'Masuk',
        'Pembelian barang dari supplier'
    ),
    (
        '2025-05-22',
        'Keluar',
        'Penjualan produk ke pelanggan'
    ),
    (
        '2025-05-20',
        'Masuk',
        'Restock barang setelah retur'
    ),
    (
        '2025-05-18',
        'Keluar',
        'Pengiriman produk ke cabang lain'
    ),
    (
        '2025-05-15',
        'Masuk',
        'Barang tambahan dari promo supplier'
    );

INSERT INTO
    inventory_detail (
        qty_sebelum,
        qty_sesudah,
        selisih,
        inventory_id,
        product_id
    )
VALUES (10, 15, 5, 1, 1),
    (15, 13, -2, 2, 2),
    (20, 25, 5, 3, 3),
    (50, 45, -5, 4, 4),
    (12, 10, -2, 5, 5);

INSERT INTO
    purchase (
        no_faktur,
        tanggal,
        total_harga,
        status,
        jatuh_tempo,
        supplier_id,
        user_id
    )
VALUES (
        '1001',
        '2025-05-15',
        5000000.00,
        'Berhasil',
        '2025-06-15',
        2,
        1
    ),
    (
        '1002',
        '2025-05-18',
        7500000.00,
        'Gagal',
        '2025-06-18',
        3,
        1
    ),
    (
        '1003',
        '2025-05-20',
        2500000.00,
        'Berhasil',
        '2025-06-20',
        4,
        3
    ),
    (
        '1004',
        '2025-05-22',
        1800000.00,
        'Gagal',
        '2025-06-22',
        1,
        5
    ),
    (
        '1005',
        '2025-05-25',
        6500000.00,
        'Berhasil',
        '2025-06-25',
        5,
        5
    );

INSERT INTO
    purchase_detail (
        qty,
        harga_satuan,
        expired_date,
        subtotal,
        purchase_id,
        product_id
    )
VALUES (
        10,
        50000,
        '2026-06-15',
        10 * 50000,
        1,
        1
    ),
    (
        5,
        75000,
        '2026-07-10',
        5 * 75000,
        2,
        2
    ),
    (
        20,
        25000,
        '2026-08-05',
        20 * 25000,
        3,
        3
    ),
    (
        8,
        180000,
        '2026-09-20',
        8 * 180000,
        4,
        4
    ),
    (
        15,
        400000,
        '2026-10-30',
        15 * 400000,
        5,
        5
    );

INSERT INTO
    `return` (
        tanggal,
        jenis,
        status,
        transaction_id,
        purchase_id,
        user_id
    )
VALUES (
        '2025-06-01',
        'Barang Rusak',
        'Diproses',
        1,
        NULL,
        3
    ),
    (
        '2025-06-03',
        'Kesalahan Pengiriman',
        'Selesai',
        2,
        1,
        5
    ),
    (
        '2025-06-05',
        'Kadaluarsa',
        'Gagal',
        NULL,
        2,
        1
    ),
    (
        '2025-06-08',
        'Barang Tidak Sesuai',
        'Selesai',
        3,
        NULL,
        4
    ),
    (
        '2025-06-10',
        'Barang Rusak',
        'Diproses',
        NULL,
        3,
        2
    );

INSERT INTO
    return_detail (
        qty,
        alasan_detail,
        action,
        return_id,
        product_id
    )
VALUES (
        2,
        'Barang rusak saat pengiriman',
        'Ganti baru',
        1,
        1
    ),
    (
        3,
        'Kesalahan pengiriman ukuran',
        'Refund',
        2,
        2
    ),
    (
        5,
        'Kadaluarsa sebelum diterima',
        'Buang',
        3,
        3
    ),
    (
        1,
        'Barang tidak sesuai pesanan',
        'Ganti produk lain',
        4,
        4
    ),
    (
        4,
        'Barang rusak saat produksi',
        'Perbaiki',
        5,
        5
    );

INSERT INTO
    discount (
        nama_program,
        tipe,
        nilai,
        start_date,
        end_date,
        min_pembelian
    )
VALUES (
        'Promo Lebaran',
        'Persentase',
        15.00,
        '2025-05-01',
        '2025-05-10',
        500000
    ),
    (
        'Cashback Spesial',
        'Cashback',
        50000.00,
        '2025-05-15',
        '2025-05-20',
        250000
    ),
    (
        'Diskon Member',
        'Persentase',
        10.00,
        '2025-05-05',
        '2025-05-30',
        100000
    ),
    (
        'Promo Flash Sale',
        'Persentase',
        20.00,
        '2025-05-25',
        '2025-05-25',
        300000
    ),
    (
        'Voucher Belanja',
        'Nominal',
        100000.00,
        '2025-05-10',
        '2025-05-20',
        400000
    );

-- Select

SELECT
    customer.nama AS nama_customer,
    customer.alamat AS alamat_customer,
    customer.no_telp AS kontak_customer,
    customer.email AS email_customer,
    customer.tgl_registrasi,
    customer.poin,
    customer.level,
    users.username,
    users.nama AS nama_user,
    users.role,
    users.email,
    users.last_login,
    users.is_active
FROM
    users
    INNER JOIN transaction ON users.user_id = transaction.user_id
    INNER JOIN customer ON transaction.customer_id = customer.customer_id;

SELECT
    transaction.invoice_no,
    transaction.tanggal AS tanggal_transaksi,
    transaction.total_harga,
    transaction.diskon_global,
    transaction.pajak,
    transaction.metode_bayar,
    transaction.status AS status_transaksi,
    transaction_detail.qty,
    transaction_detail.harga_satuan,
    transaction_detail.diskon,
    transaction_detail.subtotal,
    installment.jumlah AS jumlah_cicilan,
    installment.tanggal_bayar,
    installment.metode,
    installment.status AS status_cicilan,
    `return`.tanggal AS tanggal_retur,
    `return`.jenis,
    `return`.status AS status_retur,
    return_detail.qty AS jumlah_barang_retur,
    return_detail.alasan_detail,
    return_detail.action
FROM
    transaction
    INNER JOIN transaction_detail ON transaction.transaction_id = transaction_detail.transaction_id
    INNER JOIN installment ON transaction.transaction_id = installment.transaction_id
    INNER JOIN `return` ON transaction.transaction_id = `return`.transaction_id
    INNER JOIN return_detail ON `return`.return_id = return_detail.return_id;

SELECT
    product.barcode,
    product.nama AS nama_produk,
    product.harga_beli,
    product.harga_jual,
    product.stok,
    product.min_stok,
    product.satuan,
    product.berat,
    product.foto,
    category.nama_kategori,
    category.deskripsi,
    category.icon,
    supplier.nama AS nama_supplier,
    supplier.alamat AS alamat_supplier,
    supplier.kota,
    supplier.kode_pos,
    supplier.no_telp AS kontak_supplier,
    supplier.email AS email_supplier,
    supplier.npwp,
    supplier.rekening_bank
FROM
    product
    INNER JOIN category ON product.category_id = category.category_id
    INNER JOIN supplier ON product.supplier_id = supplier.supplier_id;

SELECT
    purchase.no_faktur,
    purchase.tanggal AS tanggal_pembelian,
    purchase.total_harga AS total_pembelian,
    purchase.status AS status_pembelian,
    purchase.jatuh_tempo,
    purchase_detail.qty AS jumlah_pembelian,
    purchase_detail.harga_satuan AS harga_satuan_pembelian,
    purchase_detail.expired_date,
    purchase_detail.subtotal AS subtotal_pembelian,
    inventory.tanggal AS tanggal_inventory,
    inventory.tipe AS tipe_inventory,
    inventory.keterangan AS keterangan_inventory,
    inventory_detail.qty_sebelum,
    inventory_detail.qty_sesudah,
    inventory_detail.selisih AS selisih_stok
FROM
    purchase
    INNER JOIN purchase_detail ON purchase.purchase_id = purchase_detail.purchase_id
    INNER JOIN inventory_detail ON purchase_detail.product_id = inventory_detail.product_id
    INNER JOIN inventory ON inventory_detail.inventory_id = inventory.inventory_id;