CREATE DATABASE latihandb;

USE latihandb;

CREATE TABLE mahasiswa (
    nim INT(12) PRIMARY KEY AUTO_INCREMENT,
    nama_mahasiswa VARCHAR(50),
    alamat_mahasiswa VARCHAR(80),
    gender CHAR(1)
);

SELECT * FROM mahasiswa;

INSERT INTO
    mahasiswa (
        nama_mahasiswa,
        alamat_mahasiswa,
        gender
    )
VALUES (
        'Arganata',
        'Jalan 01',
        'Laki-laki'
    ),
    (
        'Faldi',
        'Jalan 02',
        'Laki-laki'
    ),
    (
        'Eko',
        'Jalan 03',
        'Laki-laki'
    ),
    (
        'Abbat',
        'Jalan 04',
        'Laki-laki'
    ),
    (
        'Firman',
        'Jalan 05',
        'Laki-laki'
    );

UPDATE mahasiswa SET nama_mahasiswa = 'Arga' WHERE nim = 1;

UPDATE mahasiswa SET nama_mahasiswa = 'Abbad' WHERE nim = 4;

DELETE FROM mahasiswa WHERE nama_mahasiswa = 'Arga';