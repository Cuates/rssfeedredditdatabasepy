-- Database Connect
use [databasename]
go

-- Set ansi nulls
set ansi_nulls on
go

-- Set quoted identifier
set quoted_identifier on
go

-- Procedure Drop
drop procedure if exists dbo.insertupdatedeleteNewsFeed
go

-- ===========================================
--        File: insertupdatedeleteNewsFeed
--     Created: 09/07/2020
--     Updated: 10/01/2020
--  Programmer: Cuates
--   Update By: Cuates
--     Purpose: Insert Update Delete News Feed
-- ===========================================

-- Procedure Create
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
  set @optionMode = dbo.OmitCharacters(@optionMode, N'0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z')

  -- Check if empty string
  if @optionMode = ''
    begin
      -- Set parameter to null if empty string
      set @optionMode = nullif(@optionMode, '')
    end

  -- Set character limit
  set @optionMode = substring(@optionMode, 1, 255)

  -- Omit characters, multi space to single space, and trim leading and trailing spaces
  set @title = dbo.OmitCharacters(@title, N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9, ,!,",#,$,%,&,'',(,),*,+,,,-,.,/,:,;,<,=,>,?,@,[,],^,_,{,|,},~,¡,¢,£,¥,¦,§,¨,©,®,¯,°,±,´,µ,¿,À,Á,Â,Ã,Ä,Å,Æ,Ç,È,É,Ê,Ë,Ì,Í,Î,Ï,Ð,Ñ,Ò,Ó,Ô,Õ,Ö,×,Ø,Ù,Ú,Û,Ü,Ý,Þ,ß,à,á,â,ã,ä,å,æ,ç,è,é,ê,ë,ì,í,î,ï,ð,ñ,ò,ó,ô,õ,ö,÷,ø,ù,ú,û,ü,ý,þ,ÿ,ı,Œ,œ,Š,š,Ÿ,Ž,ž,ƒ,ˆ,ˇ,˘,˙,˚,˛,Γ,Θ,Σ,Φ,Ω,α,δ,ε,π,σ,τ,φ,–,—,‘,’,“,”,•,…,€,™,∂,∆,∏,∑,∙,√,∞,∩,∫,≈,≠,≡,≤,≥')

  -- Check if empty string
  if @title = ''
    begin
      -- Set parameter to null if empty string
      set @title = nullif(@title, '')
    end

  -- Set character limit
  set @title = substring(@title, 1, 255)

  -- Omit characters, multi space to single space, and trim leading and trailing spaces
  set @imageurl = dbo.OmitCharacters(@imageurl, N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9, ,!,",#,$,%,&,'',(,),*,+,,,-,.,/,:,;,<,=,>,?,@,[,],^,_,{,|,},~,¡,¢,£,¥,¦,§,¨,©,®,¯,°,±,´,µ,¿,À,Á,Â,Ã,Ä,Å,Æ,Ç,È,É,Ê,Ë,Ì,Í,Î,Ï,Ð,Ñ,Ò,Ó,Ô,Õ,Ö,×,Ø,Ù,Ú,Û,Ü,Ý,Þ,ß,à,á,â,ã,ä,å,æ,ç,è,é,ê,ë,ì,í,î,ï,ð,ñ,ò,ó,ô,õ,ö,÷,ø,ù,ú,û,ü,ý,þ,ÿ,ı,Œ,œ,Š,š,Ÿ,Ž,ž,ƒ,ˆ,ˇ,˘,˙,˚,˛,Γ,Θ,Σ,Φ,Ω,α,δ,ε,π,σ,τ,φ,–,—,‘,’,“,”,•,…,€,™,∂,∆,∏,∑,∙,√,∞,∩,∫,≈,≠,≡,≤,≥')

  -- Check if empty string
  if @imageurl = ''
    begin
      -- Set parameter to null if empty string
      set @imageurl = nullif(@imageurl, '')
    end

  -- Set character limit
  set @imageurl = substring(@imageurl, 1, 255)

  -- Omit characters, multi space to single space, and trim leading and trailing spaces
  set @feedurl = dbo.OmitCharacters(@feedurl, N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9, ,!,",#,$,%,&,'',(,),*,+,,,-,.,/,:,;,<,=,>,?,@,[,],^,_,{,|,},~,¡,¢,£,¥,¦,§,¨,©,®,¯,°,±,´,µ,¿,À,Á,Â,Ã,Ä,Å,Æ,Ç,È,É,Ê,Ë,Ì,Í,Î,Ï,Ð,Ñ,Ò,Ó,Ô,Õ,Ö,×,Ø,Ù,Ú,Û,Ü,Ý,Þ,ß,à,á,â,ã,ä,å,æ,ç,è,é,ê,ë,ì,í,î,ï,ð,ñ,ò,ó,ô,õ,ö,÷,ø,ù,ú,û,ü,ý,þ,ÿ,ı,Œ,œ,Š,š,Ÿ,Ž,ž,ƒ,ˆ,ˇ,˘,˙,˚,˛,Γ,Θ,Σ,Φ,Ω,α,δ,ε,π,σ,τ,φ,–,—,‘,’,“,”,•,…,€,™,∂,∆,∏,∑,∙,√,∞,∩,∫,≈,≠,≡,≤,≥')

  -- Check if empty string
  if @feedurl = ''
    begin
      -- Set parameter to null if empty string
      set @feedurl = nullif(@feedurl, '')
    end

  -- Set character limit
  set @feedurl = substring(@feedurl, 1, 768)

  -- Omit characters, multi space to single space, and trim leading and trailing spaces
  set @actualurl = dbo.OmitCharacters(@actualurl, N'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,1,2,3,4,5,6,7,8,9, ,!,",#,$,%,&,'',(,),*,+,,,-,.,/,:,;,<,=,>,?,@,[,],^,_,{,|,},~,¡,¢,£,¥,¦,§,¨,©,®,¯,°,±,´,µ,¿,À,Á,Â,Ã,Ä,Å,Æ,Ç,È,É,Ê,Ë,Ì,Í,Î,Ï,Ð,Ñ,Ò,Ó,Ô,Õ,Ö,×,Ø,Ù,Ú,Û,Ü,Ý,Þ,ß,à,á,â,ã,ä,å,æ,ç,è,é,ê,ë,ì,í,î,ï,ð,ñ,ò,ó,ô,õ,ö,÷,ø,ù,ú,û,ü,ý,þ,ÿ,ı,Œ,œ,Š,š,Ÿ,Ž,ž,ƒ,ˆ,ˇ,˘,˙,˚,˛,Γ,Θ,Σ,Φ,Ω,α,δ,ε,π,σ,τ,φ,–,—,‘,’,“,”,•,…,€,™,∂,∆,∏,∑,∙,√,∞,∩,∫,≈,≠,≡,≤,≥')

  -- Check if empty string
  if @actualurl = ''
    begin
      -- Set parameter to null if empty string
      set @actualurl = nullif(@actualurl, '')
    end

  -- Set character limit
  set @actualurl = substring(@actualurl, 1, 255)

  -- Omit characters, multi space to single space, and trim leading and trailing spaces
  set @publishDate = dbo.OmitCharacters(@publishDate, N' ,-,/,0,1,2,3,4,5,6,7,8,9,:')

  -- Check if the parameter cannot be casted into a date time
  if try_cast(@publishDate as datetime2(6)) is null
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
            ) and
            (
              cast(nft.publish_date as datetime2(6)) >= dateadd(hour, -1, getdate()) and
              cast(nft.publish_date as datetime2(6)) <= dateadd(hour, 0, getdate())
            )
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
          nf.publish_date = cast(nd.publishdate as datetime2(6)),
          nf.modified_date = cast(getdate() as datetime2(6))
          from dbo.NewsFeed nf
          join newsDetails nd on nd.nfID = nf.nfID

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
            --   cast(nft.publish_date as datetime2(6)) >= dateadd(hour, -1, getdate()) and
            --   cast(nft.publish_date as datetime2(6)) <= dateadd(hour, 0, getdate())
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
          cast(nd.publishdate as datetime2(6)),
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
