-- Database Connect
\c <databasename>;

-- =======================
--        File: NewsFeed
--     Created: 09/07/2020
--     Updated: 09/27/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: News Feed
-- =======================

-- Table Drop
drop table if exists NewsFeed;

-- Sequence Create
create sequence NewsFeed_nfID_seq;

-- Table Create
create table if not exists NewsFeed(
  nfID bigint not null default nextval('NewsFeed_nfID_seq'),
  title varchar(255) not null,
  imageurl varchar(255) default null,
  feedurl varchar(768) not null,
  actualurl varchar(255) default null,
  publish_date timestamp not null,
  created_date timestamp not null default current_timestamp,
  modified_date timestamp default current_timestamp,
  constraint PK_NewsFeed_title primary key (title)
);

-- Sequence Alter ownership
alter sequence NewsFeed_nfID_seq owned by NewsFeed.nfID;

-- Grant permission to a sequence
grant usage, select on sequence NewsFeed_nfID_seq to <username>;