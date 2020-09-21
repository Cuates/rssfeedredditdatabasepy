-- Database Connect
\c <databasename>;

-- Table Create
create table if not exists NewsFeedTemp(
  title text default null,
  imageurl text default null,
  feedurl text default null,
  actualurl text default null,
  publish_date text default null,
  created_date timestamp default current_timestamp
);