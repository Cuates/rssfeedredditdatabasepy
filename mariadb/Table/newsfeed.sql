-- Database Connect
use <databasename>;

-- =======================
--        File: newsfeed
--     Created: 09/07/2020
--     Updated: 11/05/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: News feed
-- =======================

-- Table Drop
drop table if exists newsfeed;

-- Table Create
create table if not exists `newsfeed`(
  `nfID` bigint(20) unsigned not null auto_increment,
  `title` varchar(255) collate utf8mb4_unicode_520_ci not null,
  `imageurl` varchar(255) collate utf8mb4_unicode_520_ci default null,
  `feedurl` varchar(768) collate utf8mb4_unicode_520_ci not null,
  `actualurl` varchar(255) collate utf8mb4_unicode_520_ci default null,
  `publish_date` datetime not null,
  `created_date` datetime not null default current_timestamp(6),
  `modified_date` datetime default current_timestamp(6),
  primary key (`nfID`),
  unique key `uqix_newsfeed_title` (`title`)
) engine=InnoDB default charset=utf8mb4 collate utf8mb4_unicode_520_ci;
