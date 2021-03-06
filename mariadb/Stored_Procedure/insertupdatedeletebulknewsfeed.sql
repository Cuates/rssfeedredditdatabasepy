-- Database Connect
-- use <databasename>;

-- ================================================
--        File: insertupdatedeletebulknewsfeed
--     Created: 09/07/2020
--     Updated: 11/25/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Insert update delete bulk news feed
-- ================================================

-- Procedure Drop
drop procedure if exists insertupdatedeletebulknewsfeed;

-- Procedure Create
delimiter //
create procedure `insertupdatedeletebulknewsfeed`(in optionMode text, in title text, in imageurl text, in feedurl text, in actualurl text, in publishDate text)
  begin
    -- Declare variable
    declare omitOptionMode varchar(255);
    declare omitTitle varchar(255);
    declare omitImageurl varchar(255);
    declare omitFeedurl varchar(255);
    declare omitActualurl varchar(255);
    declare omitPublishDate varchar(255);
    declare maxLengthOptionMode int;
    declare maxLengthTitle int;
    declare maxLengthImageurl int;
    declare maxLengthFeedurl int;
    declare maxLengthActualurl int;
    declare maxLengthPublishDate int;
    declare code varchar(5) default '00000';
    declare msg text;
    declare result text;
    declare successcode varchar(5);

    -- Declare exception handler for failed insert
    declare CONTINUE HANDLER FOR SQLEXCEPTION
      begin
        GET DIAGNOSTICS CONDITION 1
          code = RETURNED_SQLSTATE, msg = MESSAGE_TEXT;
      end;

    -- Set variable
    set omitOptionMode = '[^a-zA-Z]';
    set omitTitle = '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
    set omitImageurl = '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
    set omitFeedurl = '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
    set omitActualurl = '[^a-zA-Z0-9 !"\#$%&\'()*+,\-./:;<=>?@\[\\\]^_‘{|}~¡¢£¥¦§¨©®¯°±´µ¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿıŒœŠšŸŽžƒˆˇ˘˙˚˛ΓΘΣΦΩαδεπστφ–—‘’“”•…€™∂∆∏∑∙√∞∩∫≈≠≡≤≥]';
    set omitPublishDate = '[^0-9\-:./ ]';
    set maxLengthOptionMode = 255;
    set maxLengthTitle = 255;
    set maxLengthImageurl = 255;
    set maxLengthFeedurl = 768;
    set maxLengthActualurl = 255;
    set maxLengthPublishDate = 255;
    set successcode = '00000';

    -- Check if parameter is not null
    if optionMode is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set optionMode = regexp_replace(regexp_replace(optionMode, omitOptionMode, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set optionMode = trim(substring(optionMode, 1, maxLengthOptionMode));

      -- Check if empty string
      if optionMode = '' then
        -- Set parameter to null if empty string
        set optionMode = nullif(optionMode, '');
      end if;
    end if;

    -- Check if parameter is not null
    if title is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set title = regexp_replace(regexp_replace(title, omitTitle, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set title = trim(substring(title, 1, maxLengthTitle));

      -- Check if empty string
      if title = '' then
      -- Set parameter to null if empty string
      set title = nullif(title, '');
      end if;
    end if;

    -- Check if parameter is not null
    if imageurl is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set imageurl = regexp_replace(regexp_replace(imageurl, omitImageurl, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set imageurl = trim(substring(imageurl, 1, maxLengthImageurl));

      -- Check if empty string
      if imageurl = '' then
        -- Set parameter to null if empty string
        set imageurl = nullif(imageurl, '');
      end if;
    end if;

    -- Check if parameter is not null
    if feedurl is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set feedurl = regexp_replace(regexp_replace(feedurl, omitFeedurl, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set feedurl = trim(substring(feedurl, 1, maxLengthFeedurl));

      -- Check if empty string
      if feedurl = '' then
        -- Set parameter to null if empty string
        set feedurl = nullif(feedurl, '');
      end if;
    end if;

    -- Check if parameter is not null
    if actualurl is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set actualurl = regexp_replace(regexp_replace(actualurl, omitActualurl, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set actualurl = trim(substring(actualurl, 1, maxLengthActualurl));

      -- Check if empty string
      if actualurl = '' then
        -- Set parameter to null if empty string
        set actualurl = nullif(actualurl, '');
      end if;
    end if;

    -- Check if parameter is not null
    if publishDate is not null then
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set publishDate = regexp_replace(regexp_replace(publishDate, omitPublishDate, ' '), '[ ]{2,}', ' ');

      -- Set character limit
      set publishDate = trim(substring(publishDate, 1, maxLengthPublishDate));

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
    end if;

    -- Check if option mode is delete temp news
    if optionMode = 'deleteTempNews' then
      -- Start the tranaction
      start transaction;
        -- Delete records
        delete nft
        from newsfeedtemp nft;

        -- Check whether the insert was successful
        if code = successcode then
          -- Commit transactional statement
          commit;

          -- Set message
          set result = concat('{"Status": "Success", "Message": "Record(s) Delete"}');
        else
          -- Rollback to the previous state before the transaction was called
          rollback;

          -- Set message
          set result = concat('{"Status": "Error", "Message": "', msg, '"}');
        end if;

      -- Select message
      select
      result as `status`;

    -- Check if option mode is insert temp news
    elseif optionMode = 'insertTempNews' then
      -- Check if parameters are not null
      if title is not null and publishDate is not null then
        -- Start the tranaction
        start transaction;
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
            title,
            if(imageurl is null or trim(imageurl) = '', null, imageurl),
            feedurl,
            if(actualurl is null or trim(actualurl) = '', null, actualurl),
            publishDate,
            current_timestamp(6)
          );

          -- Check whether the insert was successful
          if code = successcode then
            -- Commit transactional statement
            commit;

            -- Set message
            set result = concat('{"Status": "Success", "Message": "Record(s) inserted"}');
          else
            -- Rollback to the previous state before the transaction was called
            rollback;

            -- Set message
            set result = concat('{"Status": "Error", "Message": "', msg, '"}');
          end if;
      else
        -- Set message
        set result = concat('{"Status": "Error", "Message": "Process halted, title and or publish date were not provided"}');
      end if;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is update bulk news
    elseif optionMode = 'updateBulkNews' then
      -- Create temporary table
      create temporary table if not exists NewsFeedTempTable
      (
        `nfID` bigint(20) default null,
        `title` varchar(255) collate utf8mb4_unicode_520_ci not null,
        `imageurl` varchar(255) collate utf8mb4_unicode_520_ci default null,
        `feedurl` varchar(768) collate utf8mb4_unicode_520_ci not null,
        `actualurl` varchar(255) collate utf8mb4_unicode_520_ci default null,
        `publish_date` datetime(6) not null
      );

      -- Insert records
      insert into NewsFeedTempTable (title, imageurl, feedurl, actualurl, publish_date, nfID)

      -- Remove duplicate records based on group by
      with subNewsDetails as
      (
        -- Select unique records
        select
        trim(substring(regexp_replace(regexp_replace(nft.title, omitTitle, ' '), '[ ]{2,}', ' '), 1, maxLengthTitle)) as `title`,
        trim(substring(regexp_replace(regexp_replace(nft.imageurl, omitImageurl, ' '), '[ ]{2,}', ' '), 1, maxLengthImageurl)) as `imageurl`,
        trim(substring(regexp_replace(regexp_replace(nft.feedurl, omitFeedurl, ' '), '[ ]{2,}', ' '), 1, maxLengthFeedurl)) as `feedurl`,
        trim(substring(regexp_replace(regexp_replace(nft.actualurl, omitActualurl, ' '), '[ ]{2,}', ' '), 1, maxLengthActualurl)) as `actualurl`,
        trim(substring(regexp_replace(regexp_replace(nft.publish_date, omitPublishDate, ' '), '[ ]{2,}', ' '), 1, maxLengthPublishDate)) as `publish_date`
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
          cast(nft.publish_date as datetime) >= date_add(current_timestamp(6), interval -1 hour) and
          cast(nft.publish_date as datetime) <= date_add(current_timestamp(6), interval 0 hour)
        )
        group by nft.title, nft.imageurl, nft.feedurl, nft.actualurl, nft.publish_date
      ),
      newsDetails as
      (
        -- Select unique records
        select
        snd.title as `title`,
        snd.imageurl as `imageurl`,
        snd.feedurl as `feedurl`,
        snd.actualurl as `actualurl`,
        snd.publish_date as `publish_date`,
        nf.nfID as `nfID`
        from subNewsDetails snd
        left join newsfeed nf on nf.title = snd.title
        inner join (select sndii.title, max(sndii.publish_date) as publish_date from subNewsDetails sndii group by sndii.title) as sndi on sndi.title = snd.title and sndi.publish_date = snd.publish_date
        where
        nf.nfID is not null
        group by snd.title, snd.imageurl, snd.feedurl, snd.actualurl, snd.publish_date, nf.nfID
      )

      -- Select records
      select
      nd.title as `title`,
      nd.imageurl as `imageurl`,
      nd.feedurl as `feedurl`,
      nd.actualurl as `actualurl`,
      nd.publish_date as `publish_date`,
      nd.nfID as `nfID`
      from newsDetails nd;

      -- Start the tranaction
      start transaction;
        -- Update records
        update newsfeed nf
        inner join NewsFeedTempTable nftt on nftt.nfID = nf.nfID
        set
        nf.imageurl = if(trim(nftt.imageurl) = '', null, nftt.imageurl),
        nf.feedurl = nftt.feedurl,
        nf.actualurl = if(trim(nftt.actualurl) = '', null, nftt.actualurl),
        nf.publish_date = cast(nftt.publish_date as datetime),
        nf.modified_date = cast(current_timestamp(6) as datetime);

        -- Check whether the insert was successful
        if code = successcode then
          -- Commit transactional statement
          commit;

          -- Set message
          set result = concat('{"Status": "Success", "Message": "Record(s) updated"}');
        else
          -- Rollback to the previous state before the transaction was called
          rollback;

          -- Set message
          set result = concat('{"Status": "Error", "Message": "', msg, '"}');
        end if;

      -- Drop temporary table
      drop temporary table NewsFeedTempTable;

      -- Select message
      select
      result as `status`;

    -- Else check if option mode is insert bulk news
    elseif optionMode = 'insertBulkNews' then
      -- Start the tranaction
      start transaction;
        -- Insert records
        insert into newsfeed (title, imageurl, feedurl, actualurl, publish_date, created_date, modified_date)

        -- Remove duplicate records based on group by
        with subNewsDetails as
        (
          -- Select unique records
          select
          trim(substring(regexp_replace(regexp_replace(nft.title, omitTitle, ' '), '[ ]{2,}', ' '), 1, maxLengthTitle)) as `title`,
          trim(substring(regexp_replace(regexp_replace(nft.imageurl, omitImageurl, ' '), '[ ]{2,}', ' '), 1, maxLengthImageurl)) as `imageurl`,
          trim(substring(regexp_replace(regexp_replace(nft.feedurl, omitFeedurl, ' '), '[ ]{2,}', ' '), 1, maxLengthFeedurl)) as `feedurl`,
          trim(substring(regexp_replace(regexp_replace(nft.actualurl, omitActualurl, ' '), '[ ]{2,}', ' '), 1, maxLengthActualurl)) as `actualurl`,
          trim(substring(regexp_replace(regexp_replace(nft.publish_date, omitPublishDate, ' '), '[ ]{2,}', ' '), 1, maxLengthPublishDate)) as `publish_date`
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
          --   cast(nft.publish_date as datetime) >= date_add(current_timestamp(6), interval -1 hour) and
          --   cast(nft.publish_date as datetime) <= date_add(current_timestamp(6), interval 0 hour)
          -- )
          group by nft.title, nft.imageurl, nft.feedurl, nft.actualurl, nft.publish_date
        ),
        newsDetails as
        (
          -- Select unique records
          select
          snd.title as `title`,
          snd.imageurl as `imageurl`,
          snd.feedurl as `feedurl`,
          snd.actualurl as `actualurl`,
          snd.publish_date as `publish_date`,
          nf.nfID as `nfID`
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
        if(trim(nd.imageurl) = '', null, nd.imageurl),
        nd.feedurl,
        if(trim(nd.actualurl) = '', null, nd.actualurl),
        cast(nd.publish_date as datetime),
        cast(current_timestamp(6) as datetime),
        cast(current_timestamp(6) as datetime)
        from newsDetails nd
        group by nd.title, nd.imageurl, nd.feedurl, nd.actualurl, nd.publish_date;

        -- Check whether the insert was successful
        if code = successcode then
          -- Commit transactional statement
          commit;

          -- Set message
          set result = concat('{"Status": "Success", "Message": "Record(s) inserted"}');
        else
          -- Rollback to the previous state before the transaction was called
          rollback;

          -- Set message
          set result = concat('{"Status": "Error", "Message": "', msg, '"}');
        end if;

      -- Select message
      select
      result as `status`;
    end if;
  end
// delimiter ;