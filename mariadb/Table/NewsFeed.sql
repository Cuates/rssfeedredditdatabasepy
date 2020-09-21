-- Database Connect
use <databasename>;

-- Table Create
create table if not exists `NewsFeed`(
  `nfID` bigint(20) unsigned not null auto_increment,
  `title` varchar(255) collate utf8mb4_unicode_520_ci not null,
  `imageurl` varchar(255) collate utf8mb4_unicode_520_ci default null,
  `feedurl` text collate utf8mb4_unicode_520_ci default null,
  `actualurl` varchar(255) collate utf8mb4_unicode_520_ci default null,
  `publish_date` datetime not null,
  `created_date` datetime not null default current_timestamp(),
  `modified_date` datetime default current_timestamp(),
  primary key (`nfID`),
  unique key `UQ_NewsFeed_title` (`title`),
  index `IX_NewsFeed_feedurl` (`feedurl`)
) engine=InnoDB default charset=utf8mb4 collate utf8mb4_unicode_520_ci;