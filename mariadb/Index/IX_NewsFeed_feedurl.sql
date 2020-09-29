-- Database Connect
use <databasename>;

-- ================================
--        File: IX_NewsFeed_feedurl
--     Created: 09/07/2020
--     Updated: 09/28/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Index news feed url
-- ================================

-- Index Drop
drop index if exists `IX_NewsFeed_feedurl` on NewsFeed;

-- Index Create
create index `IX_NewsFeed_feedurl` on NewsFeed (`feedurl`);
