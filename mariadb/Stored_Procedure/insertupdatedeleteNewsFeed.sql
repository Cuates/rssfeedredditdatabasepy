-- Database Connect
use <databasename>;

-- ===========================================
--        File: insertupdatedeleteNewsFeed
--     Created: 09/07/2020
--     Updated: 09/27/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Insert Update Delete News Feed
-- ===========================================

-- Procedure Drop
drop procedure if exists insertupdatedeleteNewsFeed;

-- Procedure Create
delimiter //
create procedure `insertupdatedeleteNewsFeed`(in optionMode text, in title text, in imageurl text, in feedurl text, in actualurl text, in publishDate text)
  begin
    -- Omit characters, multi space to single space, and trim leading and trailing spaces
    set optionMode = trim(regexp_replace(regexp_replace(optionMode, '[^a-zA-Z]', ' '), '[ ]{2,}', ' '));

    -- Check if empty string
    if optionMode = '' then
      -- Set parameter to null if empty string
      set optionMode = nullif(optionMode, '');
    end if;

    -- Set character limit
    set optionMode = substring(optionMode, 1, 255);

    -- Omit characters, multi space to single space, and trim leading and trailing spaces
    set title = trim(regexp_replace(regexp_replace(title, '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' '), '[ ]{2,}', ' '));

    -- Check if empty string
    if title = '' then
      -- Set parameter to null if empty string
      set title = nullif(title, '');
    end if;

    -- Set character limit
    set title = substring(title, 1, 255);

    -- Omit characters, multi space to single space, and trim leading and trailing spaces
    set imageurl = trim(regexp_replace(regexp_replace(imageurl, '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' '), '[ ]{2,}', ' '));

    -- Check if empty string
    if imageurl = '' then
      -- Set parameter to null if empty string
      set imageurl = nullif(imageurl, '');
    end if;

    -- Set character limit
    set imageurl = substring(imageurl, 1, 255);

    -- Omit characters, multi space to single space, and trim leading and trailing spaces
    set feedurl = trim(regexp_replace(regexp_replace(feedurl, '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' '), '[ ]{2,}', ' '));

    -- Check if empty string
    if feedurl = '' then
      -- Set parameter to null if empty string
      set feedurl = nullif(feedurl, '');
    end if;

    -- Set character limit
    set feedurl = substring(feedurl, 1, 768);

    -- Omit characters, multi space to single space, and trim leading and trailing spaces
    set actualurl = trim(regexp_replace(regexp_replace(actualurl, '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' '), '[ ]{2,}', ' '));

    -- Check if empty string
    if actualurl = '' then
      -- Set parameter to null if empty string
      set actualurl = nullif(actualurl, '');
    end if;

    -- Set character limit
    set actualurl = substring(actualurl, 1, 255);

    -- Omit characters, multi space to single space, and trim leading and trailing spaces
    set publishDate = trim(regexp_replace(regexp_replace(publishDate, '[^0-9\-: ]', ' '), '[ ]{2,}', ' '));

    -- Check if the parameter cannot be casted into a date time
    if str_to_date(publishDate, '%Y-%m-%d %H:%i:%S') is null then
      -- Set the string as empty to be nulled below
      set publishDate = '';
    end if;

    -- Check if empty string
    if publishDate = '' then
      -- Set parameter to null if empty string
      set publishDate = nullif(publishDate, '');
    end if;

    -- Set character limit
    set publishDate = substring(publishDate, 1, 255);

    -- Check if option mode is delete temp news
    if optionMode = 'deleteTempNews' then
      -- Delete records
      delete from NewsFeedTemp;

      -- Select message
      select
      'Success~Record(s) deleted' as `status`;

    -- Check if option mode is insert temp news
    elseif optionMode = 'insertTempNews' then
      -- Check if parameters are not null
      if title is not null and publishDate is not null then
        -- Insert record
        insert into NewsFeedTemp(title, imageurl, feedurl, actualurl, publish_date, created_date) values (title, imageurl, feedurl, actualurl, publishDate, current_timestamp(6));

        -- Select message
        select
        'Success~Record(s) inserted' as `status`;
      else
        -- Select message
        select
        'Error~Process halted, title and or publish date were not provided' as `status`;
      end if;

    -- Else check if option mode is update bulk news
    elseif optionMode = 'updateBulkNews' then
      -- Create temporary table
      create temporary table if not exists NewsFeedTempTable
      (
        `nfttID` bigint(20) default null,
        `title` varchar(255) collate utf8mb4_unicode_520_ci not null,
        `imageurl` varchar(255) collate utf8mb4_unicode_520_ci default null,
        `feedurl` varchar(768) collate utf8mb4_unicode_520_ci not null,
        `actualurl` varchar(255) collate utf8mb4_unicode_520_ci default null,
        `publish_date` datetime not null
      );

      -- Insert records
      insert into NewsFeedTempTable (title, imageurl, feedurl, actualurl, publish_date, nfttID)

      -- Remove duplicate records based on group by
      with subNewsDetails as
      (
        -- Select unique records
        select
        trim(nft.title) as `nfttitle`,
        lower(trim(nft.title)) as `nfttitlelower`,
        trim(nft.imageurl) as `nftimageurl`,
        trim(nft.feedurl) as `nftfeedurl`,
        trim(nft.actualurl) as `nftactualurl`,
        nft.publish_date as `nftpublishdate`,
        nf.nfID as `nfnfID`,
        trim(nf.title) as `nftitle`,
        lower(trim(nf.title)) as `nftitlelower`
        from NewsFeedTemp nft
        left join NewsFeed nf on nf.feedurl = nft.feedurl
        where
        (
          nft.title is not null and
          nft.feedurl is not null and
          nft.publish_date is not null
        ) -- and
        -- (
        --   cast(nft.publish_date as datetime) >= date_add(current_timestamp(), interval -1 hour) and
        --   cast(nft.publish_date as datetime) <= date_add(current_timestamp(), interval 0 hour)
        -- )
        group by nft.title, nft.imageurl, nft.feedurl, nft.actualurl, nft.publish_date, nf.title, nf.nfID, nf.title
      ),
      filteredNewsDetails as
      (
        -- Select unique records
        select
        snd.nfttitlelower as `titlelower`,
        max(snd.nftpublishdate) as `publishdate`
        from subNewsDetails snd
        group by snd.nfttitlelower
      ),
      newsDetails as
      (
        -- Select unique records
        select
        snd.nfttitle as `title`,
        snd.nftimageurl as `imageurl`,
        snd.nftfeedurl as `feedurl`,
        snd.nftactualurl as `actualurl`,
        snd.nftpublishdate as `publishdate`,
        snd.nfnfID as `nfID`
        from subNewsDetails snd
        join filteredNewsDetails fnd on fnd.titlelower = snd.nfttitlelower and fnd.publishdate = snd.nftpublishdate
        where
        (
          snd.nfttitlelower = snd.nftitlelower
        )
        group by snd.nfttitle, snd.nftimageurl, snd.nftfeedurl, snd.nftactualurl, snd.nftpublishdate, snd.nfnfID
      )

      -- Select records
      select
      nd.title as `title`,
      nd.imageurl as `imageurl`,
      nd.feedurl as `feedurl`,
      nd.actualurl as `actualurl`,
      nd.publishdate as `publishdate`,
      nd.nfID as `nfID`
      from newsDetails nd;

      -- Update records
      update NewsFeed nf
      join NewsFeedTempTable nftt on nftt.nfttID = nf.nfID
      set
      nf.imageurl = if(trim(nftt.imageurl) = '', null, trim(nftt.imageurl)),
      nf.feedurl = nftt.feedurl,
      nf.actualurl = if(trim(nftt.actualurl) = '', null, trim(nftt.actualurl)),
      nf.publish_date = cast(nftt.publish_date as datetime),
      nf.modified_date = cast(current_timestamp(6) as datetime);

      -- Drop temporary table
      drop temporary table NewsFeedTempTable;

      -- Select message
      select
      'Success~Record(s) updated' as `status`;

    -- Else check if option mode is insert bulk news
    elseif optionMode = 'insertBulkNews' then
      -- Insert records
      insert into NewsFeed (title, imageurl, feedurl, actualurl, publish_date, created_date, modified_date)

      -- Remove duplicate records based on group by
      with subNewsDetails as
      (
        -- Select unique records
        select
        trim(nft.title) as `nfttitle`,
        lower(trim(nft.title)) as `nfttitlelower`,
        trim(nft.imageurl) as `nftimageurl`,
        trim(nft.feedurl) as `nftfeedurl`,
        trim(nft.actualurl) as `nftactualurl`,
        nft.publish_date as `nftpublishdate`,
        nf.nfID as `nfnfID`,
        trim(nf.title) as `nftitle`,
        lower(trim(nf.title)) as `nftitlelower`
        from NewsFeedTemp nft
        left join NewsFeed nf on nf.feedurl = nft.feedurl
        where
        (
          nft.title is not null and
          nft.feedurl is not null and
          nft.publish_date is not null
        ) -- and
        -- (
        --   cast(nft.publish_date as datetime) >= date_add(current_timestamp(), interval -1 hour) and
        --   cast(nft.publish_date as datetime) <= date_add(current_timestamp(), interval 0 hour)
        -- )
        group by nft.title, nft.imageurl, nft.feedurl, nft.actualurl, nft.publish_date, nf.title, nf.nfID, nf.title
      ),
      filteredNewsDetails as
      (
        -- Select unique records
        select
        snd.nfttitlelower as `titlelower`,
        max(snd.nftpublishdate) as `publishdate`
        from subNewsDetails snd
        group by snd.nfttitlelower
      ),
      newsDetails as
      (
        -- Select unique records
        select
        snd.nfttitle as `title`,
        snd.nftimageurl as `imageurl`,
        snd.nftfeedurl as `feedurl`,
        snd.nftactualurl as `actualurl`,
        snd.nftpublishdate as `publishdate`,
        snd.nfnfID as `nfID`
        from subNewsDetails snd
        join filteredNewsDetails fnd on fnd.titlelower = snd.nfttitlelower and fnd.publishdate = snd.nftpublishdate
        where
        (
          snd.nfttitlelower <> snd.nftitlelower or
          snd.nftitle is null
        )
        group by snd.nfttitle, snd.nftimageurl, snd.nftfeedurl, snd.nftactualurl, snd.nftpublishdate, snd.nfnfID
      )

      -- Select records
      select
      nd.title,
      if(trim(nd.imageurl) = '', null, trim(nd.imageurl)),
      nd.feedurl,
      if(trim(nd.actualurl) = '', null, trim(nd.actualurl)),
      cast(nd.publishdate as datetime),
      cast(current_timestamp(6) as datetime),
      cast(current_timestamp(6) as datetime)
      from newsDetails nd
      left join NewsFeed nf on nf.title = nd.title
      where
      nf.title is null
      group by nd.title, nd.imageurl, nd.feedurl, nd.actualurl, nd.publishdate;

      -- Select message
      select
      'Success~Record(s) inserted' as `status`;
    end if;
  end
// delimiter ;