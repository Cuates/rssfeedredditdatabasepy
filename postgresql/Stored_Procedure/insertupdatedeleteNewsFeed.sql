-- Database Connect
\c <databasename>;

-- Procedure Drop
drop procedure if exists insertupdatedeleteNewsFeed;

-- Procedure Create
create procedure insertupdatedeleteNewsFeed(in optionMode text, in title text default null, in imageurl text default null, in feedurl text default null, in actualurl text default null, in publishDate text default null, inout status text default null)
as $$
  begin
    -- Omit characters
    optionMode := regexp_replace(optionMode, '[^a-zA-Z]', '');

    -- -- Multi space to single space
    -- optionMode := regexp_replace(optionMode, '[ ]{2,}', ' ');

    -- Check if empty string
    if optionMode = '' then
      -- Set parameter to null if empty string
      optionMode := nullif(optionMode, '');
    end if;

    -- Set character limit
    optionMode := substring(optionMode, 1, 255);

    -- Omit characters
    title := regexp_replace(title, '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' ');

    -- Multi space to single space
    title := regexp_replace(title, '[ ]{2,}', ' ');

    -- Check if empty string
    if title = '' then
      -- Set parameter to null if empty string
      title := nullif(title, '');
    end if;

    -- Set character limit
    title := substring(title, 1, 255);

    -- Omit characters
    imageurl := regexp_replace(imageurl, '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' ');

    -- Multi space to single space
    imageurl := regexp_replace(imageurl, '[ ]{2,}', ' ');

    -- Check if empty string
    if imageurl = '' then
      -- Set parameter to null if empty string
      imageurl := nullif(imageurl, '');
    end if;

    -- Set character limit
    imageurl := substring(imageurl, 1, 255);

    -- Omit characters
    feedurl := regexp_replace(feedurl, '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' ');

    -- Multi space to single space
    feedurl := regexp_replace(feedurl, '[ ]{2,}', ' ');

    -- Check if empty string
    if feedurl = '' then
      -- Set parameter to null if empty string
      feedurl := nullif(feedurl, '');
    end if;

    -- -- Set character limit
    -- feedurl := substring(feedurl, 1, 255);

    -- Omit characters
    actualurl := regexp_replace(actualurl, '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' ');

    -- Multi space to single space
    actualurl := regexp_replace(actualurl, '[ ]{2,}', ' ');

    -- Check if empty string
    if actualurl = '' then
      -- Set parameter to null if empty string
      actualurl := nullif(actualurl, '');
    end if;

    -- Set character limit
    actualurl := substring(actualurl, 1, 255);

    -- Omit characters
    publishDate := regexp_replace(publishDate, '[^0-9\-: ]', ' ');

    -- Multi space to single space
    publishDate := regexp_replace(publishDate, '[ ]{2,}', ' ');

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
      -- Update records
      update NewsFeed
      set
      imageurl = case when trim(nft.imageurl) = '' then null else trim(nft.imageurl) end,
      feedurl = case when trim(nft.feedurl) = '' then null else trim(nft.feedurl) end,
      actualurl = case when trim(nft.actualurl) = '' then null else trim(nft.actualurl) end,
      publish_date = cast(nft.publish_date as timestamp),
      modified_date = current_timestamp
      from NewsFeedTemp nft
      left join NewsFeed nf on nf.title = nft.title
      where
      (
        nft.title is not null and
        nft.publish_date is not null
      ) and
      (
        cast(nft.publish_date as timestamp) >= current_timestamp + interval '-1 hour' and
        cast(nft.publish_date as timestamp) <= current_timestamp + interval '0 hour'
      ) and
      nf.title is not null;

      -- Select message
      select
      'Success~Record(s) updated' into status;

    -- Else check if option mode is insert bulk news
    elseif optionMode = 'insertBulkNews' then
      -- Insert records
      insert into newsfeed (title, imageurl, feedurl, actualurl, publish_date, created_date, modified_date)

      -- Remove duplicate records based on group by
      with newsDetails as
      (
        -- Select unique records
        select
        distinct
        nft.title as title,
        max(nft.publish_date) as publish_date
        from NewsFeedTemp nft
        group by nft.title
      )

      -- Select records
      select
      distinct
      trim(nft.title),
      case when trim(nft.imageurl) = '' then null else trim(nft.imageurl) end,
      case when trim(nft.feedurl) = '' then null else trim(nft.feedurl) end,
      case when trim(nft.actualurl) = '' then null else trim(nft.actualurl) end,
      cast(nft.publish_date as timestamp),
      current_timestamp,
      current_timestamp
      from newsDetails nd
      join NewsFeedTemp nft on nft.title = nd.title and nft.publish_date = nd.publish_date
      left join NewsFeed nf on nf.title = nft.title
      where
      (
        nft.title is not null and
        nft.publish_date is not null
      ) and
      -- (
        -- cast(nft.publish_date as timestamp) >= current_timestamp + interval '-1 hour' and
        -- cast(nft.publish_date as timestamp) <= current_timestamp + interval '0 hour'
      -- ) and
      nf.title is null;

      -- Select message
      select
      'Success~Record(s) inserted' into status;
    end if;
  end; $$
language plpgsql;