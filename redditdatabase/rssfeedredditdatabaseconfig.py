##
#        File: rssfeedredditdatabaseconfig.py
#     Created: 09/13/2020
#     Updated: 11/25/2020
#  Programmer: Cuates
#  Updated By: Cuates
#     Purpose: RSS news feed database Configuration
##

# Import modules
import re as regEx # regular expression

# Class
class RssFeedRedditDatabaseConfig:
  # Declare protected variables
  _driver = None
  _databasedialect = None
  _serverName = None
  _port = None
  _database = None
  _username = None
  _password = None
  _mainURL = None
  _rssLimit = None
  _rssURL = None
  _filename = None
  _pathParent = None
  _pathLevelOne = None
  _pathLevelTwo = None
  _logFilename = None
  _jsonConfigLogFilename = None
  _jsonErrorLogFilename = None
  _csvErrorLogFilename = None
  _logDebugFilename = None
  _logInfoFilename = None
  _logErrorFilename = None

  # Constructor
  def __init__(self):
    pass

  # Set database variable
  def _setConfigVars(self, type):
    # Define server information
    ServerInfo = 'DEV-SERVER'

    # Define list of dev words
    ServerType = ['dev']

    # Set production database information where server info does not consist of server type
    if not regEx.search(r'\b' + "|".join(ServerType) + r'\b', ServerInfo, flags=regEx.IGNORECASE):
      # Check if type is MariaDB
      if type == 'MariaDBSQLNews':
        # Set variables
        self._driver = 'MariaDB'
        self._databasedialect = 'mysql://'
        self._servername = ''
        self._port = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
      # Else check if type is PGSQL
      elif type == 'PGSQLNews':
        # Set variables
        self._driver = 'PostgreSQL'
        self._databasedialect = 'postgresql://'
        self._servername = ''
        self._port = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
      # Else check if type is MSSQL Linux
      elif type == 'MSSQLLNews':
        # Set variables
        self._driver = 'ODBC Driver 17 for SQL Server'
        self._databasedialect = 'mssql+pyodbc:///'
        self._servername = ''
        self._port = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
      # Else check if type is MSSQL Windows
      elif type == 'MSSQLWNews':
        # Set variables
        self._driver = 'ODBC Driver 17 for SQL Server'
        self._databasedialect = 'mssql+pyodbc:///'
        self._servername = ''
        self._port = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
      # Else check if type is Reddit News
      elif type == 'RedditNews':
        # Set variables
        self._driver = ''
        self._databasedialect = ''
        self._servername = ''
        self._port = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = 'https://www.reddit.com/'
        self._rssURL = 'user/<username>/m/allnews/new.json?'
        self._rssLimit = 'limit=100'
      # Else
      else:
        self._driver = ''
        self._databasedialect = ''
        self._servername = ''
        self._port = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
    else:
      # Else set development database information
      # Check if type is MariaDB
      if type == 'MariaDBSQLNews':
        # Set variables
        self._driver = 'MariaDB'
        self._databasedialect = 'mysql://'
        self._servername = ''
        self._port = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
      # Else check if type is PGSQL
      elif type == 'PGSQLNews':
        # Set variables
        self._driver = 'PostgreSQL'
        self._databasedialect = 'postgresql://'
        self._servername = ''
        self._port = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
      # Else check if type is MSSQL Linux
      elif type == 'MSSQLLNews':
        # Set variables
        self._driver = 'ODBC Driver 17 for SQL Server'
        self._databasedialect = 'mssql+pyodbc:///'
        self._servername = ''
        self._port = ''
        self._database = 'media'
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
      # Else check if type is MSSQL Windows
      elif type == 'MSSQLWNews':
        # Set variables
        self._driver = 'ODBC Driver 17 for SQL Server'
        self._databasedialect = 'mssql+pyodbc:///'
        self._servername = ''
        self._port = ''
        self._database = 'media'
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
      # Else check if type is Reddit News
      elif type == 'RedditNews':
        # Set variables
        self._driver = ''
        self._databasedialect = ''
        self._servername = ''
        self._port = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = 'https://www.reddit.com/'
        self._rssURL = 'user/<username>/m/allnews/new.json?'
        self._rssLimit = 'limit=100'
      # Else
      else:
        self._driver = ''
        self._databasedialect = ''
        self._servername = ''
        self._port = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''

  # Get database variable
  def _getConfigVars(self):
    return {'Driver': self._driver, 'DatabaseDialect': self._databasedialect, 'Servername': self._servername, 'Port': self._port, 'Database': self._database, 'Username': self._username, 'Password': self._password, 'MainURL': self._mainURL, 'RssURL': self._rssURL, 'RssLimit': self._rssLimit}

  # Set filename variable
  def _setFilenameVars(self, feedAction):
    # Check if media action type is log
    if regEx.search(r'\bLog\b', feedAction, flags=regEx.IGNORECASE):
      self._filename = 'rssfeedredditdatabase'
      self._pathParent = '/path/to/' + self._filename
      self._pathLevelOne = '/resource'
      self._pathLevelTwo = '/log'
      self._jsonConfigLogFilename = '/logging_dictConfig.json'
      self._logFilename = '/' + self._filename + 'py.log'
      self._logDebugFilename = '/debug.log'
      self._logInfoFilename = '/info.log'
      self._logErrorFilename = '/errors.log'
      self._jsonErrorLogFilename = '/errors_log.json'
      self._csvErrorLogFilename = '/errors_log.csv'
    else:
      self._filename = ''
      self._pathParent = ''
      self._pathLevelOne = ''
      self._pathLevelTwo = ''
      self._jsonConfigLogFilename = ''
      self._logFilename = ''
      self._logDebugFilename = ''
      self._logInfoFilename = ''
      self._logErrorFilename = ''
      self._jsonErrorLogFilename = ''
      self._csvErrorLogFilename = ''

  # Get filename variable
  def _getFilenameVars(self):
    return {'filename': self._filename, 'pathParent': self._pathParent, 'pathLevelOne': self._pathLevelOne, 'pathLevelTwo': self._pathLevelTwo, 'JSONConfigLogFilename': self._jsonConfigLogFilename, 'LogFilename': self._logFilename, 'LogDebugFilename': self._logDebugFilename, 'LogInfoFilename': self._logInfoFilename, 'LogErrorFilename': self._logErrorFilename, 'JSONErrorLogFilename': self._jsonErrorLogFilename, 'CSVErrorLogFilename': self._csvErrorLogFilename}