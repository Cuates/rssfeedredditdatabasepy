-- Database Connect
use [Media]
go

-- Set ansi nulls
set ansi_nulls on
go

-- Set quoted identifier
set quoted_identifier on
go

-- Table Drop
drop table if exists dbo.NewsFeed

-- Table Create
create table [dbo].[NewsFeed](
	[nfID] [bigint] identity(1,1) not null,
	[title] [nvarchar](255) not null,
	[imageurl] [nvarchar](255) null,
	[feedurl] [nvarchar](768) not null,
	[actualurl] [nvarchar](255) null,
	[publish_date] [datetime2](6) not null,
	[created_date] [datetime2](6) not null,
	[modified_date] [datetime2](6) null,
 constraint [PK_NewsFeed_title] primary key clustered
(
	[title] asc
)with (pad_index = off, statistics_norecompute = off, ignore_dup_key = off, allow_row_locks = on, allow_page_locks = on, fillfactor = 90, optimize_for_sequential_key = off) on [primary]
) on [primary]
go

-- Contraint Default
alter table [dbo].[NewsFeed] add  default (getdate()) for [created_date]
go

-- Contraint Default
alter table [dbo].[NewsFeed] add  default (getdate()) for [modified_date]
go
