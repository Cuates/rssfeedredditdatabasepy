##
#        File: rssfeedredditdatabaseclass.py
#     Created: 09/13/2020
#     Updated: 09/27/2020
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
from sqlalchemy import event # sqlalchemy event
#import pythonjsonlogger # python json logger
import sqlite3 # sqlite3
import urllib # urllib
import urllib3 # urllib3
#from urllib import request # urllib request
import html # html 3
import pathlib # pathlib

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
  def _deleteTempNews(self, type):
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

        # SQLite query statement
        if regEx.match(r'SQLite[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("")
        # MySQL query statement
        elif regEx.match(r'MySQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("call storedprocedure ('parameter', '', '', '', '', '');")
        # PostgreSQL query statement
        elif regEx.match(r'PGSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("call storedprocedure ('parameter', '', '', '', '', '');")
        # MSSQL query statement
        elif regEx.match(r'FreeTDS[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("exec dbo.storedprocedure @parameter = 'parameter'")

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
  def _insertTempNews(self, type, feedStorage):
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

        # SQLite query statement
        if regEx.match(r'SQLite[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("")
        # MySQL query statement
        elif regEx.match(r'MySQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("call storedprocedure ('parameter', :parameter02, :parameter03, :parameter04, :parameter05, :parameter06);")
        # PostgreSQL query statement
        elif regEx.match(r'PGSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("call storedprocedure ('parameter', :parameter02, :parameter03, :parameter04, :parameter05, :parameter06);")
        # MSSQL query statement
        elif regEx.match(r'FreeTDS[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("exec dbo.storedprocedure @parameter = 'parameter', @parameter02 = :parameter02,  @parameter03 = :parameter03,  @parameter04 = :parameter04,  @parameter05 = :parameter05,  @parameter06 = :parameter06")

        # Check if query is empty
        if query != '':
          # Bind parameters with dictionary key
          query = query.bindparams(
            sqlalchemy.bindparam("parameter02"),
            sqlalchemy.bindparam("parameter03"),
            sqlalchemy.bindparam("parameter04"),
            sqlalchemy.bindparam("parameter05"),
            sqlalchemy.bindparam("parameter06")
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
  def _updateBulkNews(self, type):
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

        # SQLite query statement
        if regEx.match(r'SQLite[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("")
        # MySQL query statement
        elif regEx.match(r'MySQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("call storedprocedure ('parameter', '', '', '', '', '');")
        # PostgreSQL query statement
        elif regEx.match(r'PGSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("call storedprocedure ('parameter', '', '', '', '', '');")
        # MSSQL query statement
        elif regEx.match(r'FreeTDS[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("exec dbo.storedprocedure @parameter = 'parameter'")

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
      #print(str(e))

      # Set message
      returnMessage = 'SError~Caught bulk updating news execution failure : ' + str(e)

    # Return message
    return returnMessage

  # Insert bulk news
  def _insertBulkNews(self, type):
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

        # SQLite query statement
        if regEx.match(r'SQLite[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("")
        # MySQL query statement
        elif regEx.match(r'MySQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("call storedprocedure ('parameter', '', '', '', '', '');")
        # PostgreSQL query statement
        elif regEx.match(r'PGSQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("call storedprocedure ('parameter', '', '', '', '', '');")
        # MSSQL query statement
        elif regEx.match(r'FreeTDS[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
          # Convert statement to text
          query = sqlalchemy.text("exec dbo.storedprocedure @optionMode = 'parameter'")

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

      # Check if string is SQLite
      if regEx.match(r'SQLite[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
        # # Set variable with string
        # print('sqlite:dbname=' + self.Database)

        # # Set engine
        self.engine = sqlalchemy.create_engine(self.Database)
        # self.engine = sqlalchemy.create_engine(self.Database, echo=True) # for debugging purposes only

        # Connect to engine
        self.connection = self.engine.connect

      # Else check if database type is MySQL or the alternative MariaDB
      elif regEx.match(r'MySQL[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
        # # Set variable with string
        # print('mysql:host=' + self.Server + ';port=' + self.Port + ';dbname=' + self.Database, self.User, self.Pass)

        # Set engine
        # dialect+driver://username:password@host:port/database
        self.engine = sqlalchemy.create_engine('mysql://' + self.User + ':' + self.Pass + '@' + self.Server + ':' + self.Port + '/' + self.Database + '?charset=utf8mb4&autocommit=true')
        # self.engine = sqlalchemy.create_engine('mysql://' + self.User + ':' + self.Pass + '@' + self.Server + ':' + self.Port + '/' + self.Database + '?charset=utf8mb4&autocommit=true', echo=True) # for debugging purposes only

        # Connect to engine
        self.connection = self.engine.connect()

        # Set meta data based on engine
        metadata = sqlalchemy.MetaData(self.engine)

        # # Debugging purposes only
        # print ('Driver: ' + self.Driver + ' ServerName: ' + self.Server + ' Connection successful<br /><br />')

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
        self.engine = sqlalchemy.create_engine('postgresql://' + self.User + ':' + self.Pass + '@' + self.Server + ':' + self.Port + '/' + self.Database).execution_options(autocommit=True)
        # self.engine = sqlalchemy.create_engine('postgresql://' + self.User + ':' + self.Pass + '@' + self.Server + ':' + self.Port + '/' + self.Database, echo=True).execution_options(autocommit=True) # for debugging purposes only

        # Connect to engine
        self.connection = self.engine.connect()

        # Set meta data based on engine
        metadata = sqlalchemy.MetaData(self.engine)

        # # Debugging purposes only
        # print ('Driver: ' + self.Driver + ' ServerName: ' + self.Server + ' Connection successful<br /><br />')

        # # Check if connection was established
        # if (self.connection):
          # # Close database connection
          # self.connection.close()

      # Else check if databaswe type is FreeTDS
      elif regEx.match(r'FreeTDS[a-zA-Z]{0,}', type, flags=regEx.IGNORECASE):
        # # Check if database type is Microsoft
        # print('odbc:Driver=' + self.Driver + '; Servername=' + self.Server + '; Port=' + self.Port + '; Database=' + self.Database + '; UID=' + self.User + '; PWD=' + self.Pass + ';')

        # Set engine
        # dialect+driver://username:password@host:port/database
        params = urllib.parse.quote_plus('DRIVER={' + self.Driver + '};SERVER=' + self.Server + ';DATABASE=' + self.Database + ';UID=' + self.User + ';PWD=' + self.Pass + ';TDS_Version=8.0;Port=' + self.Port + ';')

        self.engine = sqlalchemy.create_engine('mssql+pyodbc:///?odbc_connect={}&autocommit=true'.format(params))
        # self.engine = sqlalchemy.create_engine('mssql+pyodbc:///?odbc_connect={}&autocommit=true'.format(params), echo=True) # for debugging purposes only

        # Connect to engine
        self.connection = self.engine.connect()

        # Set meta data based on engine
        metadata = sqlalchemy.MetaData(self.engine)

        # # Debugging purposes only
        # print ('Driver: ' + self.Driver + ' ServerName: ' + self.Server + ' Connection successful<br /><br />')
      else:
        # Set server error
        returnDict['SError'] = 'Cannot connect to the database'
    # Set error message
    except Exception as e:
      # Set execption error
      returnDict['SError'] = 'Caught - cannot connect to the database - ' + str(e)

      # Log string
      self._setLogger('SError~Caught - cannot connect to the database - ' + str(e))
      #print(str(e))

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
    logConfigFilename = pathlib.Path('/<path>/logging_dictConfig.json')

    # Check if file exists and if file is a file
    if logConfigFilename.exists() and logConfigFilename.is_file():
      # Open the file as read
      with open('/<path>/logging_dictConfig.json', 'r') as jsonConfigRead:
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
    # logger = logging.getLogger('rssnewsfeedinfo')

    # # Log string for info and provide traceback with exc_info=true
    # logger.info(logString, exc_info=True)

    # Set error logger
    logger = logging.getLogger('rssnewsfeederror')

    # Log string for errors and provide traceback with exc_info=true
    logger.error(logString, exc_info=True)

    # # Set root logger
    # logger = logging.getLogger(__name__)

    # # Log string for debugging and provide traceback with exc_info=true
    # logger.debug(logString, exc_info=True)