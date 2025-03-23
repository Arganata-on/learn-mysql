CREATE DATABASE perusahaan;

use perusahaan;

CREATE TABLE karyawan (
    id INT,
    nama VARCHAR(255),
    jabatan VARCHAR(255),
    tahun_masuk YEAR
);

INSERT INTO
    karyawan
VALUES (
        1,
        "Arga Pratama",
        "Manager",
        2018
    ),
    (
        2,
        "Dwi Santoso",
        "Developer",
        2020
    ),
    (
        3,
        "Budi Wijaya",
        "Designer",
        2019
    ),
    (4, "Siti Rahmah", "HR", 2021);

SELECT * FROM karyawan;

SELECT * FROM karyawan
WHERE jabatan = "Developer";

UPDATE karyawan
SET jabatan = "Senior Designer"
WHERE id = 3;

DELETE FROM karyawan
WHERE tahun_masuk < 2020;

SELECT * FROM karyawan;