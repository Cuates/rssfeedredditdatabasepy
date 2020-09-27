use [Media]
go

set ansi_nulls on
go

set quoted_identifier on
go

-- ===========================================
--        File: insertupdatedeleteNewsFeed
--     Created: 09/07/2020
--     Updated: 09/27/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Insert Update Delete News Feed
-- ===========================================
create procedure [dbo].[insertupdatedeleteNewsFeed]
  -- Add the parameters for the stored procedure here
  @optionMode nvarchar(max),
  @title nvarchar(max) = null,
  @imageurl nvarchar(max) = null,
  @feedurl nvarchar(max) = null,
  @actualurl nvarchar(max) = null,
  @publishDate nvarchar(max) = null
as
begin
  -- Set nocount on added to prevent extra result sets from interfering with select statements
  set nocount on

  -- Omit characters, multi space to single space, and trim leading and trailing spaces
  set @optionMode = trim(replace(dbo.OmitCharacters(@optionMode, '48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122'), '  ', ''))

  -- Check if empty string
  if @optionMode = ''
    begin
      -- Set parameter to null if empty string
      set @optionMode = nullif(@optionMode, '')
    end

  -- Set character limit
  set @optionMode = substring(@optionMode, 1, 255)

  -- Omit characters, multi space to single space, and trim leading and trailing spaces
  set @title = trim(replace(dbo.OmitCharacters(@title, '32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,168,169,173,181,182,183,184,189,190,198,199,208,209,210,211,212,213,214,215,216,221,222,224,225,226,227,228,229,230,231,232,233,234,235,236,237,239,241,246,248,249'), '  ', ''))

  -- Check if empty string
  if @title = ''
    begin
      -- Set parameter to null if empty string
      set @title = nullif(@title, '')
    end

  -- Set character limit
  set @title = substring(@title, 1, 255)

  -- Omit characters, multi space to single space, and trim leading and trailing spaces
  set @imageurl = trim(replace(dbo.OmitCharacters(@imageurl, '32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,168,169,173,181,182,183,184,189,190,198,199,208,209,210,211,212,213,214,215,216,221,222,224,225,226,227,228,229,230,231,232,233,234,235,236,237,239,241,246,248,249'), '  ', ''))

  -- Check if empty string
  if @imageurl = ''
    begin
      -- Set parameter to null if empty string
      set @imageurl = nullif(@imageurl, '')
    end

  -- Set character limit
  set @imageurl = substring(@imageurl, 1, 255)

  -- Omit characters, multi space to single space, and trim leading and trailing spaces
  set @feedurl = trim(replace(dbo.OmitCharacters(@feedurl, '32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,168,169,173,181,182,183,184,189,190,198,199,208,209,210,211,212,213,214,215,216,221,222,224,225,226,227,228,229,230,231,232,233,234,235,236,237,239,241,246,248,249'), '  ', ''))

  -- Check if empty string
  if @feedurl = ''
    begin
      -- Set parameter to null if empty string
      set @feedurl = nullif(@feedurl, '')
    end

  -- Set character limit
  set @feedurl = substring(@feedurl, 1, 768)

  -- Omit characters, multi space to single space, and trim leading and trailing spaces
  set @actualurl = trim(replace(dbo.OmitCharacters(@actualurl, '32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,168,169,173,181,182,183,184,189,190,198,199,208,209,210,211,212,213,214,215,216,221,222,224,225,226,227,228,229,230,231,232,233,234,235,236,237,239,241,246,248,249'), '  ', ''))

  -- Check if empty string
  if @actualurl = ''
    begin
      -- Set parameter to null if empty string
      set @actualurl = nullif(@actualurl, '')
    end

  -- Set character limit
  set @actualurl = substring(@actualurl, 1, 255)

  -- Omit characters, multi space to single space, and trim leading and trailing spaces
  set @publishDate = trim(replace(dbo.OmitCharacters(@publishDate, '32,45,47,48,49,50,51,52,53,54,55,56,57,58'), '  ', ''))

  -- Check if the parameter cannot be casted into a date time
  if try_cast(@publishDate as datetime2(7)) is null
    begin
      -- Set the string as empty to be nulled below
      set @publishDate = ''
    end

  -- Check if empty string
  if @publishDate = ''
    begin
      -- Set parameter to null if empty string
      set @publishDate = nullif(@publishDate, '')
    end

  -- Set character limit
  set @publishDate = substring(@publishDate, 1, 255)

  -- Check if option mode is delete temp news
  if @optionMode = 'deleteTempNews'
    begin
      -- Begin the tranaction
      begin tran
        -- Begin the try block
        begin try
          -- Delete records
          delete from dbo.NewsFeedTemp

          -- Select message
          select
          'Success~Record(s) deleted' as [status]

          -- Check if there is trans count
          if @@trancount > 0
            begin
              -- Commit transactional statement
              commit tran
            end
        end try
        -- End try block
        -- Begin catch block
        begin catch
          -- Select error number, line, and message
          select
          'Error~deleteTempNews: Error Number: ' + cast(error_number() as nvarchar) + ' Error Line: ' + cast(error_line() as nvarchar) + ' Error Message: ' + error_message() as [status]

          -- Check if there is trans count
          if @@trancount > 0
            begin
              -- Rollback to the previous state before the transaction was called
              rollback
            end
        end catch
        -- End catch block
    end

  -- Else check if option mode is insert temp news
  else if @optionMode = 'insertTempNews'
    begin
      -- Check if parameters are not null
      if @title is not null and @publishDate is not null
        begin
          -- Begin the tranaction
          begin tran
            -- Begin the try block
            begin try
              -- Insert record
              insert into dbo.NewsFeedTemp(title, imageurl, feedurl, actualurl, publish_date, created_date) values (@title, @imageurl, @feedurl, @actualurl, @publishDate, getdate())

              -- Select message
              select
              'Success~Record(s) inserted' as [status]

              -- Check if there is trans count
              if @@trancount > 0
                begin
                  -- Commit transactional statement
                  commit tran
                end
            end try
            -- End try block
            -- Begin catch block
            begin catch
              -- Select error number, line, and message
              select
              'Error~insertTempNews: Error Number: ' + cast(error_number() as nvarchar) + ' Error Line: ' + cast(error_line() as nvarchar) + ' Error Message: ' + error_message() as [status]

              -- Check if there is trans count
              if @@trancount > 0
                begin
                  -- Rollback to the previous state before the transaction was called
                  rollback
                end
            end catch
            -- End catch block
        end
      else
        begin
          -- Select message
          select
          'Error~Process halted, title and or publish date were not provided' as [Status]
        end
    end

  -- Else check if option mode is update bulk news
  else if @optionMode = 'updateBulkNews'
    begin
      -- Begin the tranaction
      begin tran
        -- Begin the try block
        begin try
          -- Remove duplicate records based on group by
          ;with subNewsDetails as
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
            from dbo.NewsFeedTemp nft
            left join dbo.NewsFeed nf on nf.feedurl = nft.feedurl
            where
            (
              nft.title is not null and
              nft.feedurl is not null and
              nft.publish_date is not null
            ) -- and
            -- (
            --   cast(nft.publish_date as datetime2(7)) >= dateadd(hour, -1, getdate()) and
            --   cast(nft.publish_date as datetime2(7)) <= dateadd(hour, 0, getdate())
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
          update nf
          set
          nf.imageurl = iif(trim(nd.imageurl) = '', null, trim(nd.imageurl)),
          nf.feedurl = nd.feedurl,
          nf.actualurl = iif(trim(nd.actualurl) = '', null, trim(nd.actualurl)),
          nf.publish_date = cast(nd.publishdate as datetime2(7)),
          nf.modified_date = cast(getdate() as datetime2(7))
          from newsDetails nd
          join dbo.NewsFeed nf on nf.nfID = nd.nfID

          -- Select message
          select
          'Success~Record(s) updated' as [status]

          -- Check if there is trans count
          if @@trancount > 0
            begin
              -- Commit transactional statement
              commit tran
            end
        end try
        -- End try block
        -- Begin catch block
        begin catch
          -- Select error number, line, and message
          select
          'Error~updateBulkNews: Error Number: ' + cast(error_number() as nvarchar) + ' Error Line: ' + cast(error_line() as nvarchar) + ' Error Message: ' + error_message() as [status]

          -- Check if there is trans count
          if @@trancount > 0
            begin
              -- Rollback to the previous state before the transaction was called
              rollback
            end
        end catch
    end

  -- Else check if option mode is insert bulk news
  else if @optionMode = 'insertBulkNews'
    begin
      -- Begin the tranaction
      begin tran
        -- Begin the try block
        begin try
          -- Remove duplicate records based on group by
          ;with subNewsDetails as
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
            from dbo.NewsFeedTemp nft
            left join dbo.NewsFeed nf on nf.feedurl = nft.feedurl
            where
            (
              nft.title is not null and
              nft.feedurl is not null and
              nft.publish_date is not null
            ) -- and
            -- (
            --   cast(nft.publish_date as datetime2(7)) >= dateadd(hour, -1, getdate()) and
            --   cast(nft.publish_date as datetime2(7)) <= dateadd(hour, 0, getdate())
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

          -- Insert records
          insert into dbo.NewsFeed(title, imageurl, feedurl, actualurl, publish_date, created_date, modified_date)
          select
          nd.title,
          iif(trim(nd.imageurl) = '', null, trim(nd.imageurl)),
          nd.feedurl,
          iif(trim(nd.actualurl) = '', null, trim(nd.actualurl)),
          cast(nd.publishdate as datetime2(7)),
          getdate(),
          getdate()
          from newsDetails nd
          left join dbo.NewsFeed nf on nf.title = nd.title
          where
          nf.title is null
          group by nd.title, nd.imageurl, nd.feedurl, nd.actualurl, nd.publishdate

          -- Select message
          select
          'Success~Record(s) inserted' as [Status]

          -- Check if there is trans count
          if @@trancount > 0
            begin
              -- Commit transactional statement
              commit tran
            end
        end try
        -- End try block
        -- Begin catch block
        begin catch
          -- Select error number, line, and message
          select 'Error~insertBulkNews: Error Number: ' + cast(error_number() as nvarchar) + ' Error Line: ' + cast(error_line() as nvarchar) + ' Error Message: ' + error_message() as [Status]

          -- Check if there is trans count
          if @@trancount > 0
            begin
              -- Rollback to the previous state before the transaction was called
              rollback
            end
        end catch
    end
end
go