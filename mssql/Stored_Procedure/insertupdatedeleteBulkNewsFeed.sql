-- Database Connect
use [Media]
go

-- Set ansi nulls
set ansi_nulls on
go

-- Set quoted identifier
set quoted_identifier on
go

-- Procedure Drop
drop procedure if exists dbo.insertupdatedeleteBulkNewsFeed
go

-- ================================================
--        File: insertupdatedeleteBulkNewsFeed
--     Created: 09/07/2020
--     Updated: 11/19/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Insert Update Delete Bulk News Feed
-- ================================================

-- Procedure Create
create procedure [dbo].[insertupdatedeleteBulkNewsFeed]
  -- Add the parameters for the stored procedure here
  @optionMode nvarchar(max),
  @title nvarchar(max) = null,
  @imageurl nvarchar(max) = null,
  @feedurl nvarchar(max) = null,
  @actualurl nvarchar(max) = null,
  @publishdate nvarchar(max) = null
as
begin
  -- Set nocount on added to prevent extra result sets from interfering with select statements
  set nocount on

  -- Declare variables
  declare @omitOptionMode as nvarchar(max)
  declare @omitTitle as nvarchar(max)
  declare @omitImageurl as nvarchar(max)
  declare @omitFeedurl as nvarchar(max)
  declare @omitActualurl as nvarchar(max)
  declare @omitPublishDate as nvarchar(max)
  declare @maxLengthOptionMode as int
  declare @maxLengthTitle as int
  declare @maxLengthImageurl as int
  declare @maxLengthFeedurl as int
  declare @maxLengthActualurl as int
  declare @maxLengthPublishDate as int
  declare @result as nvarchar(max)

  -- Set variables
  set @omitOptionMode = N'0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z'
  set @omitTitle = N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9, ,!,",#,$,%,&,'',(,),*,+,,,-,.,/,:,;,<,=,>,?,@,[,],^,_,{,|,},~,¡,¢,£,¥,¦,§,¨,©,®,¯,°,±,´,µ,¿,À,Á,Â,Ã,Ä,Å,Æ,Ç,È,É,Ê,Ë,Ì,Í,Î,Ï,Ð,Ñ,Ò,Ó,Ô,Õ,Ö,×,Ø,Ù,Ú,Û,Ü,Ý,Þ,ß,à,á,â,ã,ä,å,æ,ç,è,é,ê,ë,ì,í,î,ï,ð,ñ,ò,ó,ô,õ,ö,÷,ø,ù,ú,û,ü,ý,þ,ÿ,ı,Œ,œ,Š,š,Ÿ,Ž,ž,ƒ,ˆ,ˇ,˘,˙,˚,˛,Γ,Θ,Σ,Φ,Ω,α,δ,ε,π,σ,τ,φ,–,—,‘,’,“,”,•,…,€,™,∂,∆,∏,∑,∙,√,∞,∩,∫,≈,≠,≡,≤,≥'
  set @omitImageurl = N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9, ,!,",#,$,%,&,'',(,),*,+,,,-,.,/,:,;,<,=,>,?,@,[,],^,_,{,|,},~,¡,¢,£,¥,¦,§,¨,©,®,¯,°,±,´,µ,¿,À,Á,Â,Ã,Ä,Å,Æ,Ç,È,É,Ê,Ë,Ì,Í,Î,Ï,Ð,Ñ,Ò,Ó,Ô,Õ,Ö,×,Ø,Ù,Ú,Û,Ü,Ý,Þ,ß,à,á,â,ã,ä,å,æ,ç,è,é,ê,ë,ì,í,î,ï,ð,ñ,ò,ó,ô,õ,ö,÷,ø,ù,ú,û,ü,ý,þ,ÿ,ı,Œ,œ,Š,š,Ÿ,Ž,ž,ƒ,ˆ,ˇ,˘,˙,˚,˛,Γ,Θ,Σ,Φ,Ω,α,δ,ε,π,σ,τ,φ,–,—,‘,’,“,”,•,…,€,™,∂,∆,∏,∑,∙,√,∞,∩,∫,≈,≠,≡,≤,≥'
  set @omitFeedurl = N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9, ,!,",#,$,%,&,'',(,),*,+,,,-,.,/,:,;,<,=,>,?,@,[,],^,_,{,|,},~,¡,¢,£,¥,¦,§,¨,©,®,¯,°,±,´,µ,¿,À,Á,Â,Ã,Ä,Å,Æ,Ç,È,É,Ê,Ë,Ì,Í,Î,Ï,Ð,Ñ,Ò,Ó,Ô,Õ,Ö,×,Ø,Ù,Ú,Û,Ü,Ý,Þ,ß,à,á,â,ã,ä,å,æ,ç,è,é,ê,ë,ì,í,î,ï,ð,ñ,ò,ó,ô,õ,ö,÷,ø,ù,ú,û,ü,ý,þ,ÿ,ı,Œ,œ,Š,š,Ÿ,Ž,ž,ƒ,ˆ,ˇ,˘,˙,˚,˛,Γ,Θ,Σ,Φ,Ω,α,δ,ε,π,σ,τ,φ,–,—,‘,’,“,”,•,…,€,™,∂,∆,∏,∑,∙,√,∞,∩,∫,≈,≠,≡,≤,≥'
  set @omitActualurl = N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9, ,!,",#,$,%,&,'',(,),*,+,,,-,.,/,:,;,<,=,>,?,@,[,],^,_,{,|,},~,¡,¢,£,¥,¦,§,¨,©,®,¯,°,±,´,µ,¿,À,Á,Â,Ã,Ä,Å,Æ,Ç,È,É,Ê,Ë,Ì,Í,Î,Ï,Ð,Ñ,Ò,Ó,Ô,Õ,Ö,×,Ø,Ù,Ú,Û,Ü,Ý,Þ,ß,à,á,â,ã,ä,å,æ,ç,è,é,ê,ë,ì,í,î,ï,ð,ñ,ò,ó,ô,õ,ö,÷,ø,ù,ú,û,ü,ý,þ,ÿ,ı,Œ,œ,Š,š,Ÿ,Ž,ž,ƒ,ˆ,ˇ,˘,˙,˚,˛,Γ,Θ,Σ,Φ,Ω,α,δ,ε,π,σ,τ,φ,–,—,‘,’,“,”,•,…,€,™,∂,∆,∏,∑,∙,√,∞,∩,∫,≈,≠,≡,≤,≥'
  set @omitPublishDate = N' ,-,/,0,1,2,3,4,5,6,7,8,9,:,.'
  set @maxLengthOptionMode = 255
  set @maxLengthTitle = 255
  set @maxLengthImageurl = 255
  set @maxLengthFeedurl = 768
  set @maxLengthActualurl = 255
  set @maxLengthPublishDate = 255
  set @result = ''

  -- Check if parameter is not null
  if @optionMode is not null
    begin
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set @optionMode = dbo.OmitCharacters(@optionMode, @omitOptionMode)

      -- Set character limit
      set @optionMode = trim(substring(@optionMode, 1, @maxLengthOptionMode))

      -- Check if empty string
      if @optionMode = ''
        begin
          -- Set parameter to null if empty string
          set @optionMode = nullif(@optionMode, '')
        end
    end

  -- Check if parameter is not null
  if @title is not null
    begin
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set @title = dbo.OmitCharacters(@title, @omitTitle)

      -- Set character limit
      set @title = trim(substring(@title, 1, @maxLengthTitle))

      -- Check if empty string
      if @title = ''
        begin
          -- Set parameter to null if empty string
          set @title = nullif(@title, '')
        end
    end

  -- Check if parameter is not null
  if @imageurl is not null
    begin
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set @imageurl = dbo.OmitCharacters(@imageurl, @omitImageurl)

      -- Set character limit
      set @imageurl = trim(substring(@imageurl, 1, @maxLengthImageurl))

      -- Check if empty string
      if @imageurl = ''
        begin
          -- Set parameter to null if empty string
          set @imageurl = nullif(@imageurl, '')
        end
    end

  -- Check if parameter is not null
  if @feedurl is not null
    begin
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set @feedurl = dbo.OmitCharacters(@feedurl, @omitFeedurl)

      -- Set character limit
      set @feedurl = trim(substring(@feedurl, 1, @maxLengthFeedurl))

      -- Check if empty string
      if @feedurl = ''
        begin
          -- Set parameter to null if empty string
          set @feedurl = nullif(@feedurl, '')
        end
    end

  -- Check if parameter is not null
  if @actualurl is not null
    begin
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set @actualurl = dbo.OmitCharacters(@actualurl, @omitActualurl)

      -- Set character limit
      set @actualurl = trim(substring(@actualurl, 1, @maxLengthActualurl))

      -- Check if empty string
      if @actualurl = ''
        begin
          -- Set parameter to null if empty string
          set @actualurl = nullif(@actualurl, '')
        end
    end

  -- Check if parameter is not null
  if @publishdate is not null
    begin
      -- Omit characters, multi space to single space, and trim leading and trailing spaces
      set @publishdate = dbo.OmitCharacters(@publishdate, @omitPublishDate)

      -- Set character limit
      set @publishdate = trim(substring(@publishdate, 1, @maxLengthPublishDate))

      -- Check if the parameter cannot be casted into a date time
      if try_cast(@publishdate as datetime2(6)) is null
        begin
          -- Set the string as empty to be nulled below
          set @publishdate = ''
        end

      -- Check if empty string
      if @publishdate = ''
        begin
          -- Set parameter to null if empty string
          set @publishdate = nullif(@publishdate, '')
        end
    end

  -- Check if option mode is delete temp news
  if @optionMode = 'deleteTempNews'
    begin
      -- Begin the tranaction
      begin tran
        -- Begin the try block
        begin try
          -- Delete records
          delete
          from dbo.NewsFeedTemp

          -- Check if there is trans count
          if @@trancount > 0
            begin
              -- Commit transactional statement
              commit tran
            end

          -- Set message
          set @result = '{"Status": "Success", "Message": "Record(s) deleted"}'
        end try
        -- End try block
        -- Begin catch block
        begin catch
          -- Check if there is trans count
          if @@trancount > 0
            begin
              -- Rollback to the previous state before the transaction was called
              rollback
            end

          -- Set message
          set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
        end catch
        -- End catch block

      -- Select message
      select
      @result as [status]
    end

  -- Else check if option mode is insert temp news
  else if @optionMode = 'insertTempNews'
    begin
      -- Check if parameters are not null
      if @title is not null and @publishdate is not null
        begin
          -- Begin the tranaction
          begin tran
            -- Begin the try block
            begin try
              -- Insert record
              insert into dbo.NewsFeedTemp
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
                @title,
                iif(trim(@imageurl) = '', null, @imageurl),
                @feedurl,
                iif(trim(@actualurl) = '', null, @actualurl),
                @publishdate,
                cast(getdate() as datetime2(6))
              )

              -- Check if there is trans count
              if @@trancount > 0
                begin
                  -- Commit transactional statement
                  commit tran
                end

              -- Set message
              set @result = '{"Status": "Success", "Message": "Record(s) inserted"}'
            end try
            -- End try block
            -- Begin catch block
            begin catch
              -- Check if there is trans count
              if @@trancount > 0
                begin
                  -- Rollback to the previous state before the transaction was called
                  rollback
                end

              -- Set message
              set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
            end catch
            -- End catch block
        end
      else
        begin
          -- Set message
          set @result = '{"Status": "Error", "Message": "Process halted, title and or publish date were not provided"}'
        end

      -- Select message
      select
      @result as [status]
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
            trim(substring(dbo.OmitCharacters(nft.title, @omitTitle), 1, @maxLengthTitle)) as title,
            trim(substring(dbo.OmitCharacters(nft.imageurl, @omitImageurl), 1, @maxLengthImageurl)) as imageurl,
            trim(substring(dbo.OmitCharacters(nft.feedurl, @omitFeedurl), 1, @maxLengthFeedurl)) as feedurl,
            trim(substring(dbo.OmitCharacters(nft.actualurl, @omitActualurl), 1, @maxLengthActualurl)) as actualurl,
            trim(substring(dbo.OmitCharacters(nft.publish_date, @omitPublishDate), 1, @maxLengthPublishDate)) as publish_date
            from dbo.NewsFeedTemp nft
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
              cast(nft.publish_date as datetime2(6)) >= dateadd(hour, -1, getdate()) and
              cast(nft.publish_date as datetime2(6)) <= dateadd(hour, 0, getdate())
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
            left join dbo.NewsFeed nf on nf.title = snd.title
            inner join (select sndii.title, max(sndii.publish_date) as publish_date from subNewsDetails sndii group by sndii.title) as sndi on sndi.title = snd.title and sndi.publish_date = snd.publish_date
            where
            nf.nfID is not null
            group by snd.title, snd.imageurl, snd.feedurl, snd.actualurl, snd.publish_date, nf.nfID
          )

          -- Update records
          update dbo.NewsFeed
          set
          imageurl = iif(trim(nd.imageurl) = '', null, nd.imageurl),
          feedurl = nd.feedurl,
          actualurl = iif(trim(nd.actualurl) = '', null, nd.actualurl),
          publish_date = cast(nd.publish_date as datetime2(6)),
          modified_date = cast(getdate() as datetime2(6))
          from newsDetails nd
          where
          nd.nfID = dbo.NewsFeed.nfID

          -- Check if there is trans count
          if @@trancount > 0
            begin
              -- Commit transactional statement
              commit tran
            end

          -- Set message
          set @result = '{"Status": "Success", "Message": "Record(s) updated"}'
        end try
        -- End try block
        -- Begin catch block
        begin catch
          -- Check if there is trans count
          if @@trancount > 0
            begin
              -- Rollback to the previous state before the transaction was called
              rollback
            end

          -- Set message
          set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
        end catch

      -- Select message
      select
      @result as [status]
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
            trim(substring(dbo.OmitCharacters(nft.title, @omitTitle), 1, @maxLengthTitle)) as title,
            trim(substring(dbo.OmitCharacters(nft.imageurl, @omitImageurl), 1, @maxLengthImageurl)) as imageurl,
            trim(substring(dbo.OmitCharacters(nft.feedurl, @omitFeedurl), 1, @maxLengthFeedurl)) as feedurl,
            trim(substring(dbo.OmitCharacters(nft.actualurl, @omitActualurl), 1, @maxLengthActualurl)) as actualurl,
            trim(substring(dbo.OmitCharacters(nft.publish_date, @omitPublishDate), 1, @maxLengthPublishDate)) as publish_date
            from dbo.NewsFeedTemp nft
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
            --   cast(nft.publish_date as datetime2(6)) >= dateadd(hour, -1, getdate()) and
            --   cast(nft.publish_date as datetime2(6)) <= dateadd(hour, 0, getdate())
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
            left join dbo.NewsFeed nf on nf.title = snd.title
            inner join (select sndii.title, max(sndii.publish_date) as publish_date from subNewsDetails sndii group by sndii.title) as sndi on sndi.title = snd.title and sndi.publish_date = snd.publish_date
            where
            nf.nfID is null
            group by snd.title, snd.imageurl, snd.feedurl, snd.actualurl, snd.publish_date, nf.nfID
          )

          -- Insert records
          insert into dbo.NewsFeed
          (
            title,
            imageurl,
            feedurl,
            actualurl,
            publish_date,
            created_date,
            modified_date
          )
          select
          nd.title,
          iif(trim(nd.imageurl) = '', null, nd.imageurl),
          nd.feedurl,
          iif(trim(nd.actualurl) = '', null, nd.actualurl),
          cast(nd.publish_date as datetime2(6)),
          cast(getdate() as datetime2(6)),
          cast(getdate() as datetime2(6))
          from newsDetails nd
          group by nd.title, nd.imageurl, nd.feedurl, nd.actualurl, nd.publish_date

          -- Check if there is trans count
          if @@trancount > 0
            begin
              -- Commit transactional statement
              commit tran
            end

          -- Set message
          set @result = '{"Status": "Success", "Message": "Record(s) inserted"}'
        end try
        -- End try block
        -- Begin catch block
        begin catch
          -- Check if there is trans count
          if @@trancount > 0
            begin
              -- Rollback to the previous state before the transaction was called
              rollback
            end

          -- Set message
          set @result = concat('{"Status": "Error", "Message": "', cast(error_message() as nvarchar(max)), '"}')
        end catch

      -- Select message
      select
      @result as [status]
    end
end
