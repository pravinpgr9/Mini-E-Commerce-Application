-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 28, 2025 at 01:30 PM
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
-- Database: `ecomm-app`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `product_id`, `name`, `price`, `quantity`, `created_at`, `updated_at`) VALUES
(6, 2, 8, 'Laudantium ex ad et', 65.89, 1, '2025-03-28 03:10:57', '2025-03-28 03:10:57'),
(11, 1, 4, 'demo', 15.45, 2, '2025-03-28 05:44:37', '2025-03-28 05:44:45');

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
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_03_28_060159_create_personal_access_tokens_table', 2),
(5, '2025_03_28_061518_create_products_table', 3),
(6, '2025_03_28_062430_add_stock_to_products_table', 4),
(7, '2025_03_28_063633_create_carts_table', 5);

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

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', '30d3b5ee44eddac8c706ae6d35a6d0920e648cd592252924b71ecc019455ade6', '[\"*\"]', '2025-03-28 06:33:06', NULL, '2025-03-28 00:44:47', '2025-03-28 06:33:06'),
(2, 'App\\Models\\User', 1, 'auth_token', 'df8e9bab315d3a30c8e28a885766e05304a5eff81552de9c40b45564b6153cd7', '[\"*\"]', NULL, NULL, '2025-03-28 02:04:40', '2025-03-28 02:04:40'),
(3, 'App\\Models\\User', 1, 'auth_token', '55b230acf3881164547ed6b786027d9839bb9e6fb1acdc14c1a8ec91d678d2d4', '[\"*\"]', NULL, NULL, '2025-03-28 02:08:31', '2025-03-28 02:08:31'),
(4, 'App\\Models\\User', 1, 'auth_token', '90beadc5acca6eea0886f50ef818253ab67bd63c49cffa664dd4cc1631d6817b', '[\"*\"]', NULL, NULL, '2025-03-28 02:11:50', '2025-03-28 02:11:50'),
(5, 'App\\Models\\User', 1, 'auth_token', '522e017fe20bf37b1d4206d07471bb32faa9870296cadab479c2eee98ac4d878', '[\"*\"]', NULL, NULL, '2025-03-28 02:16:32', '2025-03-28 02:16:32'),
(6, 'App\\Models\\User', 1, 'auth_token', 'b026f310fa91fcd6375250855508c4f7f4de2ce47ac13f6b6e85d36f4a9bb5f9', '[\"*\"]', NULL, NULL, '2025-03-28 02:17:00', '2025-03-28 02:17:00'),
(7, 'App\\Models\\User', 1, 'auth_token', '43d7cbbf2ffddc7f5116fa2c4fb4ba16d1010c9490d4bd66f62db118705f437d', '[\"*\"]', NULL, NULL, '2025-03-28 02:17:22', '2025-03-28 02:17:22'),
(8, 'App\\Models\\User', 1, 'auth_token', '732caacc7c5bb8f86b03c44601d7532d8647a61e7c889b2690d75695975643f7', '[\"*\"]', NULL, NULL, '2025-03-28 02:24:05', '2025-03-28 02:24:05'),
(9, 'App\\Models\\User', 1, 'auth_token', 'e0117064fa6451ecee00b5c183afa1cf8ae5c2d15ed9de53930d5dd553e5981d', '[\"*\"]', '2025-03-28 03:15:47', NULL, '2025-03-28 02:26:15', '2025-03-28 03:15:47'),
(10, 'App\\Models\\User', 1, 'auth_token', 'ae865c916a3576319d2dc46e7f19e7b6b605e63541273afffab6ba1a89500f78', '[\"*\"]', NULL, NULL, '2025-03-28 03:30:07', '2025-03-28 03:30:07'),
(11, 'App\\Models\\User', 1, 'auth_token', 'e4691dbafc253ba41ea0e2b9974eb30703f69eadb29a47645da315511940fc40', '[\"*\"]', NULL, NULL, '2025-03-28 03:31:20', '2025-03-28 03:31:20'),
(12, 'App\\Models\\User', 1, 'auth_token', 'cbb31873891ebbb0e1ce221e62f69c633abb3eacc99d8ba2cece71e3d6276deb', '[\"*\"]', NULL, NULL, '2025-03-28 03:31:58', '2025-03-28 03:31:58'),
(13, 'App\\Models\\User', 1, 'auth_token', 'c8c49a62e36337431d87a46a3db1603e19633fdac5a7d7691a35f1e4130ba896', '[\"*\"]', NULL, NULL, '2025-03-28 03:33:31', '2025-03-28 03:33:31'),
(14, 'App\\Models\\User', 1, 'auth_token', '322569c3c61c44b52bb4564e892e5ec14a6f4817e25bfbafe7d535796e096070', '[\"*\"]', NULL, NULL, '2025-03-28 03:35:36', '2025-03-28 03:35:36'),
(15, 'App\\Models\\User', 1, 'auth_token', 'bbdeccdc474102ba0b9ecdc44a1861241d8bacd637485945537a3ada849ac9f4', '[\"*\"]', NULL, NULL, '2025-03-28 03:37:57', '2025-03-28 03:37:57'),
(16, 'App\\Models\\User', 1, 'auth_token', 'f05c346a994a1e8a2c26989dc126044e04284963f37202ce268ffcbc488ed81f', '[\"*\"]', NULL, NULL, '2025-03-28 03:40:01', '2025-03-28 03:40:01'),
(17, 'App\\Models\\User', 1, 'auth_token', 'bd2c701928b8cfb0da044911b780afc3bb5fff5b7e03f0aca6c7dff6893385ec', '[\"*\"]', NULL, NULL, '2025-03-28 03:41:50', '2025-03-28 03:41:50'),
(18, 'App\\Models\\User', 1, 'auth_token', '469375bd13a23f1bd6cd7fc070aecb16c4c4b468a2f0595b729eb82ba2809907', '[\"*\"]', NULL, NULL, '2025-03-28 03:43:38', '2025-03-28 03:43:38'),
(19, 'App\\Models\\User', 1, 'auth_token', 'a2598dd86aecb8af34bc5902d76e64f3779e9f4b113cb82d418042cc4b580fa3', '[\"*\"]', NULL, NULL, '2025-03-28 03:44:57', '2025-03-28 03:44:57'),
(20, 'App\\Models\\User', 1, 'auth_token', '4427178d3ae500043a09fb625eab6c37ba7ec00f639fd9cd7e146e686edacbff', '[\"*\"]', NULL, NULL, '2025-03-28 03:45:29', '2025-03-28 03:45:29'),
(21, 'App\\Models\\User', 1, 'auth_token', '2e17f0fd2463c5aa9ccb7f9a75a4efaaa7f2f90f26150b34e791a9cab84812a8', '[\"*\"]', NULL, NULL, '2025-03-28 03:45:53', '2025-03-28 03:45:53'),
(22, 'App\\Models\\User', 1, 'auth_token', 'a5e4514842ef38839aa1f2a0fc602b8d3caebf767c4afcaec6f425a421d0de91', '[\"*\"]', NULL, NULL, '2025-03-28 03:46:08', '2025-03-28 03:46:08'),
(23, 'App\\Models\\User', 1, 'auth_token', 'f8ae94799447e2139f03a728396a2275ab351370e76dc3ebea505636432796aa', '[\"*\"]', NULL, NULL, '2025-03-28 03:46:29', '2025-03-28 03:46:29'),
(24, 'App\\Models\\User', 1, 'auth_token', '25a0770b8d25e9de2ba8104b5daed2670d0e29f170686c71732dc4208c7201dc', '[\"*\"]', NULL, NULL, '2025-03-28 03:52:44', '2025-03-28 03:52:44'),
(25, 'App\\Models\\User', 1, 'auth_token', 'e769dc63c4a48b6cd1dd27d4624dfd748d14f00b35e85dda07412ff455574b0b', '[\"*\"]', NULL, NULL, '2025-03-28 03:53:45', '2025-03-28 03:53:45'),
(26, 'App\\Models\\User', 1, 'auth_token', 'b7f9a1f3fb80da4d706496bfd8bc9b379a37e1a1efb40069e39fcfad9031d570', '[\"*\"]', NULL, NULL, '2025-03-28 03:55:16', '2025-03-28 03:55:16'),
(27, 'App\\Models\\User', 1, 'auth_token', '6c479f01daacc488652d4feb10c70d8c8c4bf988646b100ab5d7c3363efd39de', '[\"*\"]', NULL, NULL, '2025-03-28 04:06:29', '2025-03-28 04:06:29'),
(28, 'App\\Models\\User', 1, 'auth_token', '0317f23d1089249746c929039010787d4b85f8eabfed810c0c1da4cc8b9ceeb6', '[\"*\"]', NULL, NULL, '2025-03-28 04:08:49', '2025-03-28 04:08:49'),
(29, 'App\\Models\\User', 1, 'auth_token', '3689837d4f2bafc0476f865a99c4436709ac0c1f1c7b70255d5924e29ef34d45', '[\"*\"]', NULL, NULL, '2025-03-28 04:11:17', '2025-03-28 04:11:17'),
(30, 'App\\Models\\User', 1, 'auth_token', '944a6ef5cd9a8e658796ec94c884b435dee53c4b04381e199968b45c2257c7c5', '[\"*\"]', NULL, NULL, '2025-03-28 04:12:33', '2025-03-28 04:12:33'),
(31, 'App\\Models\\User', 1, 'auth_token', '6642fb5f758bf35948ffa68ebac1e51a4435c9b6c5ec478d8ffd04895258a0f4', '[\"*\"]', NULL, NULL, '2025-03-28 04:13:08', '2025-03-28 04:13:08'),
(32, 'App\\Models\\User', 1, 'auth_token', '1b4a0fa8bdcf1dbb9ebfff30d1fa39f120e235c9a1e545264f87b98fe62a543d', '[\"*\"]', NULL, NULL, '2025-03-28 04:14:33', '2025-03-28 04:14:33'),
(33, 'App\\Models\\User', 1, 'auth_token', '1fef33c8a5d6069fe0ed3ef9ced983329b2459dd4ad5ac0e1f3d1c71326a1ba8', '[\"*\"]', '2025-03-28 06:46:41', NULL, '2025-03-28 04:15:44', '2025-03-28 06:46:41'),
(34, 'App\\Models\\User', 1, 'auth_token', '102e819940c2176d4b9678548202e9245d72ffcabaab74685ebfffebe6c70add', '[\"*\"]', NULL, NULL, '2025-03-28 06:33:54', '2025-03-28 06:33:54');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text NOT NULL,
  `stock_quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `stock` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `description`, `stock_quantity`, `created_at`, `updated_at`, `stock`) VALUES
(8, 'Laudantium ex ad et', 65.89, 'Voluptatum dolor nec', 15, '2025-03-28 03:09:38', '2025-03-28 03:09:38', 0),
(9, 'Facere consequatur', 69.97, 'Aut vel non quia nul', 85, '2025-03-28 03:11:35', '2025-03-28 03:11:35', 0),
(10, 'testing', 458.00, 'demo testing', 89, '2025-03-28 04:36:08', '2025-03-28 04:36:08', 0);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('FtNJrJ80w0LnvAEdg7p64PIeIZE3kwrx8CU1i5NE', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiZFZpOG02Zk05WW51Sktyakh1OHp1ZFNQQW9KS3A3SlFQZlp5ejNSeCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1743164279);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'DemoTest', 'ttedd45@gmail.com', NULL, '$2y$12$hSJxzHPl1sSHdcJJ8AsPxes9gizqdGKo6ZxOzEAaC1WlxeITEHs3m', NULL, '2025-03-28 00:41:17', '2025-03-28 00:41:17'),
(2, 'Fulton Pruitt', 'nygonir@mailinator.com', NULL, '$2y$12$gwN0yYqgobShDwOzmS0Oh.2XC3gAtyxMhRdEseDuEfhf5pcfHJe6a', NULL, '2025-03-28 03:12:23', '2025-03-28 03:12:23');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
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
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

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
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
