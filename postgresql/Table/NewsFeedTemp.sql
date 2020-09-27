-- Database Connect
\c <databasename>;

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
create table if not exists NewsFeedTemp(
  title text default null,
  imageurl text default null,
  feedurl text default null,
  actualurl text default null,
  publish_date text default null,
  created_date timestamp default current_timestamp
);