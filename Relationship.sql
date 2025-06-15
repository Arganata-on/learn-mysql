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
VALUES ('d10', 'Penelitian', 4000000),
       ('d11', 'Pemasaran', 3000000),
       ('d12', 'SDM', 3500000),
       ('d13', 'Keuangan', 5000000);

INSERT INTO karyawan (id_kar, nama_kar, jk, id_dep)
VALUES ('k01', 'Agus', 'L', 'd10'),
       ('k02', 'Budi', 'L', 'd12'),
       ('k03', 'Citra', 'P', 'd12'),
       ('k04', 'Dani', 'L', NULL);

SELECT *
FROM karyawan
         INNER JOIN departemen
                    ON karyawan.id_dep = departemen.id_dep;

SELECT k.nama_kar, d.nama_dep
FROM departemen d
         INNER JOIN karyawan k ON k.id_dep = d.id_dep;

SELECT *
FROM departemen d
         INNER JOIN karyawan k ON d.id_dep = k.id_dep;

SELECT *
FROM karyawan k
         LEFT JOIN departemen d ON k.id_dep = d.id_dep;

SELECT *
FROM karyawan k
         LEFT OUTER JOIN departemen d
                         ON k.id_dep = d.id_dep;

SELECT *
FROM karyawan k
         RIGHT OUTER JOIN departemen d
                          ON k.id_dep = d.id_dep;

SELECT *
FROM karyawan k
         LEFT OUTER JOIN departemen d
                         ON k.id_dep = d.id_dep
UNION
SELECT *
FROM karyawan k
         RIGHT OUTER JOIN departemen d
                          ON k.id_dep = d.id_dep;

SELECT *
FROM karyawan
         CROSS JOIN departemen;
SELECT *
FROM karyawan,
     departemen;

select *
from karyawan k
         inner join departemen d on k.id_dep = d.id_dep
where d.gaji < 5000000;

select k.nama_kar, d.nama_dep
from karyawan k
         inner join departemen d on k.id_dep = d.id_dep
where jk = 'P';

select *
from karyawan k
         inner join departemen d on k.id_dep = d.id_dep
where nama_dep = 'Penelitian';