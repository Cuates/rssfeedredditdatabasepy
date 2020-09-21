-- Database Connect
\c <databasename>;

-- Sequence Create
create sequence NewsFeed_nfID_seq;

-- Table Create
create table if not exists NewsFeed(
  nfID bigint not null default nextval('NewsFeed_nfID_seq'),
  title varchar(255) not null,
  imageurl varchar(255) default null,
  feedurl text default null,
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