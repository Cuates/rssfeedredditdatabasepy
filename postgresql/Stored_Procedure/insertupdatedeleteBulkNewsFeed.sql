-- Database Connect
\c <databasename>;

-- ================================================
--        File: insertupdatedeleteBulkNewsFeed
--     Created: 09/07/2020
--     Updated: 10/14/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Insert Update Delete Bulk News Feed
-- ================================================

-- Procedure Drop
drop procedure if exists insertupdatedeleteBulkNewsFeed;

-- Procedure Create Or Replace
create or replace procedure insertupdatedeleteBulkNewsFeed(in optionMode text, in title text default null, in imageurl text default null, in feedurl text default null, in actualurl text default null, in publishDate text default null, inout status text default null)
as $$
  -- Declare and set variables
  declare omitOptionMode varchar(255) := '[^a-zA-Z]';
  declare omitTitle varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitImageurl varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitFeedurl varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitActualurl varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitPublishDate varchar(255) := '[^0-9\-: ]';

  begin
    -- Check if parameter is not null
    if optionMode is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      optionMode := regexp_replace(regexp_replace(optionMode, omitOptionMode, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      optionMode := trim(substring(optionMode, 1, 255));

      -- Check if empty string
      if optionMode = '' then
        -- Set parameter to null if empty string
        optionMode := nullif(optionMode, '');
      end if;
    end if;

    -- Check if parameter is not null
    if title is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      title := regexp_replace(regexp_replace(title, omitTitle, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      title := trim(substring(title, 1, 255));

      -- Check if empty string
      if title = '' then
        -- Set parameter to null if empty string
        title := nullif(title, '');
      end if;
    end if;

    -- Check if parameter is not null
    if imageurl is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      imageurl := regexp_replace(regexp_replace(imageurl, omitImageurl, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      imageurl := trim(substring(imageurl, 1, 255));

      -- Check if empty string
      if imageurl = '' then
        -- Set parameter to null if empty string
        imageurl := nullif(imageurl, '');
      end if;
    end if;

    -- Check if parameter is not null
    if feedurl is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      feedurl := regexp_replace(regexp_replace(feedurl, omitFeedurl, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      feedurl := trim(substring(feedurl, 1, 768));

      -- Check if empty string
      if feedurl = '' then
        -- Set parameter to null if empty string
        feedurl := nullif(feedurl, '');
      end if;
    end if;

    -- Check if parameter is not null
    if actualurl is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      actualurl := regexp_replace(regexp_replace(actualurl, omitActualurl, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      actualurl := trim(substring(actualurl, 1, 255));

      -- Check if empty string
      if actualurl = '' then
        -- Set parameter to null if empty string
        actualurl := nullif(actualurl, '');
      end if;
    end if;

    -- Check if parameter is not null
    if publishDate is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      publishDate := regexp_replace(regexp_replace(publishDate, omitPublishDate, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      publishDate := trim(substring(publishDate, 1, 255));

      -- Check if the parameter cannot be casted into a date time
      if to_timestamp(publishDate, 'YYYY-MM-DD HH24:MI:SS') is null then
        -- Set the string as empty to be nulled below
        publishDate := '';
      end if;

      -- Check if empty string
      if publishDate = '' then
        -- Set parameter to null if empty string
        publishDate := nullif(publishDate, '');
      end if;
    end if;

    -- Check if option mode is delete temp news
    if optionMode = 'deleteTempNews' then
      -- Delete records
      delete from NewsFeedTemp;

      -- Select message
      select
      'Success~Record(s) deleted' into status;

    -- Check if option mode is insert temp news
    elseif optionMode = 'insertTempNews' then
      -- Check if parameters are not null
      if title is not null and publishDate is not null then
        -- Insert record
        insert into NewsFeedTemp(title, imageurl, feedurl, actualurl, publish_date, created_date) values (title, imageurl, feedurl, actualurl, publishDate, current_timestamp);

        -- Select message
        select
        'Success~Record(s) inserted' into status;
      else
        -- Select message
        select
        'Error~Process halted, title and or publish date were not provided' into status;
      end if;

    -- Else check if option mode is update bulk news
    elseif optionMode = 'updateBulkNews' then
      -- Remove duplicate records based on group by
      with subNewsDetails as
      (
        -- Select unique records
        select
        trim(nft.title) as nfttitle,
        trim(nft.imageurl) as nftimageurl,
        trim(nft.feedurl) as nftfeedurl,
        trim(nft.actualurl) as nftactualurl,
        nft.publish_date as nftpublishdate,
        nf.nfID as nfnfID
        from NewsFeedTemp nft
        left join NewsFeed nf on nf.title = nft.title
        where
        nf.nfID is not null and
        (
          (
            trim(nft.title) <> '' and
            trim(nft.feedurl) <> '' and
            trim(nft.publish_date) <> ''
          ) or
          (
            nft.title is not null and
            nft.feedurl is not null and
            nft.publish_date is not null
          )
        ) and
        (
          cast(nft.publish_date as timestamp) >= current_timestamp + interval '-1 hour' and
          cast(nft.publish_date as timestamp) <= current_timestamp + interval '0 hour'
        )
        group by nft.title, nft.imageurl, nft.feedurl, nft.actualurl, nft.publish_date, nf.nfID
      ),
      filteredNewsDetails as
      (
        -- Select unique records
        select
        substring(trim(regexp_replace(regexp_replace(snd.nfttitle, omitTitle, ' '), '[ ]{2,}', ' ')), 1, 255) as title,
        max(snd.nftpublishdate) as publishdate
        from subNewsDetails snd
        group by substring(trim(regexp_replace(regexp_replace(snd.nfttitle, omitTitle, ' '), '[ ]{2,}', ' ')), 1, 255)
      ),
      newsDetails as
      (
        -- Select unique records
        select
        substring(trim(regexp_replace(regexp_replace(snd.nfttitle, omitTitle, ' '), '[ ]{2,}', ' ')), 1, 255) as title,
        substring(trim(regexp_replace(regexp_replace(snd.nftimageurl, omitImageurl, ' '), '[ ]{2,}', ' ')), 1, 255) as imageurl,
        substring(trim(regexp_replace(regexp_replace(snd.nftfeedurl, omitFeedurl, ' '), '[ ]{2,}', ' ')), 1, 768) as feedurl,
        substring(trim(regexp_replace(regexp_replace(snd.nftactualurl, omitActualurl, ' '), '[ ]{2,}', ' ')), 1, 255) as actualurl,
        substring(trim(regexp_replace(regexp_replace(snd.nftpublishdate, omitPublishDate, ' '), '[ ]{2,}', ' ')), 1, 255) as publishdate,
        snd.nfnfID as nfID
        from subNewsDetails snd
        join filteredNewsDetails fnd on fnd.title = snd.nfttitle and fnd.publishdate = snd.nftpublishdate
        group by snd.nfttitle, snd.nftimageurl, snd.nftfeedurl, snd.nftactualurl, snd.nftpublishdate, snd.nfnfID
      )

      -- Update records
      update NewsFeed
      set
      imageurl =
      case
        when trim(nd.imageurl) = ''
          then
            null
        else
          nd.imageurl
      end,
      feedurl = nd.feedurl,
      actualurl =
      case
        when trim(nd.actualurl) = ''
          then
            null
        else
          nd.actualurl
      end,
      publish_date = cast(nd.publishdate as timestamp),
      modified_date = cast(current_timestamp as timestamp)
      from newsDetails nd
      where
      nd.nfID = NewsFeed.nfID;

      -- Select message
      select
      'Success~Record(s) updated' into status;

    -- Else check if option mode is insert bulk news
    elseif optionMode = 'insertBulkNews' then
      -- Insert records
      insert into newsfeed (title, imageurl, feedurl, actualurl, publish_date, created_date, modified_date)

      -- Remove duplicate records based on group by
      with subNewsDetails as
      (
        -- Select unique records
        select
        trim(nft.title) as nfttitle,
        trim(nft.imageurl) as nftimageurl,
        trim(nft.feedurl) as nftfeedurl,
        trim(nft.actualurl) as nftactualurl,
        nft.publish_date as nftpublishdate,
        nf.nfID as nfnfID
        from NewsFeedTemp nft
        left join NewsFeed nf on nf.title = nft.title
        where
        nf.nfID is null and
        (
          (
            trim(nft.title) <> '' and
            trim(nft.feedurl) <> '' and
            trim(nft.publish_date) <> ''
          ) or
          (
            nft.title is not null and
            nft.feedurl is not null and
            nft.publish_date is not null
          )
        ) -- and
        -- (
        --   cast(nft.publish_date as timestamp) >= current_timestamp + interval '-1 hour' and
        --   cast(nft.publish_date as timestamp) <= current_timestamp + interval '0 hour'
        -- )
        group by nft.title, nft.imageurl, nft.feedurl, nft.actualurl, nft.publish_date, nf.nfID
      ),
      filteredNewsDetails as
      (
        -- Select unique records
        select
        substring(trim(regexp_replace(regexp_replace(snd.nfttitle, omitTitle, ' '), '[ ]{2,}', ' ')), 1, 255) as title,
        max(snd.nftpublishdate) as publishdate
        from subNewsDetails snd
        group by substring(trim(regexp_replace(regexp_replace(snd.nfttitle, omitTitle, ' '), '[ ]{2,}', ' ')), 1, 255)
      ),
      newsDetails as
      (
        -- Select unique records
        select
        substring(trim(regexp_replace(regexp_replace(snd.nfttitle, omitTitle, ' '), '[ ]{2,}', ' ')), 1, 255) as title,
        substring(trim(regexp_replace(regexp_replace(snd.nftimageurl, omitImageurl, ' '), '[ ]{2,}', ' ')), 1, 255) as imageurl,
        substring(trim(regexp_replace(regexp_replace(snd.nftfeedurl, omitFeedurl, ' '), '[ ]{2,}', ' ')), 1, 768) as feedurl,
        substring(trim(regexp_replace(regexp_replace(snd.nftactualurl, omitActualurl, ' '), '[ ]{2,}', ' ')), 1, 255) as actualurl,
        substring(trim(regexp_replace(regexp_replace(snd.nftpublishdate, omitPublishDate, ' '), '[ ]{2,}', ' ')), 1, 255) as publishdate,
        snd.nfnfID as nfID
        from subNewsDetails snd
        join filteredNewsDetails fnd on fnd.title = snd.nfttitle and fnd.publishdate = snd.nftpublishdate
        group by snd.nfttitle, snd.nftimageurl, snd.nftfeedurl, snd.nftactualurl, snd.nftpublishdate, snd.nfnfID
      )

      -- Select records
      select
      nd.title,
      case
        when trim(nd.imageurl) = ''
          then
            null
        else
          nd.imageurl
      end,
      nd.feedurl,
      case
        when trim(nd.actualurl) = ''
          then
            null
        else
          nd.actualurl
      end,
      cast(nd.publishdate as timestamp),
      cast(current_timestamp as timestamp),
      cast(current_timestamp as timestamp)
      from newsDetails nd
      left join NewsFeed nf on nf.nfID = nd.nfID
      group by nd.title, nd.imageurl, nd.feedurl, nd.actualurl, nd.publishdate;

      -- Select message
      select
      'Success~Record(s) inserted' into status;
    end if;
  end; $$
language plpgsql;