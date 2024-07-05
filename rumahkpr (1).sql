-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Waktu pembuatan: 05 Jul 2024 pada 19.25
-- Versi server: 5.7.39
-- Versi PHP: 7.4.33

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
-- Struktur dari tabel `bookings`
--

CREATE TABLE `bookings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `no_identitas` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pekerjaan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gaji` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_pembayaran` enum('tabungan_mandiri','tabungan_lainnya') COLLATE utf8mb4_unicode_ci NOT NULL,
  `janji_temu` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('unpaid','paid','pending','loan','last_payment_decline') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid',
  `catatan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `properti_id` int(11) NOT NULL,
  `jumlah_dibayar` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `jangka_waktu` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bunga` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `no_identitas`, `pekerjaan`, `gaji`, `alamat`, `jenis_pembayaran`, `janji_temu`, `status`, `catatan`, `properti_id`, `jumlah_dibayar`, `created_at`, `updated_at`, `jangka_waktu`, `bunga`) VALUES
(1, 6, 'Fuga Numquam minus', 'Aliquip quo vel aliq', 'Architecto aperiam e', 'Modi tempora ut qui', 'tabungan_mandiri', '2024-07-05 19:24:20', 'last_payment_decline', NULL, 6, 31466668, '2024-07-05 16:04:58', '2024-07-05 19:24:20', '1', '8.88');

-- --------------------------------------------------------

--
-- Struktur dari tabel `dokumens`
--

CREATE TABLE `dokumens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tipe_dokumen` enum('ktp','kk','rekening','npwp') COLLATE utf8mb4_unicode_ci NOT NULL,
  `file` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `dokumens`
--

INSERT INTO `dokumens` (`id`, `tipe_dokumen`, `file`, `booking_id`, `created_at`, `updated_at`) VALUES
(1, 'ktp', '668819aa17150_logo kecambah.png', 1, '2024-07-05 16:04:58', '2024-07-05 16:04:58'),
(2, 'kk', '668819aa1cce8_logo kecambah.png', 1, '2024-07-05 16:04:58', '2024-07-05 16:04:58'),
(3, 'rekening', '668819aa1d3d0_logo kecambah.png', 1, '2024-07-05 16:04:58', '2024-07-05 16:04:58'),
(4, 'npwp', '668819aa1db26_logo kecambah.png', 1, '2024-07-05 16:04:58', '2024-07-05 16:04:58'),
(5, 'ktp', '66882cdf79d57_RUMAH2.JPG', 2, '2024-07-05 17:26:55', '2024-07-05 17:26:55'),
(6, 'kk', '66882cdf81447_RUMAH2.JPG', 2, '2024-07-05 17:26:55', '2024-07-05 17:26:55'),
(7, 'rekening', '66882cdf81b33_RUMAH2.JPG', 2, '2024-07-05 17:26:55', '2024-07-05 17:26:55'),
(8, 'npwp', '66882cdf821c9_RUMAH2.JPG', 2, '2024-07-05 17:26:55', '2024-07-05 17:26:55');

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `foto_pembayarans`
--

CREATE TABLE `foto_pembayarans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tanggal_transfer` date NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `catatan` text COLLATE utf8mb4_unicode_ci,
  `jumlah_transfer` int(11) NOT NULL,
  `pembayaran_id` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `foto_pembayarans`
--

INSERT INTO `foto_pembayarans` (`id`, `tanggal_transfer`, `foto`, `catatan`, `jumlah_transfer`, `pembayaran_id`, `status`, `created_at`, `updated_at`) VALUES
(1, '2024-07-06', '1720200970.jpg', 'oke diterima', 7866667, 1, 1, '2024-07-05 17:36:10', '2024-07-05 17:36:28'),
(2, '2024-07-06', '1720201574.jpg', 'oke bisa', 7866667, 1, 0, '2024-07-05 17:46:14', '2024-07-05 18:12:11'),
(3, '2024-07-06', '1720203235.png', 'oke keren', 7866667, 1, 1, '2024-07-05 18:13:55', '2024-07-05 19:01:45'),
(4, '2024-07-06', '1720206255.png', 'mantap mantap', 7866667, 1, 1, '2024-07-05 19:04:15', '2024-07-05 19:04:38'),
(5, '2024-07-20', '1720206310.png', NULL, 45366667, 1, 0, '2024-07-05 19:05:10', '2024-07-05 19:05:10'),
(6, '2024-07-20', '1720206321.png', NULL, 45366667, 1, 0, '2024-07-05 19:05:21', '2024-07-05 19:05:21'),
(7, '2024-07-04', '1720206346.png', NULL, 45366667, 1, 0, '2024-07-05 19:05:46', '2024-07-05 19:05:46'),
(8, '2024-07-06', '1720206382.jpg', NULL, 45366667, 1, 0, '2024-07-05 19:06:22', '2024-07-05 19:06:22'),
(9, '2024-07-19', '1720206577.jpg', NULL, 45366667, 1, 0, '2024-07-05 19:09:37', '2024-07-05 19:09:37'),
(10, '2024-07-18', '1720206603.png', NULL, 45366667, 1, 0, '2024-07-05 19:10:03', '2024-07-05 19:10:03'),
(11, '2024-07-07', '1720206615.jpg', NULL, 45366667, 1, 0, '2024-07-05 19:10:15', '2024-07-05 19:10:15'),
(12, '2024-07-07', '1720206626.jpg', 'mantap', 45366667, 1, 1, '2024-07-05 19:10:26', '2024-07-05 19:24:20'),
(13, '2024-07-07', '1720206642.jpg', NULL, 45366667, 1, 0, '2024-07-05 19:10:42', '2024-07-05 19:10:42'),
(14, '2024-07-19', '1720206707.png', NULL, 45366667, 1, 0, '2024-07-05 19:11:47', '2024-07-05 19:11:47'),
(15, '2024-07-07', '1720207212.jpg', NULL, 45366667, 1, 0, '2024-07-05 19:20:12', '2024-07-05 19:20:12');

-- --------------------------------------------------------

--
-- Struktur dari tabel `foto_propertis`
--

CREATE TABLE `foto_propertis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `properti_id` int(11) NOT NULL,
  `is_banner` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `foto_propertis`
--

INSERT INTO `foto_propertis` (`id`, `foto`, `properti_id`, `is_banner`, `created_at`, `updated_at`) VALUES
(1, 'DQH2lUgAZpzbGF2lJJnL1xsocw2m4F18mGdu6eTM.webp', 6, 0, '2024-07-05 15:53:46', '2024-07-05 15:53:46'),
(2, 'XY33KwTVLucXaUsi9erUsllPxmYunN30v9yHL4VD.jpg', 6, 0, '2024-07-05 15:53:46', '2024-07-05 15:53:46');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kategori_propertis`
--

CREATE TABLE `kategori_propertis` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `kategori_propertis`
--

INSERT INTO `kategori_propertis` (`id`, `nama`, `deskripsi`, `alamat`, `created_at`, `updated_at`) VALUES
(2, 'RUMAH GEDE', 'RUMAH GEDE BANGET KAYAK DI FILM', 'PERBAUNGAN', '2024-07-05 15:52:08', '2024-07-05 15:52:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
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
(10, '2024_06_09_045422_create_dokumens_table', 1),
(11, '2024_07_05_233944_add_field_table_bookings', 2);

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `properties`
--

CREATE TABLE `properties` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `judul` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori_id` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `properties`
--

INSERT INTO `properties` (`id`, `judul`, `deskripsi`, `kategori_id`, `harga`, `created_at`, `updated_at`) VALUES
(6, 'RUMAH SYAHRINI', '<div>RUMAH PUNYA SYAHRINI BUAT TIDUR DOANG</div>', 2, 500000000, '2024-07-05 15:53:46', '2024-07-05 15:53:46');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','user') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `phone`, `role`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@gmail.com', '2024-06-11 12:34:05', '1234567890', 'admin', '$2y$10$3irCFFNAbY8Kf1Nj/p5U1OfUzbvrDTm3YeMf59uC.Fql3xEVl1U6S', 'UMa4H2znesvWEU9oSpuCTbUaix6qwhq3kApQFnm2vBEhpxGqtjeNMnAdSxFU', '2024-06-11 12:34:05', '2024-06-11 12:34:05'),
(2, 'User', 'user@gmail.com', '2024-06-11 12:34:05', '1234567890', 'user', '$2y$10$FoMbkt0sDDzYKSfi1bmTJezWpQx7ZkEoX/J8iEaptfw5Z0.xqjaam', '0S7x7PxxObDaGAOjSDSuKGgJAipyhTAnQ7cbSjYMbrMkj46TN7ZcqqQW2Q7a', '2024-06-11 12:34:05', '2024-06-11 12:34:05'),
(3, 'Akmal', 'akmal@gmail.com', NULL, '0877', 'user', '$2y$10$VYZkaPHpvSxMBuF9oeoP1ONpRsZW3SQ/cw59BEjkhTQbzCl1FoDGS', NULL, '2024-06-30 04:16:35', '2024-06-30 04:16:35'),
(4, 'shasha', 'shasha@gmail.com', NULL, '12345670', 'user', '$2y$10$SigMHASY.fcuS5m0OStD3eqNE54GR8B/Vl9lCX//BRVUVOir0vMue', NULL, '2024-06-30 08:53:24', '2024-06-30 08:53:24'),
(5, 'darma', 'darma@gmail.com', NULL, '12344678', 'user', '$2y$10$Y/m1yY6W0e2Pm.TKL/2L1e5J3BKC.lWcFeg7nbrDGStTVbNoHOr4.', NULL, '2024-06-30 10:19:04', '2024-06-30 10:19:04'),
(6, 'mantap', 'mantap@gmail.com', NULL, '1234567890', 'user', '$2y$10$tLLv3DktoKg/78vMwTrjIuqMDe6sbE2/sCg94F2uAVI0C5N3sZOB2', NULL, '2024-07-05 03:41:56', '2024-07-05 03:41:56'),
(7, 'mamen', 'mamen@gmail.com', NULL, '1234', 'admin', '$2y$10$0UhO.sCItj6SbbH6N0r/ceBnTmXI5/AFXOt.LwR6lvplZs3pRpxW2', NULL, '2024-07-05 04:47:42', '2024-07-05 04:47:42');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `dokumens`
--
ALTER TABLE `dokumens`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `foto_pembayarans`
--
ALTER TABLE `foto_pembayarans`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `foto_propertis`
--
ALTER TABLE `foto_propertis`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `kategori_propertis`
--
ALTER TABLE `kategori_propertis`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indeks untuk tabel `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `dokumens`
--
ALTER TABLE `dokumens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `foto_pembayarans`
--
ALTER TABLE `foto_pembayarans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `foto_propertis`
--
ALTER TABLE `foto_propertis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `kategori_propertis`
--
ALTER TABLE `kategori_propertis`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `properties`
--
ALTER TABLE `properties`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
