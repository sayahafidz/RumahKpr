-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 01, 2024 at 10:48 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rumahkpr`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `no_identitas` varchar(255) NOT NULL,
  `pekerjaan` varchar(255) NOT NULL,
  `gaji` varchar(255) NOT NULL,
  `alamat` text NOT NULL,
  `jenis_pembayaran` enum('tabungan_mandiri','tabungan_lainnya') NOT NULL,
  `janji_temu` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('unpaid','paid','pending','loan','last_payment_decline') NOT NULL DEFAULT 'unpaid',
  `catatan` varchar(255) DEFAULT NULL,
  `properti_id` int(11) NOT NULL,
  `jumlah_dibayar` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `no_identitas`, `pekerjaan`, `gaji`, `alamat`, `jenis_pembayaran`, `janji_temu`, `status`, `catatan`, `properti_id`, `jumlah_dibayar`, `created_at`, `updated_at`) VALUES
(3, 3, '32161818189292929', 'IT', '85000000', 'ABC', 'tabungan_mandiri', '2024-08-19 07:00:00', 'unpaid', NULL, 1, 0, '2024-06-30 04:34:01', '2024-06-30 04:34:01'),
(4, 4, '10123456', 'PNS', '12000000', 'JL. Karya', 'tabungan_mandiri', '2024-07-01 10:16:00', 'unpaid', NULL, 1, 0, '2024-06-30 09:17:08', '2024-06-30 09:17:08');

-- --------------------------------------------------------

--
-- Table structure for table `dokumens`
--

CREATE TABLE `dokumens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tipe_dokumen` enum('ktp','kk','rekening','npwp') NOT NULL,
  `file` varchar(255) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `dokumens`
--

INSERT INTO `dokumens` (`id`, `tipe_dokumen`, `file`, `booking_id`, `created_at`, `updated_at`) VALUES
(1, 'ktp', '666844bc79077_Dapur.jpeg', 1, '2024-06-11 12:36:12', '2024-06-11 12:36:12'),
(2, 'kk', '666844bce0410_Halaman Belakang.jpeg', 1, '2024-06-11 12:36:12', '2024-06-11 12:36:12'),
(3, 'rekening', '666844bce0ca2_Halaman Depan.jpeg', 1, '2024-06-11 12:36:12', '2024-06-11 12:36:12'),
(4, 'npwp', '666844bce1415_Kamar Mandi.jpeg', 1, '2024-06-11 12:36:12', '2024-06-11 12:36:12'),
(5, 'ktp', '666844bd3737a_Dapur.jpeg', 2, '2024-06-11 12:36:13', '2024-06-11 12:36:13'),
(6, 'kk', '666844bd3c81e_Halaman Belakang.jpeg', 2, '2024-06-11 12:36:13', '2024-06-11 12:36:13'),
(7, 'rekening', '666844bd3ce9b_Halaman Depan.jpeg', 2, '2024-06-11 12:36:13', '2024-06-11 12:36:13'),
(8, 'npwp', '666844bd3d57f_Kamar Mandi.jpeg', 2, '2024-06-11 12:36:13', '2024-06-11 12:36:13'),
(9, 'ktp', '6680e039826c9_GAPURA KOMPLEK.jpg', 3, '2024-06-30 04:34:01', '2024-06-30 04:34:01'),
(10, 'kk', '6680e03995db9_HALAMAN BELAKANG.jpg', 3, '2024-06-30 04:34:01', '2024-06-30 04:34:01'),
(11, 'rekening', '6680e03998667_HALAMAN DEPAN (1).jpg', 3, '2024-06-30 04:34:01', '2024-06-30 04:34:01'),
(12, 'npwp', '6680e0399ace4_HOMEPLAN.jpg', 3, '2024-06-30 04:34:01', '2024-06-30 04:34:01'),
(13, 'ktp', '66812294d1c64_KTP.png', 4, '2024-06-30 09:17:08', '2024-06-30 09:17:08'),
(14, 'kk', '66812294e5e36_KK.jpg', 4, '2024-06-30 09:17:08', '2024-06-30 09:17:08'),
(15, 'rekening', '66812294e8bae_REKENING KORAN.jpg', 4, '2024-06-30 09:17:08', '2024-06-30 09:17:08'),
(16, 'npwp', '66812294e98da_NPWP.png', 4, '2024-06-30 09:17:08', '2024-06-30 09:17:08');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `foto_pembayarans`
--

CREATE TABLE `foto_pembayarans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tanggal_transfer` date NOT NULL,
  `foto` varchar(255) NOT NULL,
  `catatan` text DEFAULT NULL,
  `jumlah_transfer` int(11) NOT NULL,
  `pembayaran_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `foto_pembayarans`
--

INSERT INTO `foto_pembayarans` (`id`, `tanggal_transfer`, `foto`, `catatan`, `jumlah_transfer`, `pembayaran_id`, `status`, `created_at`, `updated_at`) VALUES
(1, '2024-06-30', 'nUCA5Q1fwmDQYqZgqxhvhyPvlpnKiwSUpaSBzIeY.jpg', NULL, 100000, 2, 0, '2024-06-30 04:22:04', '2024-06-30 04:22:04');

-- --------------------------------------------------------

--
-- Table structure for table `foto_propertis`
--

CREATE TABLE `foto_propertis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `foto` varchar(255) NOT NULL,
  `properti_id` int(11) NOT NULL,
  `is_banner` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `foto_propertis`
--

INSERT INTO `foto_propertis` (`id`, `foto`, `properti_id`, `is_banner`, `created_at`, `updated_at`) VALUES
(1, 'emCT0vGaJN18oAvTKiU4D5UEQgVzil7UEj55aa5J.jpg', 1, 1, '2024-06-15 15:25:49', '2024-06-15 15:35:45'),
(2, 'PSdwDunbAzMZbavVzVrGQGuQMoFB0PrHQaAlYlix.jpg', 1, 0, '2024-06-15 15:25:49', '2024-06-15 15:35:45'),
(3, 'gpAqjeCrtdWTmrsRqzMp4U6ULTDNG0UrNf2QxEOg.jpg', 1, 0, '2024-06-15 15:25:49', '2024-06-15 15:35:45'),
(4, 'WJAOFnmdjePxcqA9bzhlNLIhN7mppLM64gIi3WjZ.jpg', 1, 0, '2024-06-15 15:25:49', '2024-06-15 15:35:45'),
(5, 'rRX0vu6sukvO3NkglI9Tc3ZurMzWvdkjQIv8tIvj.jpg', 1, 0, '2024-06-15 15:25:49', '2024-06-15 15:35:45'),
(6, 'HVqa9vAUkQFP2TACIwzWeqUzQMG9DIXlwJiza3SV.jpg', 1, 0, '2024-06-15 15:25:49', '2024-06-15 15:35:45'),
(7, 'DKsqt2LygVGLBuVJHpJo0duSlahouttrJ3G9jcSK.jpg', 2, 1, '2024-06-15 15:33:56', '2024-06-15 15:34:01'),
(9, '2vR8wMGE8A293DX5ZYYWwJv97rQEFqNSJCPaJ4qX.jpg', 4, 0, '2024-06-30 04:39:17', '2024-06-30 04:39:17'),
(10, 'Cf5rk6S0RG2KXCzFoL60bki1mCEFKw0GqRye5zn3.jpg', 4, 0, '2024-06-30 04:39:17', '2024-06-30 04:39:17');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_propertis`
--

CREATE TABLE `kategori_propertis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `alamat` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kategori_propertis`
--

INSERT INTO `kategori_propertis` (`id`, `nama`, `deskripsi`, `alamat`, `created_at`, `updated_at`) VALUES
(1, 'New Taman Tenera Indah', 'Perumahan New Taman Tenera Indah hadir untuk memberikan desain rumah yang\nelegan dengan harga terjangkau dan berada di lokasi yang strategis, memiliki lingkungan yang\nmasih asri dan alami memberikan kenyamanan yang tak tertandingi bagi setiap keluarga tercinta.', 'Jl. Karya Wisata Ujung, Kec. Namorambe, Kabupaten Deli Serdang, Sumatera Utara 20145', '2024-06-11 12:34:05', '2024-06-11 12:34:05'),
(2, 'TAMAN ELYSIUM', 'Tipe 72', 'Jalan Raya Sudirman', '2024-06-30 04:38:36', '2024-06-30 09:33:36');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2024_06_06_113058_create_bookings_table', 1),
(6, '2024_06_06_152632_create_propertis_table', 1),
(7, '2024_06_06_152801_create_kategori_propertis_table', 1),
(8, '2024_06_06_163326_create_foto_propertis_table', 1),
(9, '2024_06_07_170826_create_foto_pembayarans_table', 1),
(10, '2024_06_09_045422_create_dokumens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `judul` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `kategori_id` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`id`, `judul`, `deskripsi`, `kategori_id`, `harga`, `created_at`, `updated_at`) VALUES
(1, 'Type 54 (Loft)', '<div>Ukuran 7,5 x 20 M</div><div>Sisa Tanah 7,5 x 7 M</div><div>2 Kamar Tidur</div><div>1 Kamar Mandi</div><div>2 Carport</div>', 1, 571000000, '2024-06-11 12:34:05', '2024-06-11 12:34:05'),
(2, 'Type 45 (Nara)', '<div>Ukuran 6 x 15 M</div><div>Sisa Tanah 6 x 4 M</div><div>2 Kamar Tidur</div><div>1 Kamar Mandi</div><div>1 Carport</div>', 1, 402000000, '2024-06-11 12:34:05', '2024-06-11 12:34:05'),
(4, 'RUMAH CONTOH', '<div>abc<br>abc<br>abc</div>', 2, 1200000000, '2024-06-30 04:39:17', '2024-06-30 04:39:17');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `role` enum('admin','user') NOT NULL DEFAULT 'user',
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `phone`, `role`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@gmail.com', '2024-06-11 12:34:05', '1234567890', 'admin', '$2y$10$3irCFFNAbY8Kf1Nj/p5U1OfUzbvrDTm3YeMf59uC.Fql3xEVl1U6S', 'UMa4H2znesvWEU9oSpuCTbUaix6qwhq3kApQFnm2vBEhpxGqtjeNMnAdSxFU', '2024-06-11 12:34:05', '2024-06-11 12:34:05'),
(2, 'User', 'user@gmail.com', '2024-06-11 12:34:05', '1234567890', 'user', '$2y$10$FoMbkt0sDDzYKSfi1bmTJezWpQx7ZkEoX/J8iEaptfw5Z0.xqjaam', '0S7x7PxxObDaGAOjSDSuKGgJAipyhTAnQ7cbSjYMbrMkj46TN7ZcqqQW2Q7a', '2024-06-11 12:34:05', '2024-06-11 12:34:05'),
(3, 'Akmal', 'akmal@gmail.com', NULL, '0877', 'user', '$2y$10$VYZkaPHpvSxMBuF9oeoP1ONpRsZW3SQ/cw59BEjkhTQbzCl1FoDGS', NULL, '2024-06-30 04:16:35', '2024-06-30 04:16:35'),
(4, 'shasha', 'shasha@gmail.com', NULL, '12345670', 'user', '$2y$10$SigMHASY.fcuS5m0OStD3eqNE54GR8B/Vl9lCX//BRVUVOir0vMue', NULL, '2024-06-30 08:53:24', '2024-06-30 08:53:24'),
(5, 'darma', 'darma@gmail.com', NULL, '12344678', 'user', '$2y$10$Y/m1yY6W0e2Pm.TKL/2L1e5J3BKC.lWcFeg7nbrDGStTVbNoHOr4.', NULL, '2024-06-30 10:19:04', '2024-06-30 10:19:04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dokumens`
--
ALTER TABLE `dokumens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `foto_pembayarans`
--
ALTER TABLE `foto_pembayarans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `foto_propertis`
--
ALTER TABLE `foto_propertis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategori_propertis`
--
ALTER TABLE `kategori_propertis`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `dokumens`
--
ALTER TABLE `dokumens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `foto_pembayarans`
--
ALTER TABLE `foto_pembayarans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `foto_propertis`
--
ALTER TABLE `foto_propertis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `kategori_propertis`
--
ALTER TABLE `kategori_propertis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
