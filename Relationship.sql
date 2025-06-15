CREATE DATABASE relationship;

USE relationship;

CREATE TABLE departemen
(
    id_dep   CHAR(3) PRIMARY KEY,
    nama_dep VARCHAR(30),
    gaji     INT
);

CREATE TABLE karyawan
(
    id_kar   CHAR(3),
    nama_kar VARCHAR(30),
    jk       CHAR(1),
    id_dep   CHAR(3),
    Foreign Key (id_dep) REFERENCES departemen (id_dep)
);

INSERT INTO departemen (id_dep, nama_dep, gaji)
VALUES ('d10', 'Penelitian', 4000000);

INSERT INTO karyawan (id_kar, nama_kar, jk, id_dep)
VALUES ('k01', 'Agus', 'L', 'd10');

SELECT k.id_kar, d.id_dep, k.nama_kar, k.jk, d.nama_dep, d.gaji
FROM departemen d
         INNER JOIN karyawan k ON d.id_dep = k.id_dep;

SELECT *
FROM departemen d
         INNER JOIN karyawan k ON d.id_dep = k.id_dep;

SELECT *
FROM karyawan k
         LEFT JOIN departemen d ON k.id_dep = d.id_dep;