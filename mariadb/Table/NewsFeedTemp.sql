-- Database Connect
use <databasename>;

-- ===========================
--        File: NewsFeedTemp
--     Created: 09/07/2020
--     Updated: 09/27/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: News Feed Temp
-- ===========================

-- Table Drop
drop table if exists NewsFeedTemp;

-- Table Create
create table if not exists `NewsFeedTemp`(
  `title` text collate utf8mb4_unicode_520_ci default null,
  `imageurl` text collate utf8mb4_unicode_520_ci default null,
  `feedurl` text collate utf8mb4_unicode_520_ci default null,
  `actualurl` text collate utf8mb4_unicode_520_ci default null,
  `publish_date` text collate utf8mb4_unicode_520_ci default null,
  `created_date` datetime default current_timestamp()
) engine=InnoDB default charset=utf8mb4 collate utf8mb4_unicode_520_ci;
