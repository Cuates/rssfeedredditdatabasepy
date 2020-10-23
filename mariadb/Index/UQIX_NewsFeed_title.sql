-- Database Connect
use <databasename>;

-- ==================================
--        File: uqix_newsfeed_title
--     Created: 09/07/2020
--     Updated: 10/23/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Index news feed title
-- ==================================

-- Index Drop
drop index if exists `uqix_newsfeed_title` on newsfeed;

-- Index Create
create unique index `uqix_newsfeed_title` on newsfeed (`title`);
