-- Database Connect
\c <databasename>;

-- ================================================
--        File: insertupdatedeletebulknewsfeed
--     Created: 09/07/2020
--     Updated: 11/25/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Insert Update Delete Bulk News Feed
-- ================================================

-- Procedure Drop
drop procedure if exists insertupdatedeletebulknewsfeed;

-- Procedure Create Or Replace
create or replace procedure insertupdatedeletebulknewsfeed(in optionMode text, in title text default null, in imageurl text default null, in feedurl text default null, in actualurl text default null, in publishDate text default null, inout status text default null)
as $$
  -- Declare and set variables
  declare omitOptionMode varchar(255) := '[^a-zA-Z]';
  declare omitTitle varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitImageurl varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitFeedurl varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitActualurl varchar(255) := '[^a-zA-Z0-9 !"\#$%&''()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
  declare omitPublishDate varchar(255) := '[^0-9\-:./ ]';
  declare maxLengthOptionMode int := 255;
  declare maxLengthTitle int := 255;
  declare maxLengthImageurl int := 255;
  declare maxLengthFeedurl int := 768;
  declare maxLengthActualurl int := 255;
  declare maxLengthPublishDate int := 255;
  declare titlestring text := title;
  declare imageurlstring text := imageurl;
  declare feedurlstring text := feedurl;
  declare actualurlstring text := actualurl;
  declare publishdatestring text := publishdate;
  declare code varchar(5) := '00000';
  declare msg text := '';
  declare result text := '';

  begin
    -- Check if parameter is not null
    if optionMode is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      optionMode := regexp_replace(regexp_replace(optionMode, omitOptionMode, ' ', 'g'), '[ ]{2,}', ' ', 'g');

      -- Set character limit
      optionMode := trim(substring(optionMode, 1, maxLengthOptionMode));

      -- Check if empty string
      if optionMode = '' then
        -- Set parameter to null if empty string
        optionMode := nullif(optionMode, '');
      end if;
    end if;

    -- Check if parameter is not null
    if titlestring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      titlestring := regexp_replace(regexp_replace(titlestring, omitTitle, ' ', 'g'), '[ ]{2,}', ' ', 'g');

      -- Set character limit
      titlestring := trim(substring(titlestring, 1, maxLengthTitle));

      -- Check if empty string
      if titlestring = '' then
        -- Set parameter to null if empty string
        titlestring := nullif(titlestring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if imageurlstring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      imageurlstring := regexp_replace(regexp_replace(imageurlstring, omitImageurl, ' ', 'g'), '[ ]{2,}', ' ', 'g');

      -- Set character limit
      imageurlstring := trim(substring(imageurlstring, 1, maxLengthImageurl));

      -- Check if empty string
      if imageurlstring = '' then
        -- Set parameter to null if empty string
        imageurlstring := nullif(imageurlstring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if feedurlstring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      feedurlstring := regexp_replace(regexp_replace(feedurlstring, omitFeedurl, ' ', 'g'), '[ ]{2,}', ' ', 'g');

      -- Set character limit
      feedurlstring := trim(substring(feedurlstring, 1, maxLengthFeedurl));

      -- Check if empty string
      if feedurlstring = '' then
        -- Set parameter to null if empty string
        feedurlstring := nullif(feedurlstring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if actualurlstring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      actualurlstring := regexp_replace(regexp_replace(actualurlstring, omitActualurl, ' ', 'g'), '[ ]{2,}', ' ', 'g');

      -- Set character limit
      actualurlstring := trim(substring(actualurlstring, 1, maxLengthActualurl));

      -- Check if empty string
      if actualurlstring = '' then
        -- Set parameter to null if empty string
        actualurlstring := nullif(actualurlstring, '');
      end if;
    end if;

    -- Check if parameter is not null
    if publishdatestring is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      publishdatestring := regexp_replace(regexp_replace(publishdatestring, omitPublishDate, ' ', 'g'), '[ ]{2,}', ' ', 'g');

      -- Set character limit
      publishdatestring := trim(substring(publishdatestring, 1, maxLengthPublishDate));

      -- Check if the parameter cannot be casted into a date time
      if to_timestamp(publishdatestring, 'YYYY-MM-DD HH24:MI:SS') is null then
        -- Set the string as empty to be nulled below
        publishdatestring := '';
      end if;

      -- Check if empty string
      if publishdatestring = '' then
        -- Set parameter to null if empty string
        publishdatestring := nullif(publishdatestring, '');
      end if;
    end if;

    -- Check if option mode is delete temp news
    if optionMode = 'deleteTempNews' then
      -- Begin begin/except
      begin
        -- Delete records
        delete
        from newsfeedtemp;

        -- Set message
        result := concat('{"Status": "Success", "Message": "Record(s) deleted"}');
      exception when others then
        -- Caught exception error
        -- Get diagnostics information
        get stacked diagnostics code = returned_sqlstate, msg = message_text;

        -- Set message
        result := concat('{"Status": "Error", "Message": "', msg, '"}');
      -- End begin/except
      end;

      -- Select message
      select
      result into "status";

    -- Check if option mode is insert temp news
    elseif optionMode = 'insertTempNews' then
      -- Check if parameters are not null
      if titlestring is not null and publishdatestring is not null then
        -- Begin begin/except
        begin
          -- Insert record
          insert into newsfeedtemp
          (
            title,
            imageurl,
            feedurl,
            actualurl,
            publish_date,
            created_date
          )
          values
          (
            titlestring,
            case
              when imageurlstring is null or trim(imageurlstring) = ''
                then
                  null
              else
                imageurlstring
            end,
            feedurlstring,
            case
              when actualurlstring is null or trim(actualurlstring) = ''
                then
                  null
              else
                actualurlstring
            end,
            publishdatestring,
            cast(current_timestamp as timestamp)
          );

          -- Set message
          result := concat('{"Status": "Success", "Message": "Record(s) inserted"}');
        exception when others then
          -- Caught exception error
          -- Get diagnostics information
          get stacked diagnostics code = returned_sqlstate, msg = message_text;

          -- Set message
          result := concat('{"Status": "Error", "Message": "', msg, '"}');
        -- End begin/except
        end;
      else
        -- Else a parameter was not given
        -- Set message
        result := concat('{"Status": "Error", "Message": "Process halted, title and or publish date were not provided"}');
      end if;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is update bulk news
    elseif optionMode = 'updateBulkNews' then
      -- Begin begin/except
      begin
        -- Remove duplicate records based on group by
        with subNewsDetails as
        (
          -- Select unique records
          select
          cast(trim(substring(regexp_replace(regexp_replace(nft.title, omitTitle, ' ', 'g'), '[ ]{2,}', ' ', 'g'), 1, maxLengthTitle)) as citext) as title,
          cast(trim(substring(regexp_replace(regexp_replace(nft.imageurl, omitImageurl, ' ', 'g'), '[ ]{2,}', ' ', 'g'), 1, maxLengthImageurl)) as citext) as imageurl,
          cast(trim(substring(regexp_replace(regexp_replace(nft.feedurl, omitFeedurl, ' ', 'g'), '[ ]{2,}', ' ', 'g'), 1, maxLengthFeedurl)) as citext) as feedurl,
          cast(trim(substring(regexp_replace(regexp_replace(nft.actualurl, omitActualurl, ' ', 'g'), '[ ]{2,}', ' ', 'g'), 1, maxLengthActualurl)) as citext) as actualurl,
          trim(substring(regexp_replace(regexp_replace(nft.publish_date, omitPublishDate, ' ', 'g'), '[ ]{2,}', ' ', 'g'), 1, maxLengthPublishDate)) as publish_date
          from newsfeedtemp nft
          where
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
          group by nft.title, nft.imageurl, nft.feedurl, nft.actualurl, nft.publish_date
        ),
        newsDetails as
        (
          -- Select unique records
          select
          snd.title as title,
          snd.imageurl as imageurl,
          snd.feedurl as feedurl,
          snd.actualurl as actualurl,
          snd.publish_date as publish_date,
          nf.nfID as nfID
          from subNewsDetails snd
          left join newsfeed nf on nf.title = snd.title
          inner join (select sndii.title, max(sndii.publish_date) as publish_date from subNewsDetails sndii group by sndii.title) as sndi on sndi.title = snd.title and sndi.publish_date = snd.publish_date
          where
          nf.nfID is not null
          group by snd.title, snd.imageurl, snd.feedurl, snd.actualurl, snd.publish_date, nf.nfID
        )

        -- Update records
        update newsfeed
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
        publish_date = cast(nd.publish_date as timestamp),
        modified_date = cast(current_timestamp as timestamp)
        from newsDetails nd
        where
        nd.nfID = newsfeed.nfID;

        -- Set message
        result := concat('{"Status": "Success", "Message": "Record(s) updated"}');
      exception when others then
        -- Caught exception error
        -- Get diagnostics information
        get stacked diagnostics code = returned_sqlstate, msg = message_text;

        -- Set message
        result := concat('{"Status": "Error", "Message": "', msg, '"}');
      -- End begin/except
      end;

      -- Select message
      select
      result into "status";

    -- Else check if option mode is insert bulk news
    elseif optionMode = 'insertBulkNews' then
      -- Begin begin/except
      begin
        -- Insert records
        insert into newsfeed
        (
          title,
          imageurl,
          feedurl,
          actualurl,
          publish_date,
          created_date,
          modified_date
        )

        -- Remove duplicate records based on group by
        with subNewsDetails as
        (
          -- Select unique records
          select
          cast(trim(substring(regexp_replace(regexp_replace(nft.title, omitTitle, ' ', 'g'), '[ ]{2,}', ' ', 'g'), 1, maxLengthTitle)) as citext) as title,
          cast(trim(substring(regexp_replace(regexp_replace(nft.imageurl, omitImageurl, ' ', 'g'), '[ ]{2,}', ' ', 'g'), 1, maxLengthImageurl)) as citext) as imageurl,
          cast(trim(substring(regexp_replace(regexp_replace(nft.feedurl, omitFeedurl, ' ', 'g'), '[ ]{2,}', ' ', 'g'), 1, maxLengthFeedurl)) as citext) as feedurl,
          cast(trim(substring(regexp_replace(regexp_replace(nft.actualurl, omitActualurl, ' ', 'g'), '[ ]{2,}', ' ', 'g'), 1, maxLengthActualurl)) as citext) as actualurl,
          trim(substring(regexp_replace(regexp_replace(nft.publish_date, omitPublishDate, ' ', 'g'), '[ ]{2,}', ' ', 'g'), 1, maxLengthPublishDate)) as publish_date
          from newsfeedtemp nft
          where
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
          group by nft.title, nft.imageurl, nft.feedurl, nft.actualurl, nft.publish_date
        ),
        newsDetails as
        (
          -- Select unique records
          select
          snd.title as title,
          snd.imageurl as imageurl,
          snd.feedurl as feedurl,
          snd.actualurl as actualurl,
          snd.publish_date as publish_date,
          nf.nfID as nfID
          from subNewsDetails snd
          left join newsfeed nf on nf.title = snd.title
          inner join (select sndii.title, max(sndii.publish_date) as publish_date from subNewsDetails sndii group by sndii.title) as sndi on sndi.title = snd.title and sndi.publish_date = snd.publish_date
          where
          nf.nfID is null
          group by snd.title, snd.imageurl, snd.feedurl, snd.actualurl, snd.publish_date, nf.nfID
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
        cast(nd.publish_date as timestamp),
        cast(current_timestamp as timestamp),
        cast(current_timestamp as timestamp)
        from newsDetails nd
        group by nd.title, nd.imageurl, nd.feedurl, nd.actualurl, nd.publish_date;

        -- Set message
        result := concat('{"Status": "Success", "Message": "Record(s) inserted"}');
      exception when others then
        -- Caught exception error
        -- Get diagnostics information
        get stacked diagnostics code = returned_sqlstate, msg = message_text;

        -- Set message
        result := concat('{"Status": "Error", "Message": "', msg, '"}');
      -- End begin/except
      end;

      -- Select message
      select
      result into "status";
    end if;
  end; $$
language plpgsql;