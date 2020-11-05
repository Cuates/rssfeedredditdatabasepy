-- Database Connect
use <databasename>;

-- ===========================
--        File: newsfeedtemp
--     Created: 09/07/2020
--     Updated: 10/23/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: News feed temp
-- ===========================

-- Table Drop
drop table if exists newsfeedtemp;

-- Table Create
create table if not exists `newsfeedtemp`(
  `title` text collate utf8mb4_unicode_520_ci default null,
  `imageurl` text collate utf8mb4_unicode_520_ci default null,
  `feedurl` text collate utf8mb4_unicode_520_ci default null,
  `actualurl` text collate utf8mb4_unicode_520_ci default null,
  `publish_date` text collate utf8mb4_unicode_520_ci default null,
  `created_date` datetime default current_timestamp(6)
) engine=InnoDB default charset=utf8mb4 collate utf8mb4_unicode_520_ci;
