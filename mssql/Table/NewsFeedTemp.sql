-- Database Connect
use [databasename]
go

-- Set ansi nulls
set ansi_nulls on
go

-- Set quoted identifier
set quoted_identifier on
go

-- Table Drop
drop table if exists dbo.NewsFeedTemp
go

-- Table Create
create table [dbo].[NewsFeedTemp](
  [title] [nvarchar](max) null,
  [imageurl] [nvarchar](max) null,
  [feedurl] [nvarchar](max) null,
  [actualurl] [nvarchar](max) null,
  [publish_date] [nvarchar](max) null,
  [created_date] [datetime2](6) null
) on [PRIMARY]
go

-- Contraint Default
alter table [dbo].[NewsFeedTemp] add  default (getdate()) for [created_date]
go
