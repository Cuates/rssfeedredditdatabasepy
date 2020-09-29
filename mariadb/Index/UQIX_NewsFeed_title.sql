-- Database Connect
use <databasename>;

-- ==================================
--        File: UQIX_NewsFeed_title
--     Created: 09/07/2020
--     Updated: 09/28/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Index news feed title
-- ==================================

-- Index Drop
drop index if exists `UQIX_NewsFeed_title` on NewsFeed;

-- Index Create
create unique index `UQIX_NewsFeed_title` on NewsFeed (`title`);
