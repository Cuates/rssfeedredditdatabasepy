-- Database Connect
use <databasename>;

-- =======================
--        File: NewsFeed
--     Created: 09/07/2020
--     Updated: 10/23/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: News Feed
-- =======================

-- Table Drop
drop table if exists NewsFeed;

-- Table Create
create table if not exists `NewsFeed`(
  `nfID` bigint(20) unsigned not null auto_increment,
  `title` varchar(255) collate utf8mb4_unicode_520_ci not null,
  `imageurl` varchar(255) collate utf8mb4_unicode_520_ci default null,
  `feedurl` varchar(768) collate utf8mb4_unicode_520_ci not null,
  `actualurl` varchar(255) collate utf8mb4_unicode_520_ci default null,
  `publish_date` datetime not null,
  `created_date` datetime not null default current_timestamp(),
  `modified_date` datetime default current_timestamp(),
  primary key (`nfID`),
  unique key `uqix_NewsFeed_title` (`title`),
  index `ix_NewsFeed_feedurl` (`feedurl`)
) engine=InnoDB default charset=utf8mb4 collate utf8mb4_unicode_520_ci;
