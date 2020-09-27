-- Database Connect
\c <databasename>;

-- =====================================
--        File: IX_NewsFeed_feedurl
--     Created: 09/07/2020
--     Updated: 09/27/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Index News Feed feed url
-- =====================================

-- Index Drop
drop index if exists IX_NewsFeed_feedurl;

-- Create Index (To create an index on the expression lower(feedurl), allowing efficient case-insensitive searches)
-- create index IX_NewsFeed_feedurl on NewsFeed ((lower(feedurl)));

-- Create Index (To create an index on the expression feedurl)
create index IX_NewsFeed_feedurl on NewsFeed ((feedurl));
