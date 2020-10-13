##
#        File: rssfeedredditdatabaseclass.py
#     Created: 09/13/2020
#     Updated: 10/13/2020
#  Programmer: Cuates
#  Updated By: Cuates
#     Purpose: RSS Reddit feed database Class
##

# Import modules
import rssfeedredditdatabaseconfig # rss reddit news feed database config
import re as regEx # regular expression
import logging # logging
import logging.config # logging configuration
import json # json
import datetime # datetime
import pytz # pytz
import tzlocal # tz local
import sqlalchemy # sqlalchemy
import urllib # urllib
import urllib3 # urllib3
import html # html 3
import pathlib # pathlib
import csv # csv
import os # os
import traceback # traceback

# Class
class RssFeedRedditDatabaseClass:
  # Constructor
  def __init__(self):
    pass

  # extract url
  def extractrssfeed(self, feedtype):
    # initialize variable
    feedlist = []

    # Try to execute the command(s)
    try:
      # create object of rss reddit news feed parser config
      rfrdbconfig = rssfeedredditdatabaseconfig.RssFeedRedditDatabaseConfig()

      # set variables based on type
      rfrdbconfig._setConfigVars(feedtype)

      # get dictionary of values
      dictFeedType = rfrdbconfig._getConfigVars()

      # set file name
      urlstring = dictFeedType['MainURL'] + dictFeedType['RssURL'] + dictFeedType['RssLimit']

      # Retry options
      retryOptions = urllib3.util.Retry(
        total = 6,
        read = 6,
        redirect = 6,
        connect = 6,
        backoff_factor = 2,
        respect_retry_after_header = True,
        status_forcelist = [429, 500, 502, 503, 504],
        method_whitelist = ["HEAD", "GET", "OPTIONS"]
      )

      # Handles all of the details of connection pooling and thread safety
      http = urllib3.PoolManager(retries = retryOptions)

      # Pull rss feed from given url
      feedlist = http.request('GET', urlstring)

      # # Pull rss feed from given url
      # feedlist = urllib.request.urlopen(urlstring)
    except Exception as e:
      # Log string
      self._setLogger('issue extract rss feed ' + feedtype + ' ' + str(e))
      # print(str(e))

    # return built url string
    return feedlist

  # Delete temp news
  def _param01(self, type):
    # Initialize variable
    returnMessage = ''

    # Try to execute the command(s)
    try:
      # Open connection
      connectionStatus = self.__openConnection(type)

      # Check if element does not exists
      if connectionStatus.get('SError') == None and 'SError' not in connectionStatus:
        # Initialize parameter
        query = ''
        messageResponse = ''

        # MariaDB query statement
        if regEx.match(r'MariaDBSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("stored procedure call ('param01');")
        # PostgreSQL query statement
        elif regEx.match(r'PGSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("stored procedure call ('param01');")
        # MSSQL query statement
        elif regEx.match(r'MSSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("stored procedure call param01 = 'param01'")

        # Check if query is empty
        if query != '':
          # # Bind parameters with dictionary key
          # query = query.bindparams(
          # )

          # Execute many queries
          messageResponse = self.connection.execute(query)

          # # Fetch a record
          # fetchRecord = messageResponse.fetchone()

          # # Print message from database
          # print('Fetch record response: ' + str(fetchRecord))

          # Check if execution has executed
          if (messageResponse):
            # Close execution
            messageResponse.close()

        # Check if connection was established
        if (self.connection):
          # Close database connection
          self.connection.close()
      else:
        # Set message
        returnMessage = 'SError~' + connectionStatus['SError']
    except Exception as e:
      # Log string
      self._setLogger('Issue deleting temp news : ' + str(e))
      # print('Delete Temp News: ' + str(e))

      # Set message
      returnMessage = 'SError~Caught deleting temp news execution failure : ' + str(e)

    # Return message
    return returnMessage

  # Insert temp news
  def _param01(self, type, feedStorage):
    # Initialize variable
    returnMessage = ''

    # Try to execute the command(s)
    try:
      # Open connection
      connectionStatus = self.__openConnection(type)

      # Check if element does not exists
      if connectionStatus.get('SError') == None and 'SError' not in connectionStatus:
        # Initialize parameter
        query = ''
        messageResponse = ''

        # MariaDB query statement
        if regEx.match(r'MariaDBSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("stored procedure call ('param01', :Param01);")
        # PostgreSQL query statement
        elif regEx.match(r'PGSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("stored procedure call ('param01', :Param01);")
        # MSSQL query statement
        elif regEx.match(r'MSSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("stored procedure call param01 = 'param01')

        # Check if query is empty
        if query != '':
          # Bind parameters with dictionary key
          query = query.bindparams(
            sqlalchemy.bindparam("Param01")
          )

          # Execute many queries
          messageResponse = self.connection.execute(query, feedStorage)

          # # Fetch a record
          # fetchRecord = messageResponse.fetchone()

          # # Print message from database
          # print('Fetch record response: ' + str(fetchRecord))

          # Check if execution has executed
          if (messageResponse):
            # Close execution
            messageResponse.close()

        # Check if connection was established
        if (self.connection):
          # Close database connection
          self.connection.close()
      else:
        # Set message
        returnMessage = 'SError~' + connectionStatus['SError']
    except Exception as e:
      # Log string
      self._setLogger('Issue inserting temp news : ' + str(e))
      # print(str(e))

      # Set message
      returnMessage = 'SError~Caught inserting temp news execution failure : ' + str(e)

    # Return message
    return returnMessage

  # Update bulk news
  def _param01(self, type):
    # Initialize variable
    returnMessage = ''

    # Try to execute the command(s)
    try:
      # Open connection
      connectionStatus = self.__openConnection(type)

      # Check if element does not exists
      if connectionStatus.get('SError') == None and 'SError' not in connectionStatus:
        # Initialize parameter
        query = ''
        messageResponse = ''

        # MariaDB query statement
        if regEx.match(r'MariaDBSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("stored procedure call ('param01');")
        # PostgreSQL query statement
        elif regEx.match(r'PGSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("stored procedure call ('param01');")
        # MSSQL query statement
        elif regEx.match(r'MSSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("stored procedure call param01 = 'param01'")

        # Check if query is empty
        if query != '':
          # # Bind parameters with dictionary key
          # query = query.bindparams(
          # )

          # Execute many queries
          messageResponse = self.connection.execute(query)

          # # Fetch a record
          # fetchRecord = messageResponse.fetchone()

          # # Print message from database
          # print('Fetch record response: ' + str(fetchRecord))

          # Check if execution has executed
          if (messageResponse):
            # Close execution
            messageResponse.close()

        # Check if connection was established
        if (self.connection):
          # Close database connection
          self.connection.close()
      else:
        # Set message
        returnMessage = 'SError~' + connectionStatus['SError']
    except Exception as e:
      # Log string
      self._setLogger('Issue bulk updating news : ' + str(e))
      # print(str(e))

      # Set message
      returnMessage = 'SError~Caught bulk updating news execution failure : ' + str(e)

    # Return message
    return returnMessage

  # Insert bulk news
  def _param01(self, type):
    # Initialize variable
    returnMessage = ''

    # Try to execute the command(s)
    try:
      # Open connection
      connectionStatus = self.__openConnection(type)

      # Check if element does not exists
      if connectionStatus.get('SError') == None and 'SError' not in connectionStatus:
        # Initialize parameter
        query = ''
        messageResponse = ''

        # MariaDB query statement
        if regEx.match(r'MariaDBSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("stored procedure call ('param01');")
        # PostgreSQL query statement
        elif regEx.match(r'PGSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("stored procedure call ('param01');")
        # MSSQL query statement
        elif regEx.match(r'MSSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("stored procedure call param01 = 'param01'")

        # Check if query is empty
        if query != '':
          # # Bind parameters with dictionary key
          # query = query.bindparams(
          # )

          # Execute many queries
          messageResponse = self.connection.execute(query)

          # # Fetch a record
          # fetchRecord = messageResponse.fetchone()

          # # Print message from database
          # print('Fetch record response: ' + str(fetchRecord))

          # Check if execution has executed
          if (messageResponse):
            # Close execution
            messageResponse.close()

        # Check if connection was established
        if (self.connection):
          # Close database connection
          self.connection.close()
      else:
        # Set message
        returnMessage = 'SError~' + connectionStatus['SError']
    except Exception as e:
      # Log string
      self._setLogger('Issue bulk inserting news : ' + str(e))
      # print(str(e))

      # Set message
      returnMessage = 'SError~Caught bulk inserting news execution failure : ' + str(e)

    # Return message
    return returnMessage

  # Write data to CSV file
  def _writeToCSVFile(self, pathAndFileName, headData, dictData):
    # Initialize variable
    returnMessage = ''

    # Try to execute the command(s)
    try:
      # Write to CSV file using a context manager
      with open(pathAndFileName, 'w', newline = '', encoding = 'utf8') as csvExportFile:
        # Write set up the dictionary writer parameters
        writer = csv.DictWriter(csvExportFile, fieldnames = headData, quoting = csv.QUOTE_ALL)

        # Write header information
        writer.writeheader()

        # Write the rows from the dictionary
        writer.writerows(dictData)

      # Read and write to CSV file using a context manager
      with open(pathAndFileName, 'r+', newline = '', encoding = 'utf8') as csvExportFile:
        # Get the status of a file descriptor
        stat = os.fstat(csvExportFile.fileno())

        # Truncate the \r\n from the end of the file
        truncateResponse = csvExportFile.truncate(stat.st_size - 2)

      # System calls on path objects to instantiate concrete paths
      filenamePath = pathlib.Path(pathAndFileName)

      # Check if file exists and if file is a file
      if filenamePath.exists() and filenamePath.is_file():
        returnMessage = 'Success~CSV file exist'
      else:
        # Else issue with file
        returnMessage = 'SError~CSV file does not exist'
    # Set error message
    except Exception as e:
      # Set exception error
      returnMessage = 'SError~Caught - write to CSV file - ' + str(e)

      # Log string
      self._setLogger('SError~Caught - write to CSV file - ' + str(e))
      # print(str(e))

    # Return message
    return returnMessage

  # Write data to JSON file
  def _writeToJSONFile(self, pathAndFileName, dictData):
    # Initialize variable
    returnMessage = ''

    # Try to execute the command(s)
    try:
      # Write to JSON file
      with open(pathAndFileName, 'w', newline = '', encoding = 'utf8') as jsonExportFile:
        # Write JSON to a file
        # Keep Unicode characters untouched
        # Make JSON human readable "pretty printing"
        json.dump(dictData, jsonExportFile, ensure_ascii = False, indent = 2)

      # System calls on path objects to instantiate concrete paths
      filenamePath = pathlib.Path(pathAndFileName)

      # Check if file exists and if file is a file
      if filenamePath.exists() and filenamePath.is_file():
        returnMessage = 'Success~JSON file exist'
      else:
        # Else issue with file
        returnMessage = 'SError~JSON file does not exist'
    # Set error message
    except Exception as e:
      # Set exception error
      returnMessage = 'SError~Caught - write to JSON file - ' + str(e)

      # Log string
      self._setLogger('SError~Caught - write to JSON file - ' + str(e))
      # print(str(e))

    # Return message
    return returnMessage

  # Write data to file
  def _writeToFile(self, pathAndFileName, stringData):
    # Initialize variable
    returnMessage = ''

    # Try to execute the command(s)
    try:
      # Write to file
      with open(pathAndFileName, 'w', newline = '', encoding = 'utf8') as exportFile:
        # Write to a file
        exportFile.write(stringData)

      # System calls on path objects to instantiate concrete paths
      filenamePath = pathlib.Path(pathAndFileName)

      # Check if file exists and if file is a file
      if filenamePath.exists() and filenamePath.is_file():
        returnMessage = 'Success~File exist'
      else:
        # Else issue with file
        returnMessage = 'SError~File does not exist'
    # Set error message
    except Exception as e:
      # Set exception error
      returnMessage = 'SError~Caught - write to file - ' + str(e)

      # Log string
      self._setLogger('SError~Caught - write to file - ' + str(e))
      # print(str(e))

    # Return message
    return returnMessage

  # Open connection based on type
  def __openConnection(self, type = 'notype'):
    # Create empty dictionary
    returnDict = {}

    # Try to execute the command(s)
    try:
      # Create object of configuration script
      rfrdbconfig = rssfeedredditdatabaseconfig.RssFeedRedditDatabaseConfig()

      # Set variables based on type
      rfrdbconfig._setConfigVars(type)

      # Create empty dictionary
      conVars = {}

      # Get dictionary of values
      conVars = rfrdbconfig._getConfigVars()

      # Set credentials from dictionary
      self.Driver = conVars['Driver']
      self.DatabaseDialect = conVars['DatabaseDialect']
      self.Server = conVars['Servername']
      self.Port = conVars['Port']
      self.PathParent = conVars['PathParent']
      self.PathLevelOne = conVars['PathLevelOne']
      self.PathLevelTwo = conVars['PathLevelTwo']
      self.PathDB = conVars['PathDB']
      self.Database = conVars['Database']
      self.User = conVars['Username']
      self.Pass = conVars['Password']
      self.MainURL = conVars['MainURL']
      self.RssURL = conVars['RssURL']
      self.RssLimit = conVars['RssLimit']
      self.CategoryURL = conVars['CategoryURL']
      self.TorrentSearchURL = conVars['TorrentSearchURL']
      self.SearchEntryURL = conVars['SearchEntryURL']
      self.FilenameMedia = conVars['FilenameMedia']

      # Set connection to no connection
      self.connection = None

      # Check if database type is MySQL or the alternative MariaDB
      if regEx.match(r'MariaDBSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
        # # Set variable with string
        # print('mysql:host=' + self.Server + ';port=' + self.Port + ';dbname=' + self.Database, self.User, self.Pass)

        # Set engine
        # dialect+driver://username:password@host:port/database
        self.engine = sqlalchemy.create_engine(self.DatabaseDialect + self.User + ':' + self.Pass + '@' + self.Server + ':' + self.Port + '/' + self.Database + '?charset=utf8mb4&autocommit=true')
        # self.engine = sqlalchemy.create_engine(self.DatabaseDialect + self.User + ':' + self.Pass + '@' + self.Server + ':' + self.Port + '/' + self.Database + '?charset=utf8mb4&autocommit=true', echo=True) # for debugging purposes only

        # Connect to engine
        self.connection = self.engine.connect()

        # Set meta data based on engine
        metadata = sqlalchemy.MetaData(self.engine)

        # # Debugging purposes only
        # print ('Driver: ' + self.Driver + ' DatabaseDialect: ' + self.DatabaseDialect + ' ServerName: ' + self.Server + ' Connection successful<br /><br />')

        # # Check if connection was established
        # if (self.connection):
          # # Close database connection
          # self.connection.close()

      # Else check if database type is PGSQL
      elif regEx.match(r'PGSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
        # # Check else if database type is PostgreSQL
        # print('pgsql:host=' + self.Server + '; port=' + self.Port + '; dbname=' + self.Database + '; user=' + self.User + '; password=' + self.Pass + ';')

        # Set engine
        # dialect+driver://username:password@host:port/database
        self.engine = sqlalchemy.create_engine(self.DatabaseDialect + self.User + ':' + self.Pass + '@' + self.Server + ':' + self.Port + '/' + self.Database).execution_options(autocommit=True)
        # self.engine = sqlalchemy.create_engine(self.DatabaseDialect + self.User + ':' + self.Pass + '@' + self.Server + ':' + self.Port + '/' + self.Database, echo=True).execution_options(autocommit=True) # for debugging purposes only

        # Connect to engine
        self.connection = self.engine.connect()

        # Set meta data based on engine
        metadata = sqlalchemy.MetaData(self.engine)

        # # Debugging purposes only
        # print ('Driver: ' + self.Driver + ' DatabaseDialect: ' + self.DatabaseDialect + ' ServerName: ' + self.Server + ' Connection successful<br /><br />')

        # # Check if connection was established
        # if (self.connection):
          # # Close database connection
          # self.connection.close()

      # Else check if database type is MSSQL
      elif regEx.match(r'MSSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
        # # Check if database type is Microsoft
        # print('odbc:Driver=' + self.Driver + '; Servername=' + self.Server + '; Port=' + self.Port + '; Database=' + self.Database + '; UID=' + self.User + '; PWD=' + self.Pass + ';')

        # Set engine
        # dialect+driver://username:password@host:port/database
        params = urllib.parse.quote_plus('DRIVER={' + self.Driver + '};SERVER=' + self.Server + ';DATABASE=' + self.Database + ';UID=' + self.User + ';PWD=' + self.Pass + ';TDS_Version=8.0;Port=' + self.Port + ';')

        self.engine = sqlalchemy.create_engine(self.DatabaseDialect+ '?odbc_connect={}&autocommit=true'.format(params))
        # self.engine = sqlalchemy.create_engine(self.DatabaseDialect + '?odbc_connect={}&autocommit=true'.format(params), echo=True) # for debugging purposes only

        # Connect to engine
        self.connection = self.engine.connect()

        # Set meta data based on engine
        metadata = sqlalchemy.MetaData(self.engine)

        # # Debugging purposes only
        # print ('Driver: ' + self.Driver + ' DatabaseDialect: ' + self.DatabaseDialect + ' ServerName: ' + self.Server + ' Connection successful<br /><br />')
      else:
        # Set server error
        returnDict['SError'] = 'Cannot connect to the database'
    # Set error message
    except Exception as e:
      # Set exception error
      returnDict['SError'] = 'Caught - cannot connect to the database - ' + str(e)

      # Log string
      self._setLogger('SError~Caught - cannot connect to the database - ' + str(e))
      # print(str(e))

    # Return message
    return returnDict

  # Set Logger
  def _setLogger(self, logString):
    # Initialize dictionary
    config_dict = {}

    # create object of rss news feed parser config
    rfrdbconfig = rssfeedredditdatabaseconfig.RssFeedRedditDatabaseConfig()

    # Set variables based on type
    rfrdbconfig._setFilenameVars('Log')

    # Get dictionary of values
    dictFeedType = rfrdbconfig._getFilenameVars()

    # Set path
    pathDirectory = dictFeedType['pathParent'] + dictFeedType['pathLevelOne'] + dictFeedType['pathLevelTwo']

    # Set variable
    pathResourceFolder = pathlib.Path(pathDirectory)

    # Check if the following directory and or file exists
    if not pathResourceFolder.exists():
      # Recursively creates the directory and does not raise an exception if the directory already exist
      # Parent can be skipped as an argument if not needed or want to create parent directory
      pathlib.Path(pathResourceFolder).mkdir(parents=True, exist_ok=True)

    # Set file name
    logFilename = pathDirectory + dictFeedType['filenameMedia']

    # Set variable for JSON configuration
    logConfigFilename = pathlib.Path('/path/to/dict/config/file/logging_dictConfig.json')

    # Check if file exists and if file is a file
    if logConfigFilename.exists() and logConfigFilename.is_file():
      # Open the file as read
      with open('/path/to/dict/config/file/logging_dictConfig.json', 'r', newline = '', encoding = 'utf8') as jsonConfigRead:
        # Read and set configuration
        config_dict = json.load(jsonConfigRead)

      # Close file
      jsonConfigRead.close()

      ## Set configuration based on JSON schema
      logging.config.dictConfig(config_dict)
    else:
      # Configure basic logging
      # logging.basicConfig(filename=logFilename,level=logging.INFO, format='{"": %(asctime)s, "": %(levelname)s, "": %(levelno)s, "": %(module)s, "": %(pathname)s, "": %(filename)s, "": %(lineno)d, "": %(funcName)s, "": %(message)s}')
      logging.basicConfig(filename=logFilename,level=logging.DEBUG, format='%(asctime)s - %(levelname)s:%(levelno)s [%(module)s] [%(pathname)s:%(filename)s:%(lineno)d:%(funcName)s] %(message)s')

    # # Set info logger
    # logger = logging.getLogger('info')

    # # Log string for info and provide traceback with exc_info=true
    # logger.info(logString, exc_info=True)
    # # logger.info((regEx.sub(r" +", ' ', regEx.sub(r"\n", ' ', logString)) + regEx.sub(r" +", ' ', regEx.sub(r"\n", ' ', traceback.format_exc()))).strip())

    # Set error logger
    logger = logging.getLogger('error')

    # Log string for errors and provide traceback with exc_info=true
    logger.error(logString, exc_info=True)

    # print (logging.getLogRecordFactory())
    # logger.error((regEx.sub(r" +", ' ', regEx.sub(r"\n", ' ', logString)) + regEx.sub(r" +", ' ', regEx.sub(r"\n", ' ', traceback.format_exc()))).strip())

    # Get current time stamp
    dateTimeObj = datetime.datetime.now()

    # Convert date time to string
    timestampStr = dateTimeObj.strftime('%Y-%m-%d %H:%M:%S.%f')

    # Check if path exist and check if file size is empty
    if os.path.exists('/path/to/error/file/log/errors_log.json') and os.stat('/path/to/error/file/log/errors_log.json').st_size == 0:
      # Restructure JSON output
      feedStorageNested = {'news': {'created_date': timestampStr, 'updated_date': timestampStr, 'count': 1, 'children': [{'timestamp': timestampStr, 'error': (regEx.sub(r" +", ' ', regEx.sub(r"\n", ' ', logString))).strip(), 'traceback': (regEx.sub(r" +", ' ', regEx.sub(r"\n", ' ', traceback.format_exc()))).strip()}]}}

      # Write to json file
      self._writeToJSONFile('/path/to/error/file/log/errors_log.json', feedStorageNested)
    else:
      # File does not exist or size greater than zero (0)
      # Try the following code
      try:
        # Read from file
        with open('/path/to/error/file/log/errors_log.json', 'r', newline = '', encoding = 'utf8') as jsonFile:
          # Convert JSON to dictionary
          jsonData = json.load(jsonFile)

        # Check if element exists
        if jsonData.get('news', {}).get('children') != None:
          # Add another parameter at the next level
          jsonData['news']['children'].append({'timestamp': timestampStr, 'error': (regEx.sub(r" +", ' ', regEx.sub(r"\n", ' ', logString))).strip(), 'traceback': (regEx.sub(r" +", ' ', regEx.sub(r"\n", ' ', traceback.format_exc()))).strip()})

          # Retrieve count of data
          dataLength = len(jsonData['news']['children'])

          # Increment the count
          jsonData['news']['count'] = dataLength

          # Update the date
          jsonData['news']['updated_date'] = timestampStr

          # Write to json file
          self._writeToJSONFile('/path/to/error/file/log/errors_log.json', jsonData)
        else:
          # Rewrite the log file as there were issues with the current file
          # Restructure JSON output
          feedStorageNested = {'news': {'created_date': timestampStr, 'updated_date': timestampStr, 'count': 1, 'children': [{'timestamp': timestampStr, 'error': (regEx.sub(r" +", ' ', regEx.sub(r"\n", ' ', logString))).strip(), 'traceback': (regEx.sub(r" +", ' ', regEx.sub(r"\n", ' ', traceback.format_exc()))).strip()}]}}

          # Write to json file
          self._writeToJSONFile('/path/to/error/file/log/errors_log.json', feedStorageNested)
      except ValueError as ve:
        # Restructure JSON output
        feedStorageNested = {'news': {'created_date': timestampStr, 'updated_date': timestampStr, 'count': 1, 'children': [{'timestamp': timestampStr, 'error': (regEx.sub(r" +", ' ', regEx.sub(r"\n", ' ', str(ve)))).strip(), 'traceback': (regEx.sub(r" +", ' ', regEx.sub(r"\n", ' ', traceback.format_exc()))).strip()}]}}

        # Write to json file
        self._writeToJSONFile('/path/to/error/file/log/errors_log.json', feedStorageNested)

    # # Set root logger
    # logger = logging.getLogger(__name__)

    # # Log string for debugging and provide traceback with exc_info=true
    # logger.debug(logString, exc_info=True)
    # # logger.debug((regEx.sub(r" +", ' ', regEx.sub(r"\n", ' ', logString)) + regEx.sub(r" +", ' ', regEx.sub(r"\n", ' ', traceback.format_exc()))).strip())