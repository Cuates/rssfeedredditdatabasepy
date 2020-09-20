USE [Media]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================
--        File: News_Interaction
--     Created: 09/07/2020
--     Updated: 09/20/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: News interaction
-- =============================
CREATE procedure [dbo].[News_Interaction]
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

	-- Declare variables
	declare @attempts as smallint

	-- Set variables
	set @attempts = 1

	-- Omit characters
	set @optionMode = dbo.OmitCharacters(@optionMode, '48,49,50,51,52,53,54,55,56,57,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122')

	-- Check if empty string
	if @optionMode = ''
		begin
			-- Set parameter to null if empty string
			set @optionMode = nullif(@optionMode, '')
		end

  -- Set character limit
  set @optionMode = substring(@optionMode, 1, 255);

	-- Omit characters
	set @title = dbo.OmitCharacters(@title, '32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,168,169,173,181,182,183,184,189,190,198,199,208,209,210,211,212,213,214,215,216,221,222,224,225,226,227,228,229,230,231,232,233,234,235,236,237,239,241,246,248,249')

	-- Check if empty string
	if @title = ''
		begin
			-- Set parameter to null if empty string
			set @title = nullif(@title, '')
		end

  -- Set character limit
  set @title = substring(@title, 1, 255);

	-- Omit characters
	set @imageurl = dbo.OmitCharacters(@imageurl, '32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,168,169,173,181,182,183,184,189,190,198,199,208,209,210,211,212,213,214,215,216,221,222,224,225,226,227,228,229,230,231,232,233,234,235,236,237,239,241,246,248,249')

	-- Check if empty string
	if @imageurl = ''
		begin
			-- Set parameter to null if empty string
			set @imageurl = nullif(@imageurl, '')
		end

  -- Set character limit
  set @imageurl = substring(@imageurl, 1, 255);

	-- Omit characters
	set @feedurl = dbo.OmitCharacters(@feedurl, '32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,168,169,173,181,182,183,184,189,190,198,199,208,209,210,211,212,213,214,215,216,221,222,224,225,226,227,228,229,230,231,232,233,234,235,236,237,239,241,246,248,249')

	-- Check if empty string
	if @feedurl = ''
		begin
			-- Set parameter to null if empty string
			set @feedurl = nullif(@feedurl, '')
		end

  ---- Set character limit
  --set @feedurl = substring(@feedurl, 1, 255);

	-- Omit characters
	set @actualurl = dbo.OmitCharacters(@actualurl, '32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,168,169,173,181,182,183,184,189,190,198,199,208,209,210,211,212,213,214,215,216,221,222,224,225,226,227,228,229,230,231,232,233,234,235,236,237,239,241,246,248,249')

	-- Check if empty string
	if @actualurl = ''
		begin
			-- Set parameter to null if empty string
			set @actualurl = nullif(@actualurl, '')
		end

  -- Set character limit
  set @actualurl = substring(@actualurl, 1, 255);

	-- Omit characters
	set @publishDate = dbo.OmitCharacters(@publishDate, '32,45,47,48,49,50,51,52,53,54,55,56,57,58')

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
  set @publishDate = substring(@publishDate, 1, 255);

  -- Check if option mode is extract news feed
  if @optionMode = 'extractNewsFeed'
    begin
      -- Select records
      select
      ltrim(rtrim(nf.title)) as [Title],
      ltrim(rtrim(nf.imageurl)) as [Image URL],
      ltrim(rtrim(nf.feedurl)) as [Feed URL],
      ltrim(rtrim(nf.actualurl)) as [Actual URL],
      format(cast(nf.publish_date as datetime2(7)), 'yyy-MM-dd HH:mm:ss', 'en-us') as [Publish Date]
      from dbo.NewsFeed nf
      where
      nf.title = @title
    end

	-- Else check if option mode is delete temp news
	else if @optionMode = 'deleteTempNews'
		begin
			-- Loop until condition is met
			while @attempts <= 5
				begin
					-- Begin the tranaction
					begin tran
						-- Begin the try block
						begin try
							-- Delete records
							delete from dbo.NewsFeedTemp

							-- Select message
							select
							'Success~Record(s) deleted' as [Status]

							-- Check if there is trans count
							if @@trancount > 0
								begin
									-- Commit transactional statement
									commit tran
								end

							-- Break out of the loop
							break
						end try
						-- End try block
						-- Begin catch block
						begin catch
							-- Only display an error message if it is on the final attempt of the execution
							if @attempts = 5
								begin
									-- Select error number, line, and message
									select
									'Error~deleteTempNews: Error Number: ' + cast(error_number() as nvarchar) + ' Error Line: ' + cast(error_line() as nvarchar) + ' Error Message: ' + error_message() as [Status]
								end

							-- Check if there is trans count
							if @@trancount > 0
								begin
									-- Rollback to the previous state before the transaction was called
									rollback
								end

							-- Increments the loop control for attempts
							set @attempts = @attempts + 1

							-- Wait for delay for x amount of time
							waitfor delay '00:00:04'

							-- Continue the loop
							continue
						end catch
						-- End catch block
				end
		end

	-- Else check if option mode is insert temp news
	else if @optionMode = 'insertTempNews'
		begin
      -- Check if parameters are null
      if @title is null or @publishDate is null
        begin
          -- Select message
          select
          'Error~Process halted, title and or publish date were not provided' as [Status]
        end
      else
        begin
			    -- Loop until condition is met
			    while @attempts <= 5
				    begin
					    -- Begin the tranaction
					    begin tran
						    -- Begin the try block
						    begin try
                  -- Insert record
                  insert into dbo.NewsFeedTemp(title, imageurl, feedurl, actualurl, publish_date, created_date) values (@title, @imageurl, @feedurl, @actualurl, @publishDate, getdate())

							    -- Select message
							    select
							    'Success~Record(s) inserted' as [Status]

							    -- Check if there is trans count
							    if @@trancount > 0
								    begin
									    -- Commit transactional statement
									    commit tran
								    end

							    -- Break out of the loop
							    break
						    end try
						    -- End try block
						    -- Begin catch block
						    begin catch
							    -- Only display an error message if it is on the final attempt of the execution
							    if @attempts = 5
								    begin
									    -- Select error number, line, and message
									    select
									    'Error~insertTempNews: Error Number: ' + cast(error_number() as nvarchar) + ' Error Line: ' + cast(error_line() as nvarchar) + ' Error Message: ' + error_message() as [Status]
								    end

							    -- Check if there is trans count
							    if @@trancount > 0
								    begin
									    -- Rollback to the previous state before the transaction was called
									    rollback
								    end

							    -- Increments the loop control for attempts
							    set @attempts = @attempts + 1

							    -- Wait for delay for x amount of time
							    waitfor delay '00:00:04'

							    -- Continue the loop
							    continue
						    end catch
						    -- End catch block
				    end
        end
		end

  -- Else check if option mode is update bulk news
  else if @optionMode = 'updateBulkNews'
    begin
      -- Loop until condition is met
      while @attempts <= 5
        begin
          -- Begin the tranaction
          begin tran
            -- Begin the try block
            begin try
              -- Update records
              update nf
              set
              nf.imageurl = iif(ltrim(rtrim(nft.imageurl)) = '', null, ltrim(rtrim(nft.imageurl))),
              nf.feedurl = iif(ltrim(rtrim(nft.feedurl)) = '', null, ltrim(rtrim(nft.feedurl))),
              nf.actualurl = iif(ltrim(rtrim(nft.actualurl)) = '', null, ltrim(rtrim(nft.actualurl))),
              nf.publish_date = cast(nft.publish_date as datetime2(7)),
              nf.modified_date = getdate()
              from dbo.NewsFeedTemp nft
              left join dbo.NewsFeed nf on nf.title = nft.title
              where
              (
                ltrim(rtrim(nft.title)) <> '' and
                ltrim(rtrim(nft.publish_date)) <> ''
              ) and
              (
                nft.publish_date >= dateadd(hour, -1, getdate()) and
                nft.publish_date <= dateadd(hour, 0, getdate())
              ) and
              nf.title is not null

              -- Select message
              select
              'Success~Record(s) updated' as [Status]

              -- Check if there is trans count
              if @@trancount > 0
                begin
                  -- Commit transactional statement
                  commit tran
                end

              -- Break out of the loop
              break
            end try
            -- End try block
            -- Begin catch block
            begin catch
              -- Only display an error message if it is on the final attempt of the execution
              if @attempts = 5
                begin
                  -- Select error number, line, and message
                  select 'Error~updateBulkNews: Error Number: ' + cast(error_number() as nvarchar) + ' Error Line: ' + cast(error_line() as nvarchar) + ' Error Message: ' + error_message() as [Status]
                end

              -- Check if there is trans count
              if @@trancount > 0
                begin
                  -- Rollback to the previous state before the transaction was called
                  rollback
                end

              -- Increments the loop control for attempts
              set @attempts = @attempts + 1

              -- Wait for delay for x amount of time
              waitfor delay '00:00:04'

              -- Continue the loop
              continue
            end catch
        end
    end

  -- Else check if option mode is insert bulk news
  else if @optionMode = 'insertBulkNews'
    begin
      -- Loop until condition is met
      while @attempts <= 5
        begin
          -- Begin the tranaction
          begin tran
            -- Begin the try block
            begin try
              -- Remove duplicate records based on group by
              ;with newsDetails as
              (
                -- Select unique records
                select
                distinct
                nft.title as [title],
                max(nft.publish_date) as [publish_date]
                from dbo.NewsFeedTemp nft
                group by nft.title
              )

              -- Insert records
              insert into dbo.NewsFeed(title, imageurl, feedurl, actualurl, publish_date, created_date, modified_date)
              select
              distinct
              ltrim(rtrim(nft.title)),
              iif(ltrim(rtrim(nft.imageurl)) = '', null, ltrim(rtrim(nft.imageurl))),
              iif(ltrim(rtrim(nft.feedurl)) = '', null, ltrim(rtrim(nft.feedurl))),
              iif(ltrim(rtrim(nft.actualurl)) = '', null, ltrim(rtrim(nft.actualurl))),
              cast(nft.publish_date as datetime2(7)),
              getdate(),
              getdate()
              from newsDetails nd
              join dbo.NewsFeedTemp nft on nft.title = nd.title and nft.publish_date = nd.publish_date
              left join dbo.NewsFeed nf on nf.title = nft.title
              where
              (
                ltrim(rtrim(nft.title)) <> '' and
                ltrim(rtrim(nft.publish_date)) <> ''
              ) and
              --(
              --  nft.publish_date >= dateadd(hour, -1, getdate()) and
              --  nft.publish_date <= dateadd(hour, 0, getdate())
              --) and
              nf.title is null

              -- Select message
              select
              'Success~Record(s) inserted' as [Status]

              -- Check if there is trans count
              if @@trancount > 0
                begin
                  -- Commit transactional statement
                  commit tran
                end

              -- Break out of the loop
              break
            end try
            -- End try block
            -- Begin catch block
            begin catch
              -- Only display an error message if it is on the final attempt of the execution
              if @attempts = 5
                begin
                  -- Select error number, line, and message
                  select 'Error~insertBulkNews: Error Number: ' + cast(error_number() as nvarchar) + ' Error Line: ' + cast(error_line() as nvarchar) + ' Error Message: ' + error_message() as [Status]
                end

              -- Check if there is trans count
              if @@trancount > 0
                begin
                  -- Rollback to the previous state before the transaction was called
                  rollback
                end

              -- Increments the loop control for attempts
              set @attempts = @attempts + 1

              -- Wait for delay for x amount of time
              waitfor delay '00:00:04'

              -- Continue the loop
              continue
            end catch
        end
    end
end
GO
