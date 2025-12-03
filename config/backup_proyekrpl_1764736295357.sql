/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: admins
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama_lengkap` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: antrian
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `antrian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `nama_pasien` varchar(100) DEFAULT NULL,
  `nama_dokter` varchar(100) DEFAULT NULL,
  `nomor_antrian` int(11) DEFAULT NULL,
  `status` enum('menunggu', 'dilayani', 'selesai') DEFAULT 'menunggu',
  `tanggal` date DEFAULT curdate(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `antrian_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 33 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: jadwal_dokter
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `jadwal_dokter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_dokter` varchar(100) NOT NULL,
  `poli` varchar(50) NOT NULL,
  `hari` varchar(20) NOT NULL,
  `jam` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 41 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: jam_operasional
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `jam_operasional` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cabang` enum('Indralaya', 'Palembang') NOT NULL,
  `hari` varchar(20) NOT NULL,
  `jam` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 15 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: users
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `no_hp` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `ROLE` enum('mahasiswa', 'dosen', 'umum') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `alamat` text DEFAULT NULL,
  `jenis_kelamin` enum('Laki-laki', 'Perempuan') DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE = InnoDB AUTO_INCREMENT = 30 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: admins
# ------------------------------------------------------------

INSERT INTO
  `admins` (`id`, `username`, `password`, `nama_lengkap`)
VALUES
  (
    1,
    'admin',
    '$2a$12$SOHRokQPwJbNw9RtsH/LkeELx8NazaPLaK6U2KjvzmUTrGS2RFo7.',
    'Super Admin'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: antrian
# ------------------------------------------------------------

INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    5,
    14,
    'bleg',
    'Dr. Umum',
    1,
    'selesai',
    '2025-11-26',
    '2025-11-27 01:44:53'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    6,
    14,
    'bleg',
    'Dr. Umum',
    2,
    'selesai',
    '2025-11-26',
    '2025-11-27 01:45:08'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    7,
    14,
    'bleg',
    'Dr. Umum',
    3,
    'selesai',
    '2025-11-26',
    '2025-11-27 01:45:19'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    8,
    14,
    'bleg',
    'Dr. Umum',
    4,
    'selesai',
    '2025-11-26',
    '2025-11-27 01:50:15'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    9,
    14,
    'bleg',
    'Dr. Umum',
    1,
    'selesai',
    '2025-11-27',
    '2025-11-27 10:12:51'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    10,
    20,
    'Kenza',
    'Dr. Umum',
    2,
    'selesai',
    '2025-11-27',
    '2025-11-27 10:18:50'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    11,
    21,
    'Kenzo',
    'Dr. Umum',
    3,
    'selesai',
    '2025-11-27',
    '2025-11-27 10:28:10'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    13,
    23,
    'zazkia',
    'Dr. Umum',
    4,
    'selesai',
    '2025-11-27',
    '2025-11-27 13:00:33'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    14,
    28,
    'nabila',
    'Dr. Umum',
    1,
    'selesai',
    '2025-12-01',
    '2025-12-01 12:28:48'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    15,
    27,
    'novel',
    'Dr. Umum',
    1,
    'selesai',
    '2025-12-02',
    '2025-12-02 12:07:14'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    16,
    14,
    'bleg',
    'Dr. Umum',
    2,
    'selesai',
    '2025-12-02',
    '2025-12-02 12:13:03'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    17,
    14,
    'bleg',
    'Dr. Umum',
    3,
    'selesai',
    '2025-12-02',
    '2025-12-02 12:21:48'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    18,
    14,
    'bleg',
    'Dr. Umum',
    4,
    'selesai',
    '2025-12-02',
    '2025-12-02 12:22:17'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    19,
    14,
    'bleg',
    'Dr. Umum',
    5,
    'selesai',
    '2025-12-02',
    '2025-12-02 12:22:37'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    20,
    20,
    'Kenza',
    'Dr. Umum',
    6,
    'selesai',
    '2025-12-02',
    '2025-12-02 12:23:33'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    21,
    14,
    'blegd',
    'Dr. Umum',
    7,
    'selesai',
    '2025-12-02',
    '2025-12-02 12:56:24'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    22,
    14,
    'blegd',
    'Dr. Umum',
    8,
    'selesai',
    '2025-12-02',
    '2025-12-02 12:57:28'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    23,
    14,
    'blegd',
    'Dr. Umum',
    9,
    'selesai',
    '2025-12-02',
    '2025-12-02 13:02:35'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    24,
    14,
    'blegd',
    'Dr. Anak',
    1,
    'selesai',
    '2025-12-02',
    '2025-12-02 13:03:20'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    25,
    14,
    'blegd',
    'Dr. Anak',
    2,
    'selesai',
    '2025-12-02',
    '2025-12-02 15:23:46'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    28,
    14,
    'blegd',
    'Dr. Gigi',
    1,
    'selesai',
    '2025-12-02',
    '2025-12-02 17:48:09'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    29,
    29,
    'Nabil',
    'Dr. Gigi',
    2,
    'selesai',
    '2025-12-02',
    '2025-12-02 19:05:52'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    30,
    29,
    'Nabil Riyal',
    'Dr. Umum',
    10,
    'selesai',
    '2025-12-02',
    '2025-12-02 19:21:21'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    31,
    29,
    'Nabil Riyal',
    'Dr. Umum',
    11,
    'selesai',
    '2025-12-02',
    '2025-12-02 19:23:57'
  );
INSERT INTO
  `antrian` (
    `id`,
    `user_id`,
    `nama_pasien`,
    `nama_dokter`,
    `nomor_antrian`,
    `status`,
    `tanggal`,
    `created_at`
  )
VALUES
  (
    32,
    20,
    'Kenza',
    'Dr. Gigi',
    3,
    'selesai',
    '2025-12-02',
    '2025-12-02 19:24:37'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: jadwal_dokter
# ------------------------------------------------------------

INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    1,
    'Dr. Andi Pratama',
    'Umum',
    'Senin',
    '08.00-18.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    2,
    'Dr. Andi Pratama',
    'Umum',
    'Selasa',
    '13.00-21.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    3,
    'Dr. Andi Pratama',
    'Umum',
    'Rabu',
    '13.00-21.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    4,
    'Dr. Andi Pratama',
    'Umum',
    'Kamis',
    '08.00-11.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    5,
    'Dr. Andi Pratama',
    'Umum',
    'Jumat',
    '08.00-10.30',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    6,
    'Dr. Siti Aminah',
    'Umum',
    'Senin',
    '13.00-15.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    7,
    'Dr. Siti Aminah',
    'Umum',
    'Selasa',
    '13.00-15.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    8,
    'Dr. Siti Aminah',
    'Umum',
    'Rabu',
    '13.00-15.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    9,
    'Dr. Siti Aminah',
    'Umum',
    'Kamis',
    '13.00-15.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    10,
    'Dr. Siti Aminah',
    'Umum',
    'Jumat',
    '13.00-15.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    11,
    'Dr. Rian Hidayat',
    'Umum',
    'Senin',
    '08.00-11.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    12,
    'Dr. Rian Hidayat',
    'Umum',
    'Selasa',
    '08.00-11.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    13,
    'Dr. Rian Hidayat',
    'Umum',
    'Rabu',
    '13.00-15.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    14,
    'Dr. Rian Hidayat',
    'Umum',
    'Kamis',
    '13.00-15.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    15,
    'Dr. Rian Hidayat',
    'Umum',
    'Jumat',
    '13.00-15.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    16,
    'Dr. Budi Santoso',
    'THT',
    'Senin',
    '09.00-12.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    17,
    'Dr. Budi Santoso',
    'THT',
    'Selasa',
    '09.00-12.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    18,
    'Dr. Budi Santoso',
    'THT',
    'Rabu',
    '14.00-16.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    19,
    'Dr. Budi Santoso',
    'THT',
    'Kamis',
    '09.00-12.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    20,
    'Dr. Budi Santoso',
    'THT',
    'Jumat',
    '09.00-11.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    21,
    'Dr. Hendra Wijaya',
    'THT',
    'Senin',
    '14.00-16.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    22,
    'Dr. Hendra Wijaya',
    'THT',
    'Selasa',
    '14.00-16.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    23,
    'Dr. Hendra Wijaya',
    'THT',
    'Rabu',
    '09.00-12.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    24,
    'Dr. Hendra Wijaya',
    'THT',
    'Kamis',
    '14.00-16.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    25,
    'Dr. Hendra Wijaya',
    'THT',
    'Jumat',
    '14.00-15.30',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    26,
    'Dr. Maya Safitri',
    'Gigi',
    'Senin',
    '08.00-11.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    27,
    'Dr. Maya Safitri',
    'Gigi',
    'Selasa',
    '13.00-15.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    28,
    'Dr. Maya Safitri',
    'Gigi',
    'Rabu',
    '08.00-11.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    29,
    'Dr. Maya Safitri',
    'Gigi',
    'Kamis',
    '13.00-15.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    30,
    'Dr. Maya Safitri',
    'Gigi',
    'Jumat',
    '08.00-10.30',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    31,
    'Dr. Aditya Nugraha',
    'Gigi',
    'Senin',
    '13.00-15.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    32,
    'Dr. Aditya Nugraha',
    'Gigi',
    'Selasa',
    '08.00-11.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    33,
    'Dr. Aditya Nugraha',
    'Gigi',
    'Rabu',
    '13.00-15.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    34,
    'Dr. Aditya Nugraha',
    'Gigi',
    'Kamis',
    '08.00-11.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    35,
    'Dr. Aditya Nugraha',
    'Gigi',
    'Jumat',
    '13.00-15.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    36,
    'Dr. Bella Puspita',
    'Gigi',
    'Senin',
    '08.00-11.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    37,
    'Dr. Bella Puspita',
    'Gigi',
    'Selasa',
    '08.00-11.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    38,
    'Dr. Bella Puspita',
    'Gigi',
    'Rabu',
    '08.00-11.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    39,
    'Dr. Bella Puspita',
    'Gigi',
    'Kamis',
    '08.00-11.00',
    '2025-12-02 17:23:56'
  );
INSERT INTO
  `jadwal_dokter` (
    `id`,
    `nama_dokter`,
    `poli`,
    `hari`,
    `jam`,
    `created_at`
  )
VALUES
  (
    40,
    'Dr. Bella Puspita',
    'Gigi',
    'Jumat',
    '08.00-10.30',
    '2025-12-02 17:23:56'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: jam_operasional
# ------------------------------------------------------------

INSERT INTO
  `jam_operasional` (`id`, `cabang`, `hari`, `jam`)
VALUES
  (1, 'Indralaya', 'Senin', '08.00 - 15.30');
INSERT INTO
  `jam_operasional` (`id`, `cabang`, `hari`, `jam`)
VALUES
  (2, 'Indralaya', 'Selasa', '08.00 - 17.30');
INSERT INTO
  `jam_operasional` (`id`, `cabang`, `hari`, `jam`)
VALUES
  (3, 'Indralaya', 'Rabu', '08.00 - 15.30');
INSERT INTO
  `jam_operasional` (`id`, `cabang`, `hari`, `jam`)
VALUES
  (4, 'Indralaya', 'Kamis', '08.00 - 15.30');
INSERT INTO
  `jam_operasional` (`id`, `cabang`, `hari`, `jam`)
VALUES
  (5, 'Indralaya', 'Jumat', '08.00 - 16.00');
INSERT INTO
  `jam_operasional` (`id`, `cabang`, `hari`, `jam`)
VALUES
  (6, 'Indralaya', 'Sabtu', 'Tutup');
INSERT INTO
  `jam_operasional` (`id`, `cabang`, `hari`, `jam`)
VALUES
  (7, 'Indralaya', 'Minggu', 'Tutup');
INSERT INTO
  `jam_operasional` (`id`, `cabang`, `hari`, `jam`)
VALUES
  (8, 'Palembang', 'Senin', '08.00 - 15.30');
INSERT INTO
  `jam_operasional` (`id`, `cabang`, `hari`, `jam`)
VALUES
  (9, 'Palembang', 'Selasa', '08.00 - 15.30');
INSERT INTO
  `jam_operasional` (`id`, `cabang`, `hari`, `jam`)
VALUES
  (10, 'Palembang', 'Rabu', '08.00 - 15.30');
INSERT INTO
  `jam_operasional` (`id`, `cabang`, `hari`, `jam`)
VALUES
  (11, 'Palembang', 'Kamis', '08.00 - 15.30');
INSERT INTO
  `jam_operasional` (`id`, `cabang`, `hari`, `jam`)
VALUES
  (12, 'Palembang', 'Jumat', '08.00 - 15.30');
INSERT INTO
  `jam_operasional` (`id`, `cabang`, `hari`, `jam`)
VALUES
  (13, 'Palembang', 'Sabtu', 'Tutup');
INSERT INTO
  `jam_operasional` (`id`, `cabang`, `hari`, `jam`)
VALUES
  (14, 'Palembang', 'Minggu', 'Tutup');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: users
# ------------------------------------------------------------

INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    3,
    'blehzBlog',
    '12301284217',
    'jdksaj@gmail.com',
    '$2b$10$DBCaf9UfEt6qQ1IEBiedB.dGsdcTUXz7zffeF24d3chneOrFqXTM6',
    'mahasiswa',
    '2025-11-18 18:47:41',
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    4,
    'BLACKJEW',
    '696966876',
    'jewasscrack@gmail.com',
    '$2b$10$VcrOpe1enSWJM6L6My88y.XblXy8su0N3Owez2Sd.iZszQ3gre8Ku',
    'umum',
    '2025-11-18 18:51:44',
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    8,
    'BLACKJEW',
    '12301284217',
    'jewasscrackasd@gmail.com',
    '$2b$10$8YPWfDZ81.yHsEY.HqQa1e2jgFfeihWxg5B6H.ZpwyEIhQNtudGqW',
    'mahasiswa',
    '2025-11-18 19:10:37',
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    9,
    'okegas',
    '123451223',
    'jewasscrack69@gmail.com',
    '$2b$10$N68uzS5FS.rZ3YZ6WNPe0ONeswr.gqNPDmAkhMQQI4UMGy8ryUObe',
    'mahasiswa',
    '2025-11-18 19:12:08',
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    10,
    'akubackend',
    '09123',
    '1@gmail.com',
    '$2b$10$H4I9traEfQe55XGXoSkZsO.GNlgOOZqx9uXvqn46MXR8QoaRaaEPC',
    'mahasiswa',
    '2025-11-18 19:19:19',
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    11,
    'blacknigga',
    '12313',
    'adidas@gmail.com',
    '$2b$10$Qx8xpK9GeJEpVGe.C981..Z.gxsDoZEXOMIFzCGkE5SwMxqwMGUV.',
    'mahasiswa',
    '2025-11-18 19:41:01',
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    12,
    'Ahmadika',
    '08123456789',
    'dika@gmail.com',
    '$2b$10$FnYfpLIBhi9jOX6kUQbcc.ffKTJ6JMvIBpU.ZGTrFDUMoWvUE5FJ.',
    'mahasiswa',
    '2025-11-19 07:59:47',
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    13,
    'Nate Higgers',
    '08123456789',
    'jujujujujujujuju@gmail.com',
    '$2b$10$5pYfw38CMXu4YMWbu.IYnO8kDYSCOA.J/3wo8wVWKOPqwPSgY8XmC',
    'mahasiswa',
    '2025-11-19 08:05:59',
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    14,
    'blegd',
    '120943',
    'jews@gmail.com',
    '$2b$10$m2F2HaQtfXHfPVDpQzC8yuZNEx/PHFxyPJydeIpPkSMIh5on1Jr5G',
    'mahasiswa',
    '2025-11-26 20:52:31',
    'dikapelrsayams1assa',
    '',
    '2021-05-31'
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    15,
    'aasw',
    '123',
    '12@gmail.com',
    '$2b$10$Rav8lYOYSbPqRKpfSWzcKO.F.ZG9dpDs5y0fkmP5HGkLUMn1KWNf6',
    'mahasiswa',
    '2025-11-26 21:53:19',
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    18,
    'tes12',
    '1234',
    'res@gmail.com',
    '$2b$10$KryHk2dAav0RWBBSDMI1VuFV65rCvCWSE/Bft2KT2/MnhvGEfisM6',
    'mahasiswa',
    '2025-11-26 22:02:29',
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    20,
    'Kenza',
    '081212341234',
    'akukenzanyata@gmail.com',
    '$2b$10$4IwtNoUIFOhMUoFvx4XhquD/.a7EaksgjFvPF.WEnSk.SEKCpzduC',
    'umum',
    '2025-11-27 10:17:44',
    '',
    '',
    '0000-00-00'
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    21,
    'Kenzo',
    '098123490567',
    'akube@gmail.com',
    '$2b$10$ZadcnmMEcTl5CbmYbt54QuHOLEnC8hpAT2wI1RGy8I1SbHvR9HORa',
    'umum',
    '2025-11-27 10:27:24',
    'sako ',
    'Laki-laki',
    '0000-00-00'
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    23,
    'mami',
    '098637623833',
    'mami@gmail.com',
    '$2b$10$MjeosPW9sLNPu2hliP3rZOEw/smDlUFNdCvT1txn9kUng1W7QrT3m',
    'mahasiswa',
    '2025-11-27 12:50:03',
    'palembang ',
    'Perempuan',
    '2009-07-14'
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    24,
    'kia',
    '082181965987',
    'kia@gmail.com',
    '$2b$10$oxXg/KWp9tie8xgUux7N5OmAPwYKGemzzUtFvNGOSDpeKrzQBcqmC',
    'dosen',
    '2025-11-27 12:52:29',
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    26,
    'nana',
    '082181965654',
    'nana@gmail.com',
    '$2b$10$9JoF4xciWlog0DzNBfdSmuoX1z01Nex055RkuIoU6LZfpxg7gzobq',
    'umum',
    '2025-11-27 12:53:36',
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    27,
    'novel',
    '08363281739',
    'novel@gmail.com',
    '$2b$10$2Kj.Px4BGUCC.MCq1DX4JusPF.6krMAjtQiXo2BIDuRTaEDiQYoJi',
    'dosen',
    '2025-11-27 13:59:43',
    NULL,
    NULL,
    NULL
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    28,
    'nabila',
    '123',
    '123@gmail.com',
    '$2b$10$ODdBxBggMVgplxApWNvbO.6lnm4zwtKW94EOfvfywhmUquRcy0azm',
    'mahasiswa',
    '2025-12-01 12:25:39',
    'palembang',
    'Perempuan',
    '2000-01-01'
  );
INSERT INTO
  `users` (
    `id`,
    `nama`,
    `no_hp`,
    `email`,
    `password`,
    `ROLE`,
    `created_at`,
    `alamat`,
    `jenis_kelamin`,
    `tanggal_lahir`
  )
VALUES
  (
    29,
    'Nabil Riyal',
    '12345612',
    'nabilriyal@gmail.com',
    '$2b$10$ewrCXhLj3OeHJ1P/gyP1m.IO0WvOKLa5riNzOMih3fBRNuQ2PJf4S',
    'mahasiswa',
    '2025-12-02 19:05:01',
    '',
    'Perempuan',
    '0000-00-00'
  );

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
