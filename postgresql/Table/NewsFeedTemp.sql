-- Database Connect
\c <databasename>;

-- ===========================
--        File: NewsFeedTemp
--     Created: 09/07/2020
--     Updated: 10/05/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: News Feed Temp
-- ===========================

-- Table Drop
drop table if exists NewsFeedTemp;

-- Table Create
create table if not exists NewsFeedTemp(
  title citext default null,
  imageurl citext default null,
  feedurl citext default null,
  actualurl citext default null,
  publish_date text default null,
  created_date timestamp default current_timestamp
);
