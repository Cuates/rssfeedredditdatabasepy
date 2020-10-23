-- Database Connect
\c <databasename>;

-- =======================
--        File: newsfeed
--     Created: 09/07/2020
--     Updated: 10/23/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: News feed
-- =======================

-- Table Drop
drop table if exists newsfeed;

-- Sequence Create
create sequence newsfeed_nfID_seq;

-- Table Create
create table if not exists newsfeed(
  nfID bigint not null default nextval('newsfeed_nfID_seq'),
  title citext not null,
  imageurl citext default null,
  feedurl citext not null,
  actualurl citext default null,
  publish_date timestamp not null,
  created_date timestamp not null default current_timestamp,
  modified_date timestamp default current_timestamp,
  constraint pk_newsfeed_title primary key (title)
);

-- Sequence Alter ownership
alter sequence newsfeed_nfID_seq owned by newsfeed.nfID;

-- Grant permission to a sequence
grant usage, select on sequence newsfeed_nfID_seq to <userrolename>;
