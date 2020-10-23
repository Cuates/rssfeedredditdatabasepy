-- Database Connect
\c <databasename>;

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
create table if not exists newsfeedtemp(
  title citext default null,
  imageurl citext default null,
  feedurl citext default null,
  actualurl citext default null,
  publish_date text default null,
  created_date timestamp default current_timestamp
);
