##
#        File: rssfeedredditdatabase.py
#     Created: 09/13/2020
#     Updated: 11/25/2020
#  Programmer: Cuates
#  Updated By: Cuates
#     Purpose: Retrieve RSS feed from Reddit news site
#     Version: 0.1.0 Python3
##

# Import modules
import rssfeedredditdatabaseclass # rss feed reddit class

# Set object
rfrdbclass = rssfeedredditdatabaseclass.RssFeedRedditDatabaseClass()

# Program entry point
def main():
  # Try to execute the command(s)
  try:
    # Check if modules are installed
    import re, logging, json, datetime, pytz, tzlocal, sqlalchemy, urllib, urllib3, html, pathlib, csv, os, traceback

    # Declare dictionary list
    feedInfo = []
    feedStorage = []
    feedStorageNested = {}

    # Initialize list
    mandatoryParams = ['title', 'url', 'created_utc']
    possibleParams = ['title', 'imageurl', 'feedurl', 'actualurl', 'publishdate']
    removeParams = []

    # Retrieve reddit new from web site
    feedInfo = rfrdbclass.extractrssfeed('RedditNews', mandatoryParams)
    # print(f'feedInfo: {feedInfo}')

    # Check if status exists
    if feedInfo.get('Status') != None:
      # Check if status is equal to success
      if feedInfo.get('Status') == 'Success':
        # Check if list is not empty
        if feedInfo.get('Result'):
          # Process all feed information one at a time
          for feedEntry in feedInfo.get('Result'):
            # Initialize variable
            rssFeedTitle = ''
            rssFeedImageUrl = ''
            rssFeedUrl = ''
            rssFeedPermaUrl = ''
            rssFeedPublishDateUTCTimeStamp = ''
            rssFeedPublishDateLocalTimeStamp = ''
            local_tz = ''

            # Check if element exists
            if feedEntry.get('title') != None:
              # Store title
              rssFeedTitle = feedEntry.get('title')

              # Decode URL character(s)
              rssFeedTitle = html.unescape(rssFeedTitle)

            # Check if element exists
            if feedEntry.get('preview', {}).get('images') != None:
              # Process all feed information one at a time
              for feedEntryImage in feedEntry.get('preview').get('images'):
                # Check if element exists
                if feedEntryImage.get('source', {}).get('url') != None:
                  # Store image url
                  rssFeedImageUrl = feedEntryImage.get('source').get('url')

                  # Decode URL character(s)
                  rssFeedImageUrl = html.unescape(rssFeedImageUrl)

                  # # Convert Percent (%) to actual character(s)
                  # rssFeedImageUrl = urllib.parse.unquote(rssFeedImageUrl)

            # Check if element exists
            if feedEntry.get('url') != None:
              # Store feed url
              rssFeedUrl = feedEntry.get('url')

              # Decode URL character(s)
              rssFeedUrl = html.unescape(rssFeedUrl)

              # # Convert Percent (%) to actual character(s)
              # rssFeedUrl = urllib.parse.unquote(rssFeedUrl)

            # Check if element exists
            if feedEntry.get('permalink') != None:
              # Store perma url
              rssFeedPermaUrl = feedEntry.get('permalink')

              # Decode URL character(s)
              rssFeedPermaUrl = html.unescape(rssFeedPermaUrl)

              # Convert Percent (%) to actual character(s)
              rssFeedPermaUrl = urllib.parse.unquote(rssFeedPermaUrl)

            # Check if element exists
            if feedEntry.get('created_utc') != None:
              # Store publish date
              rssFeedPublishDateUTCTimeStamp = feedEntry.get('created_utc')

              # Set local time zone
              local_tz = tzlocal.get_localzone()

              # Convert UTC unix time stamp to local time stamp
              # NOTE: Make suer parameter from the JSON string is of type float
              rssFeedPublishDateLocalTimeStamp = datetime.datetime.fromtimestamp(float(rssFeedPublishDateUTCTimeStamp), local_tz).strftime("%Y-%m-%d %H:%M:%S")

            # Set dictionary list with values
            feedStorage.append({'title': rssFeedTitle, 'imageurl': rssFeedImageUrl, 'feedurl': rssFeedUrl, 'actualurl': rssFeedPermaUrl, 'publishdate': rssFeedPublishDateLocalTimeStamp})

          # print(f'feedStorage: {feedStorage}')

          # Check if there are any values to process
          if feedStorage:
            # MSSQL BEGIN
            # Set header row for CSV file
            newsHeaderColumn = ['title', 'imageurl', 'feedurl', 'actualurl', 'publishdate']

            # Write data to a CSV file
            writeCSVFileResp = rfrdbclass._writeToCSVFile('/mnt/share/linuxprivate/Reddit/DEV/News/News_Outbound.csv', newsHeaderColumn, feedStorage)
            # print (writeCSVFileResp)

            # Get current time stamp
            dateTimeObj = datetime.datetime.now()

            # Convert date time to string
            timestampStr = dateTimeObj.strftime('%Y-%m-%d %H:%M:%S.%f')

            # Restructure JSON output
            feedStorageNested = {'news': {'created_date': timestampStr, 'count': len(feedStorage), 'children': feedStorage}}

            # Write data to a JSON file
            writeJSONFileResp = rfrdbclass._writeToJSONFile('/mnt/share/linuxprivate/Reddit/DEV/News/News_Outbound.json', feedStorageNested)
            # print (writeJSONFileResp)
            # MSSQL END

            # Initialize empty list/dictionary
            feedStorageEmtpy = [{'title': '', 'imageurl': '', 'feedurl': '', 'actualurl': '', 'publishedate': ''}]

            # Delete temp news only if there are records
            deleteTempNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('MariaDBSQLNews', 'deleting', 'insertupdatedeletebulknewsfeed', 'deleteTempNews', possibleParams, feedStorageEmtpy, removeParams)

            # Delete temp news only if there are records
            deleteTempNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('PGSQLNews', 'deleting', 'insertupdatedeletebulknewsfeed', 'deleteTempNews', possibleParams, feedStorageEmtpy, removeParams)

            # Delete temp news only if there are records
            deleteTempNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('MSSQLLNews', 'deleting', 'dbo.insertupdatedeleteBulkNewsFeed', 'deleteTempNews', possibleParams, feedStorageEmtpy, removeParams)

            # Delete temp news only if there are records
            deleteTempNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('MSSQLWNews', 'deleting', 'dbo.insertupdatedeleteBulkNewsFeed', 'deleteTempNews', possibleParams, feedStorageEmtpy, removeParams)

            # print(f'deleteTempNewsFeed: {deleteTempNewsFeed}')

            # Insert news into temp table
            insertTempNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('MariaDBSQLNews', 'inserting', 'insertupdatedeletebulknewsfeed', 'insertTempNews', possibleParams, feedStorage, removeParams)

            # Insert news into temp table
            insertTempNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('PGSQLNews', 'inserting', 'insertupdatedeletebulknewsfeed', 'insertTempNews', possibleParams, feedStorage, removeParams)

            # Insert news into temp table
            insertTempNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('MSSQLLNews', 'inserting', 'dbo.insertupdatedeleteBulkNewsFeed', 'insertTempNews', possibleParams, feedStorage, removeParams)

            # Insert news into temp table
            insertTempNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('MSSQLWNews', 'inserting', 'dbo.insertupdatedeleteBulkNewsFeed', 'insertTempNews', possibleParams, feedStorage, removeParams)

            # print(f'insertTempNewsFeed: {insertTempNewsFeed}')

            # Bulk update news
            updateBulkNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('MariaDBSQLNews', 'updating', 'insertupdatedeletebulknewsfeed', 'updateBulkNews', possibleParams, feedStorageEmtpy, removeParams)

            # Bulk update news
            updateBulkNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('PGSQLNews', 'updating', 'insertupdatedeletebulknewsfeed', 'updateBulkNews', possibleParams, feedStorageEmtpy, removeParams)

            # Bulk update news
            updateBulkNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('MSSQLLNews', 'updating', 'dbo.insertupdatedeleteBulkNewsFeed', 'updateBulkNews', possibleParams, feedStorageEmtpy, removeParams)

            # Bulk update news
            updateBulkNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('MSSQLWNews', 'updating', 'dbo.insertupdatedeleteBulkNewsFeed', 'updateBulkNews', possibleParams, feedStorageEmtpy, removeParams)

            # print(f'updateBulkNewsFeed: {updateBulkNewsFeed}')

            # Bulk insert news
            insertBulkNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('MariaDBSQLNews', 'inserting', 'insertupdatedeletebulknewsfeed', 'insertBulkNews', possibleParams, feedStorageEmtpy, removeParams)

            # Bulk insert news
            insertBulkNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('PGSQLNews', 'inserting', 'insertupdatedeletebulknewsfeed', 'insertBulkNews', possibleParams, feedStorageEmtpy, removeParams)

            # Bulk insert news
            insertBulkNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('MSSQLLNews', 'inserting', 'dbo.insertupdatedeleteBulkNewsFeed', 'insertBulkNews', possibleParams, feedStorageEmtpy, removeParams)

            # Bulk insert news
            insertBulkNewsFeed = rfrdbclass._insertupdatedeleteNewsFeed('MSSQLWNews', 'inserting', 'dbo.insertupdatedeleteBulkNewsFeed', 'insertBulkNews', possibleParams, feedStorageEmtpy, removeParams)

            # print(f'insertBulkNewsFeed: {insertBulkNewsFeed}')
      # else:
      #   print(f'''Status: {feedInfo.get('Status')}, Message: {feedInfo.get('Message')}, Result: []''')
    else:
      # print(f'Status: Error, Message: {feedInfo}, Result: []')

      # Log string
      rfrdbclass._setLogger('Error retrieveing news feed data ' + str(feedInfo))

  except Exception as e:
    # # Log string
    # logException = 'Issue with loop'

    # Log string
    rfrdbclass._setLogger('Issue executing main PY file ' + str(e))
    # print(str(e))

# Run program
if __name__ == '__main__':
  main()
