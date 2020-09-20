USE [Media]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NewsFeedTemp](
	[title] [nvarchar](max) NULL,
	[imageurl] [nvarchar](max) NULL,
	[feedurl] [nvarchar](max) NULL,
	[actualurl] [nvarchar](max) NULL,
	[publish_date] [nvarchar](max) NULL,
	[created_date] [datetime2](7) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[NewsFeedTemp] ADD  DEFAULT (getdate()) FOR [created_date]
GO
