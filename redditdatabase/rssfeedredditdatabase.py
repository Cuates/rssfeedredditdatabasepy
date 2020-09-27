##
#        File: rssfeedredditdatabase.py
#     Created: 09/13/2020
#     Updated: 09/27/2020
#  Programmer: Cuates
#  Updated By: Cuates
#     Purpose: Retrieve RSS feed from Reddit news site
#     Version: 0.0.1 Python3
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
    import re, logging, json, datetime, pytz, tzlocal, sqlalchemy, sqlite3, urllib, urllib3, html, pathlib#, pythonjsonlogger

    # Declare dictionary list
    feedInfo = []
    feedStorage = []

    # Retrieve reddit new from web site
    feedInfo = rfrdbclass.extractrssfeed('RedditNews')
    # print(feedInfo)

    # Check if list is not empty
    if feedInfo:
      # Check if feed info is 200 OK
      if feedInfo.status == 200:
        # Read JSON data from URL and decode the string to utf-8
        data = feedInfo.data
        # data = feedInfo.data.decode('utf-8')

        # Convert JSON string into dictionary list
        jsonData = json.loads(data)

        # Check if elements exists
        if jsonData.get('data', {}).get('children') != None:
          # Process all feed information one at a time
          for feedEntry in jsonData['data']['children']:
            # Initialize variable
            rssFeedTitle = ''
            rssFeedImageUrl = ''
            rssFeedUrl = ''
            rssFeedPermaUrl = ''
            rssFeedPublishDateUTCTimeStamp = ''
            rssFeedPublishDateLocalTimeStamp = ''
            local_tz = ''

            # Check if element exists
            if feedEntry.get('data', {}).get('title') != None:
              # Store title
              rssFeedTitle = feedEntry['data']['title']

              # Decode URL character(s)
              rssFeedTitle = html.unescape(rssFeedTitle)

            # Check if element exists
            if feedEntry.get('data', {}).get('preview', {}).get('images') != None:
              # Process all feed information one at a time
              for feedEntryImage in feedEntry['data']['preview']['images']:
                # Check if element exists
                if feedEntryImage.get('source', {}).get('url') != None:
                  # Store image url
                  rssFeedImageUrl = feedEntryImage['source']['url']

                  # Decode URL character(s)
                  rssFeedImageUrl = html.unescape(rssFeedImageUrl)

                  # # Convert Percent (%) to actual character(s)
                  # rssFeedImageUrl = urllib.parse.unquote(rssFeedImageUrl)

            # Check if element exists
            if feedEntry.get('data', {}).get('url') != None:
              # Store feed url
              rssFeedUrl = feedEntry['data']['url']

              # Decode URL character(s)
              rssFeedUrl = html.unescape(rssFeedUrl)

              # # Convert Percent (%) to actual character(s)
              # rssFeedUrl = urllib.parse.unquote(rssFeedUrl)

            # Check if element exists
            if feedEntry.get('data', {}).get('permalink') != None:
              # Store perma url
              rssFeedPermaUrl = feedEntry['data']['permalink']

              # Decode URL character(s)
              rssFeedPermaUrl = html.unescape(rssFeedPermaUrl)

              # Convert Percent (%) to actual character(s)
              rssFeedPermaUrl = urllib.parse.unquote(rssFeedPermaUrl)

            # Check if element exists
            if feedEntry.get('data', {}).get('created_utc') != None:
              # Store publish date
              rssFeedPublishDateUTCTimeStamp = feedEntry['data']['created_utc']

              # Set local time zone
              local_tz = tzlocal.get_localzone()

              # Convert UTC unix time stamp to local time stamp
              # NOTE: Make suer parameter from the JSON string is of type float
              rssFeedPublishDateLocalTimeStamp = datetime.datetime.fromtimestamp(float(rssFeedPublishDateUTCTimeStamp), local_tz).strftime("%Y-%m-%d %H:%M:%S")

            # Set dictionary list with values
            feedStorage.append({'Title': rssFeedTitle, 'ImageURL': rssFeedImageUrl, 'FeedURL': rssFeedUrl, 'ActualURL': rssFeedPermaUrl, 'PublishDate': rssFeedPublishDateLocalTimeStamp})

        # Check if there are any values to process
        if feedStorage:
          # MSSQL BEGIN
          # Delete temp news only if there are records
          deleteFreeTDSNews = rfrdbclass._deleteTempNews('FreeTDSNews')

          # # Split at the tilde (~)
          # splitDeleteFreeTDSNews = re.split(r'~', deleteFreeTDSNews)

          # # Check if SError is returned
          # if splitDeleteFreeTDSNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error delete FreeTDSNews ' + splitDeleteFreeTDSNews[1])
            # # print(str(feedInfo.status))

          # Insert news into temp table
          insertFreeTDSNews = rfrdbclass._insertTempNews('FreeTDSNews', feedStorage)

          # # Split at the tilde (~)
          # splitInsertFreeTDSNews = re.split(r'~', insertFreeTDSNews)

          # # Check if SError is returned
          # if splitInsertFreeTDSNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error insert FreeTDSNews ' + splitInsertFreeTDSNews[1])
            # # print(str(feedInfo.status))

          # Bulk update news
          updateBulkFreeTDSNews = rfrdbclass._updateBulkNews('FreeTDSNews')

          # # Split at the tilde (~)
          # splitUpdateBulkFreeTDSNews = re.split(r'~', updateBulkFreeTDSNews)

          # # Check if SError is returned
          # if splitUpdateBulkFreeTDSNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error update bulk FreeTDSNews ' + splitUpdateBulkFreeTDSNews[1])
            # # print(str(feedInfo.status))

          # Bulk insert news
          insertBulkFreeTDSNews = rfrdbclass._insertBulkNews('FreeTDSNews')

          # # Split at the tilde (~)
          # splitInsertBulkFreeTDSNews = re.split(r'~', insertBulkFreeTDSNews)

          # # Check if SError is returned
          # if splitInsertBulkFreeTDSNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error insert bulk FreeTDSNews ' + splitInsertBulkFreeTDSNews[1])
            # # print(str(feedInfo.status))
          # MSSQL END
          # MySQL BEGIN
          # Delete temp news only if there are records
          deleteMySQLNews = rfrdbclass._deleteTempNews('MySQLNews')

          # # Split at the tilde (~)
          # splitDeleteMySQLNews = re.split(r'~', deleteMySQLNews)

          # # Check if SError is returned
          # if splitDeleteMySQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error delete MySQLNews ' + splitDeleteMySQLNews[1])
            # # print(str(feedInfo.status))

          # Insert news into temp table
          insertMySQLNews = rfrdbclass._insertTempNews('MySQLNews', feedStorage)

          # # Split at the tilde (~)
          # splitInsertMySQLNews = re.split(r'~', insertMySQLNews)

          # # Check if SError is returned
          # if splitInsertMySQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error insert MySQLNews ' + splitInsertMySQLNews[1])
            # # print(str(feedInfo.status))

          # Bulk update news
          updateBulkMySQLNews = rfrdbclass._updateBulkNews('MySQLNews')

          # # Split at the tilde (~)
          # splitUpdateBulkMySQLNews = re.split(r'~', updateBulkMySQLNews)

          # # Check if SError is returned
          # if splitUpdateBulkMySQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error update bulk MySQLNews ' + splitUpdateBulkMySQLNews[1])
            # # print(str(feedInfo.status))

          # Bulk insert news
          insertBulkMySQLNews = rfrdbclass._insertBulkNews('MySQLNews')

          # # Split at the tilde (~)
          # splitInsertBulkMySQLNews = re.split(r'~', insertBulkMySQLNews)

          # # Check if SError is returned
          # if splitInsertBulkMySQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error insert bulk MySQLNews ' + splitInsertBulkMySQLNews[1])
            # # print(str(feedInfo.status))
          # MySQL END
          # PostgreSQL BEGIN
          # Delete temp news only if there are records
          deletePostgreSQLNews = rfrdbclass._deleteTempNews('PGSQLNews')

          # # Split at the tilde (~)
          # splitDeletePostgreSQLNews = re.split(r'~', deletePostgreSQLNews)

          # # Check if SError is returned
          # if splitDeletePostgreSQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error delete PGSQLNews ' + splitDeletePostgreSQLNews[1])
            # # print(str(feedInfo.status))

          # Insert news into temp table
          insertPostgreSQLNews = rfrdbclass._insertTempNews('PGSQLNews', feedStorage)

          # # Split at the tilde (~)
          # splitInsertPostgreSQLNews = re.split(r'~', insertPostgreSQLNews)

          # # Check if SError is returned
          # if splitInsertPostgreSQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error insert PGSQLNews ' + splitInsertPostgreSQLNews[1])
            # # print(str(feedInfo.status))

          # Bulk update news
          updateBulkPostgreSQLNews = rfrdbclass._updateBulkNews('PGSQLNews')

          # # Split at the tilde (~)
          # splitUpdateBulkPostgreSQLNews = re.split(r'~', updateBulkPostgreSQLNews)

          # # Check if SError is returned
          # if splitUpdateBulkPostgreSQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error update bulk PGSQLNews ' + splitUpdateBulkPostgreSQLNews[1])
            # # print(str(feedInfo.status))

          # Bulk insert news
          insertBulkPostgreSQLNews = rfrdbclass._insertBulkNews('PGSQLNews')

          # # Split at the tilde (~)
          # splitInsertBulkPostgreSQLNews = re.split(r'~', insertBulkPostgreSQLNews)

          # # Check if SError is returned
          # if splitInsertBulkPostgreSQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error insert bulk PGSQLNews ' + splitInsertBulkPostgreSQLNews[1])
            # # print(str(feedInfo.status))
          # PostgreSQL END
      else:
        # Log string
        rfrdbclass._setLogger('Error retrieving feed status ' + str(feedInfo.status))
        # print(str(feedInfo.status))
    else:
      # Log string
      rfrdbclass._setLogger('Error retrieving feed data ' + str(feedInfo))
      # print(str(feedInfo))
  except Exception as e:
    # # Log string
    # logException = 'Issue with loop'

    # Log string
    rfrdbclass._setLogger('Issue executing main PY file ' + str(e))
    # print(str(e))

# Run program
if __name__ == '__main__':
  main()