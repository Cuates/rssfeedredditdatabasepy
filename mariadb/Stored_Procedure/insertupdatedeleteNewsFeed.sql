-- Database Connect
use <databasename>;

-- Procedure Drop
drop procedure if exists insertupdatedeleteNewsFeed;

-- Procedure Create
delimiter //
create procedure `insertupdatedeleteNewsFeed`(in optionMode text, in title text, in imageurl text, in feedurl text, in actualurl text, in publishDate text)
  begin
    -- Omit characters
    set optionMode = regexp_replace(optionMode, '[^a-zA-Z]', '');

    -- -- Multi space to single space
    -- optionMode := regexp_replace(optionMode, '[ ]{2,}', ' ');

    -- Check if empty string
    if optionMode = '' then
      -- Set parameter to null if empty string
      set optionMode = nullif(optionMode, '');
    end if;

    -- Set character limit
    set optionMode = substring(optionMode, 1, 255);

    -- Omit characters
    set title = regexp_replace(title, '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' ');

    -- Multi space to single space
    set title = regexp_replace(title, '[ ]{2,}', ' ');

    -- Check if empty string
    if title = '' then
      -- Set parameter to null if empty string
      set title = nullif(title, '');
    end if;

    -- Set character limit
    set title = substring(title, 1, 255);

    -- Omit characters
    set imageurl = regexp_replace(imageurl, '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' ');

    -- Multi space to single space
    set imageurl = regexp_replace(imageurl, '[ ]{2,}', ' ');

    -- Check if empty string
    if imageurl = '' then
      -- Set parameter to null if empty string
      set imageurl = nullif(imageurl, '');
    end if;

    -- Set character limit
    set imageurl = substring(imageurl, 1, 255);

    -- Omit characters
    set feedurl = regexp_replace(feedurl, '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' ');

    -- Multi space to single space
    set feedurl = regexp_replace(feedurl, '[ ]{2,}', ' ');

    -- Check if empty string
    if feedurl = '' then
      -- Set parameter to null if empty string
      set feedurl = nullif(feedurl, '');
    end if;

    -- -- Set character limit
    -- set feedurl = substring(feedurl, 1, 255);

    -- Omit characters
    set actualurl = regexp_replace(actualurl, '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]', ' ');

    -- Multi space to single space
    set actualurl = regexp_replace(actualurl, '[ ]{2,}', ' ');

    -- Check if empty string
    if actualurl = '' then
      -- Set parameter to null if empty string
      set actualurl = nullif(actualurl, '');
    end if;

    -- Set character limit
    set actualurl = substring(actualurl, 1, 255);

    -- Omit characters
    set publishDate = regexp_replace(publishDate, '[^0-9\-: ]', ' ');

    -- Multi space to single space
    set publishDate = regexp_replace(publishDate, '[ ]{2,}', ' ');

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
      -- Check if parameters are null
      if title is not null and publishDate is not null then
        -- Insert record
        insert into NewsFeedTemp(title, imageurl, feedurl, actualurl, publish_date, created_date) values (title, imageurl, feedurl, actualurl, publishDate, current_timestamp());

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
      -- Update records
      update NewsFeed nf
      left join NewsFeed nft on nft.title = nf.title
      set
      nf.imageurl = if(ltrim(rtrim(nft.imageurl)) = '', null, ltrim(rtrim(nft.imageurl))),
      nf.feedurl = if(ltrim(rtrim(nft.feedurl)) = '', null, ltrim(rtrim(nft.feedurl))),
      nf.actualurl = if(ltrim(rtrim(nft.actualurl)) = '', null, ltrim(rtrim(nft.actualurl))),
      nf.publish_date = cast(nft.publish_date as datetime),
      nf.modified_date = current_timestamp()
      where
      (
        nft.title is not null and
        nft.publish_date is not null
      ) and
      (
        nft.publish_date >= date_add(current_timestamp(), interval -1 hour) and
        nft.publish_date <= date_add(current_timestamp(), interval 0 hour)
      ) and
      nf.title is not null;

      -- Select message
      select
      'Success~Record(s) updated' as `status`;

    -- Else check if option mode is insert bulk news
    elseif optionMode = 'insertBulkNews' then
      -- Insert records
      insert into NewsFeed (title, imageurl, feedurl, actualurl, publish_date, created_date, modified_date)

      -- Remove duplicate records based on group by
      with newsDetails as
      (
        -- Select unique records
        select
        distinct
        nft.title as `title`,
        max(nft.publish_date) as `publish_date`
        from NewsFeedTemp nft
        group by nft.title
      )

      -- Select records
      select
      distinct
      ltrim(rtrim(nft.title)),
      if(ltrim(rtrim(nft.imageurl)) = '', null, ltrim(rtrim(nft.imageurl))),
      if(ltrim(rtrim(nft.feedurl)) = '', null, ltrim(rtrim(nft.feedurl))),
      if(ltrim(rtrim(nft.actualurl)) = '', null, ltrim(rtrim(nft.actualurl))),
      cast(nft.publish_date as datetime),
      current_timestamp(),
      current_timestamp()
      from newsDetails nd
      join NewsFeedTemp nft on nft.title = nd.title and nft.publish_date = nd.publish_date
      left join NewsFeed nf on nf.title = nft.title
      where
      (
        nft.title is not null and
        nft.publish_date is not null
      ) and
      -- (
        -- nft.publish_date >= date_add(current_timestamp(), interval -1 hour) and
        -- nft.publish_date <= date_add(current_timestamp(), interval 0 hour)
      -- ) and
      nf.title is null;

      -- Select message
      select
      'Success~Record(s) inserted' as `status`;
    end if;
  end
// delimiter ;