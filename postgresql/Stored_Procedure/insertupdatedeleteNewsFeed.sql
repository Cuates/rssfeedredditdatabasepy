-- Database Connect
\c <databasename>;

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

-- Procedure Create Or Replace
create or replace procedure insertupdatedeleteNewsFeed(in optionMode text, in title text default null, in imageurl text default null, in feedurl text default null, in actualurl text default null, in publishDate text default null, inout status text default null)
as $$
  begin
    -- Omit characters, multi space to single space, and trim leading and trailing spaces
    optionMode := trim(regexp_replace(regexp_replace(optionMode, '[^a-zA-Z]', ' '), '[ ]{2,}', ' '));

    -- Check if empty string
    if optionMode = '' then
      -- Set parameter to null if empty string
      optionMode := nullif(optionMode, '');
    end if;

    -- Set character limit
    optionMode := substring(optionMode, 1, 255);

    -- Omit characters, multi space to single space, and trim leading and trailing spaces
    title := trim(regexp_replace(regexp_replace(title, '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' '), '[ ]{2,}', ' '));

    -- Check if empty string
    if title = '' then
      -- Set parameter to null if empty string
      title := nullif(title, '');
    end if;

    -- Set character limit
    title := substring(title, 1, 255);

    -- Omit characters, multi space to single space, and trim leading and trailing spaces
    imageurl := trim(regexp_replace(regexp_replace(imageurl, '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' '), '[ ]{2,}', ' '));

    -- Check if empty string
    if imageurl = '' then
      -- Set parameter to null if empty string
      imageurl := nullif(imageurl, '');
    end if;

    -- Set character limit
    imageurl := substring(imageurl, 1, 255);

    -- Omit characters, multi space to single space, and trim leading and trailing spaces
    feedurl := trim(regexp_replace(regexp_replace(feedurl, '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' '), '[ ]{2,}', ' '));

    -- Check if empty string
    if feedurl = '' then
      -- Set parameter to null if empty string
      feedurl := nullif(feedurl, '');
    end if;

    -- Set character limit
    feedurl := substring(feedurl, 1, 768);

    -- Omit characters, multi space to single space, and trim leading and trailing spaces
    actualurl := trim(regexp_replace(regexp_replace(actualurl, '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' '), '[ ]{2,}', ' '));

    -- Check if empty string
    if actualurl = '' then
      -- Set parameter to null if empty string
      actualurl := nullif(actualurl, '');
    end if;

    -- Set character limit
    actualurl := substring(actualurl, 1, 255);

    -- Omit characters, multi space to single space, and trim leading and trailing spaces
    publishDate := trim(regexp_replace(regexp_replace(publishDate, '[^0-9\-: ]', ' '), '[ ]{2,}', ' '));

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

    -- Set character limit
    publishDate := substring(publishDate, 1, 255);

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
        lower(trim(nft.title)) as nfttitlelower,
        trim(nft.imageurl) as nftimageurl,
        trim(nft.feedurl) as nftfeedurl,
        trim(nft.actualurl) as nftactualurl,
        nft.publish_date as nftpublishdate,
        nf.nfID as nfnfID,
        trim(nf.title) as nftitle,
        lower(trim(nf.title)) as nftitlelower
        from NewsFeedTemp nft
        left join NewsFeed nf on nf.feedurl = nft.feedurl
        where
        (
          nft.title is not null and
          nft.feedurl is not null and
          nft.publish_date is not null
        ) -- and
        -- (
        --   cast(nft.publish_date as timestamp) >= current_timestamp + interval '-1 hour' and
        --   cast(nft.publish_date as timestamp) <= current_timestamp + interval '0 hour'
        -- )
        group by nft.title, nft.imageurl, nft.feedurl, nft.actualurl, nft.publish_date, nf.title, nf.nfID, nf.title
      ),
      filteredNewsDetails as
      (
        -- Select unique records
        select
        snd.nfttitlelower as titlelower,
        max(snd.nftpublishdate) as publishdate
        from subNewsDetails snd
        group by snd.nfttitlelower
      ),
      newsDetails as
      (
        -- Select unique records
        select
        snd.nfttitle as title,
        snd.nftimageurl as imageurl,
        snd.nftfeedurl as feedurl,
        snd.nftactualurl as actualurl,
        snd.nftpublishdate as publishdate,
        snd.nfnfID as nfID
        from subNewsDetails snd
        join filteredNewsDetails fnd on fnd.titlelower = snd.nfttitlelower and fnd.publishdate = snd.nftpublishdate
        where
        (
          snd.nfttitlelower = snd.nftitlelower
        )
        group by snd.nfttitle, snd.nftimageurl, snd.nftfeedurl, snd.nftactualurl, snd.nftpublishdate, snd.nfnfID
      )

      -- Update records
      update NewsFeed
      set
      imageurl = case when trim(nd.imageurl) = '' then null else trim(nd.imageurl) end,
      feedurl = nd.feedurl,
      actualurl = case when trim(nd.actualurl) = '' then null else trim(nd.actualurl) end,
      publish_date = cast(nd.publishdate as timestamp),
      modified_date = current_timestamp
      from newsDetails nd
      join NewsFeed nf on nf.nfID = nd.nfID;

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
        lower(trim(nft.title)) as nfttitlelower,
        trim(nft.imageurl) as nftimageurl,
        trim(nft.feedurl) as nftfeedurl,
        trim(nft.actualurl) as nftactualurl,
        nft.publish_date as nftpublishdate,
        nf.nfID as nfnfID,
        trim(nf.title) as nftitle,
        lower(trim(nf.title)) as nftitlelower
        from NewsFeedTemp nft
        left join NewsFeed nf on nf.feedurl = nft.feedurl
        where
        (
          nft.title is not null and
          nft.feedurl is not null and
          nft.publish_date is not null
        ) -- and
        -- (
        --   cast(nft.publish_date as timestamp) >= current_timestamp + interval '-1 hour' and
        --   cast(nft.publish_date as timestamp) <= current_timestamp + interval '0 hour'
        -- )
        group by nft.title, nft.imageurl, nft.feedurl, nft.actualurl, nft.publish_date, nf.title, nf.nfID, nf.title
      ),
      filteredNewsDetails as
      (
        -- Select unique records
        select
        snd.nfttitlelower as titlelower,
        max(snd.nftpublishdate) as publishdate
        from subNewsDetails snd
        group by snd.nfttitlelower
      ),
      newsDetails as
      (
        -- Select unique records
        select
        snd.nfttitle as title,
        snd.nftimageurl as imageurl,
        snd.nftfeedurl as feedurl,
        snd.nftactualurl as actualurl,
        snd.nftpublishdate as publishdate,
        snd.nfnfID as nfID
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
      case
        when trim(nd.imageurl) = ''
          then
            null
        else
          trim(nd.imageurl)
      end,
      nd.feedurl,
      case
        when trim(nd.actualurl) = ''
          then
            null
        else
          trim(nd.actualurl)
      end,
      cast(nd.publishdate as timestamp),
      current_timestamp,
      current_timestamp
      from newsDetails nd
      left join NewsFeed nf on nf.title = nd.title
      where
      nf.title is null
      group by nd.title, nd.imageurl, nd.feedurl, nd.actualurl, nd.publishdate;

      -- Select message
      select
      'Success~Record(s) inserted' into status;
    end if;
  end; $$
language plpgsql;