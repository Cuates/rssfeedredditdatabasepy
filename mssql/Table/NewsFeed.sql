USE [Media]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NewsFeed](
	[nfID] [bigint] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[imageurl] [nvarchar](255) NULL,
	[feedurl] [nvarchar](max) NULL,
	[actualurl] [nvarchar](255) NULL,
	[publish_date] [datetime2](7) NOT NULL,
	[created_date] [datetime2](7) NOT NULL,
	[modified_date] [datetime2](7) NULL,
 CONSTRAINT [PK_NewsFeed_title] PRIMARY KEY CLUSTERED 
(
	[title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[NewsFeed] ADD  DEFAULT (getdate()) FOR [created_date]
GO

ALTER TABLE [dbo].[NewsFeed] ADD  DEFAULT (getdate()) FOR [modified_date]
GO
