##
#        File: rssfeedredditdatabase.py
#     Created: 09/13/2020
#     Updated: 10/13/2020
#  Programmer: Cuates
#  Updated By: Cuates
#     Purpose: Retrieve RSS feed from Reddit news site
#     Version: 0.0.8 Python3
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

    # Retrieve reddit new from web site
    feedInfo = rfrdbclass.extractrssfeed('OptionInConfig')
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
          # Set header row for CSV file
          newsHeaderColumn = ['Param01', 'Param02', 'Param03', 'Param04', 'Param05']

          # Write data to a CSV file
          writeCSVFileResp = rfrdbclass._writeToCSVFile('/path/to/share/drive/Outbound.csv', newsHeaderColumn, feedStorage)
          # print (writeCSVFileResp)

          # Get current time stamp
          dateTimeObj = datetime.datetime.now()

          # Convert date time to string
          timestampStr = dateTimeObj.strftime('%Y-%m-%d %H:%M:%S.%f')

          # Restructure JSON output
          feedStorageNested = {'news': {'created_date': timestampStr, 'count': len(feedStorage), 'children': feedStorage}}

          # Write data to a JSON file
          writeJSONFileResp = rfrdbclass._writeToJSONFile('/path/to/share/drive/Outbound.json', feedStorageNested)
          # print (writeJSONFileResp)

          # Delete temp news only if there are records
          deleteMSSQLWNews = rfrdbclass._deleteTempNews('OptionInConfig')

          # # Split at the tilde (~)
          # splitDeleteMSSQLWNews = re.split(r'~', deleteMSSQLWNews)

          # # Check if SError is returned
          # if splitDeleteMSSQLWNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error delete MSSQLWNews ' + splitDeleteMSSQLWNews[1])
            # # print(str(feedInfo.status))

          # Delete temp news only if there are records
          deleteMSSQLLNews = rfrdbclass._deleteTempNews('OptionInConfig')

          # # Split at the tilde (~)
          # splitDeleteMSSQLLNews = re.split(r'~', deleteMSSQLLNews)

          # # Check if SError is returned
          # if splitDeleteMSSQLLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error delete MSSQLLNews ' + splitDeleteMSSQLLNews[1])
            # # print(str(feedInfo.status))

          # Insert news into temp table
          insertMSSQLWNews = rfrdbclass._insertTempNews('OptionInConfig', feedStorage)

          # # Split at the tilde (~)
          # splitInsertMSSQLWNews = re.split(r'~', insertMSSQLWNews)

          # # Check if SError is returned
          # if splitInsertMSSQLWNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error insert MSSQLWNews ' + splitInsertMSSQLWNews[1])
            # # print(str(feedInfo.status))

          # Insert news into temp table
          insertMSSQLLNews = rfrdbclass._insertTempNews('OptionInConfig', feedStorage)

          # # Split at the tilde (~)
          # splitInsertMSSQLLNews = re.split(r'~', insertMSSQLLNews)

          # # Check if SError is returned
          # if splitInsertMSSQLLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error insert MSSQLLNews ' + splitInsertMSSQLLNews[1])
            # # print(str(feedInfo.status))

          # Bulk update news
          updateBulkMSSQLWNews = rfrdbclass._updateBulkNews('OptionInConfig')

          # # Split at the tilde (~)
          # splitUpdateBulkMSSQLWNews = re.split(r'~', updateBulkMSSQLWNews)

          # # Check if SError is returned
          # if splitUpdateBulkMSSQLWNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error update bulk MSSQLWNews ' + splitUpdateBulkMSSQLWNews[1])
            # # print(str(feedInfo.status))

          # Bulk update news
          updateBulkMSSQLLNews = rfrdbclass._updateBulkNews('OptionInConfig')

          # # Split at the tilde (~)
          # splitUpdateBulkMSSQLLNews = re.split(r'~', updateBulkMSSQLLNews)

          # # Check if SError is returned
          # if splitUpdateBulkMSSQLLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error update bulk MSSQLLNews ' + splitUpdateBulkMSSQLLNews[1])
            # # print(str(feedInfo.status))

          # Bulk insert news
          insertBulkMSSQLWNews = rfrdbclass._insertBulkNews('OptionInConfig')

          # # Split at the tilde (~)
          # splitInsertBulkMSSQLWNews = re.split(r'~', insertBulkMSSQLWNews)

          # # Check if SError is returned
          # if splitInsertBulkMSSQLWNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error insert bulk MSSQLWNews ' + splitInsertBulkMSSQLWNews[1])
            # # print(str(feedInfo.status))

          # Bulk insert news
          insertBulkMSSQLLNews = rfrdbclass._insertBulkNews('OptionInConfig')

          # # Split at the tilde (~)
          # splitInsertBulkMSSQLLNews = re.split(r'~', insertBulkMSSQLLNews)

          # # Check if SError is returned
          # if splitInsertBulkMSSQLLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error insert bulk MSSQLLNews ' + splitInsertBulkMSSQLLNews[1])
            # # print(str(feedInfo.status))
          # MSSQL END
          # MySQL BEGIN
          # Delete temp news only if there are records
          deleteMariaDBSQLNews = rfrdbclass._deleteTempNews('OptionInConfig')

          # # Split at the tilde (~)
          # splitDeleteMariaDBSQLNews = re.split(r'~', deleteMariaDBSQLNews)

          # # Check if SError is returned
          # if splitDeleteMariaDBSQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error delete MariaDBSQLNews ' + splitDeleteMariaDBSQLNews[1])
            # # print(str(feedInfo.status))

          # Insert news into temp table
          insertMariaDBSQLNews = rfrdbclass._insertTempNews('OptionInConfig', feedStorage)

          # # Split at the tilde (~)
          # splitInsertMariaDBSQLNews = re.split(r'~', insertMariaDBSQLNews)

          # # Check if SError is returned
          # if splitInsertMariaDBSQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error insert MariaDBSQLNews ' + splitInsertMariaDBSQLNews[1])
            # # print(str(feedInfo.status))

          # Bulk update news
          updateBulkMariaDBSQLNews = rfrdbclass._updateBulkNews('OptionInConfig')

          # # Split at the tilde (~)
          # splitUpdateBulkMariaDBSQLNews = re.split(r'~', updateBulkMariaDBSQLNews)

          # # Check if SError is returned
          # if splitUpdateBulkMariaDBSQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error update bulk MariaDBSQLNews ' + splitUpdateBulkMariaDBSQLNews[1])
            # # print(str(feedInfo.status))

          # Bulk insert news
          insertBulkMariaDBSQLNews = rfrdbclass._insertBulkNews('OptionInConfig')

          # # Split at the tilde (~)
          # splitInsertBulkMariaDBSQLNews = re.split(r'~', insertBulkMariaDBSQLNews)

          # # Check if SError is returned
          # if splitInsertBulkMariaDBSQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error insert bulk MariaDBSQLNews ' + splitInsertBulkMariaDBSQLNews[1])
            # # print(str(feedInfo.status))
          # MySQL END
          # PostgreSQL BEGIN
          # Delete temp news only if there are records
          deletePostgreSQLNews = rfrdbclass._deleteTempNews('OptionInConfig')

          # # Split at the tilde (~)
          # splitDeletePostgreSQLNews = re.split(r'~', deletePostgreSQLNews)

          # # Check if SError is returned
          # if splitDeletePostgreSQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error delete PGSQLNews ' + splitDeletePostgreSQLNews[1])
            # # print(str(feedInfo.status))

          # Insert news into temp table
          insertPostgreSQLNews = rfrdbclass._insertTempNews('OptionInConfig', feedStorage)

          # # Split at the tilde (~)
          # splitInsertPostgreSQLNews = re.split(r'~', insertPostgreSQLNews)

          # # Check if SError is returned
          # if splitInsertPostgreSQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error insert PGSQLNews ' + splitInsertPostgreSQLNews[1])
            # # print(str(feedInfo.status))

          # Bulk update news
          updateBulkPostgreSQLNews = rfrdbclass._updateBulkNews('OptionInConfig')

          # # Split at the tilde (~)
          # splitUpdateBulkPostgreSQLNews = re.split(r'~', updateBulkPostgreSQLNews)

          # # Check if SError is returned
          # if splitUpdateBulkPostgreSQLNews[0] == 'SError':
            # # Log string
            # rfrdbclass._setLogger('Error update bulk PGSQLNews ' + splitUpdateBulkPostgreSQLNews[1])
            # # print(str(feedInfo.status))

          # Bulk insert news
          insertBulkPostgreSQLNews = rfrdbclass._insertBulkNews('OptionInConfig')

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