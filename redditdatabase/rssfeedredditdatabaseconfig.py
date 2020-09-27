##
#        File: rssfeedredditdatabaseconfig.py
#     Created: 09/13/2020
#     Updated: 09/27/2020
#  Programmer: Cuates
#  Updated By: Cuates
#     Purpose: RSS news feed database Configuration
##

# Import modules
import re as regEx # regular expression

# Class
class RssFeedRedditDatabaseConfig:
  # Declare protected variables
  _mainURL = None
  _categoryURL = None
  _rssLimit = None
  _rssURL = None
  _torrentSearchURL = None
  _searchEntryURL = None
  _filenameIgnore = None
  _filenameDelete = None
  _pathParent = None
  _pathLevelOne = None
  _pathLevelTwo = None
  _filenameMedia = None
  _driver = None
  _serverName = None
  _port = None
  _database = None
  _username = None
  _password = None
  _pathDB = None

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
      # Check if type is SQLite
      if type == 'SQLiteNews':
        # Set variables
        self._driver = 'sqlite:///'
        self._servername = ''
        self._port = ''
        self._pathParent = '/<path>/resource'
        self._pathLevelOne = '/database'
        self._pathLevelTwo = ''
        self._filenameMedia = ''
        # self._pathDB = '/RssFeedNews.sqlite3'
        self._pathDB = '/RssFeedNewsListTest.sqlite3'
        self._database = self._pathParent  + self._pathLevelOne + self._pathLevelTwo + self._pathDB
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
        self._categoryURL = ''
        self._torrentSearchURL = ''
        self._searchEntryURL = ''
      # Else check if type is MySQL
      elif type == 'MySQLNews':
        # Set variables
        self._driver = 'driver'
        self._servername = 'servername'
        self._port = 'port'
        self._pathParent = ''
        self._pathLevelOne = ''
        self._pathLevelTwo = ''
        self._filenameMedia = ''
        self._pathDB = ''
        self._database = 'database'
        self._username = 'username'
        self._password = 'password'
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
        self._categoryURL = ''
        self._torrentSearchURL = ''
        self._searchEntryURL = ''
      # Else check if type is PGSQL
      elif type == 'PGSQLNews':
        # Set variables
        self._driver = 'driver'
        self._servername = 'servername'
        self._port = 'port'
        self._pathParent = ''
        self._pathLevelOne = ''
        self._pathLevelTwo = ''
        self._filenameMedia = ''
        self._pathDB = ''
        self._database = 'database'
        self._username = 'username'
        self._password = 'password'
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
        self._categoryURL = ''
        self._torrentSearchURL = ''
        self._searchEntryURL = ''
      # Else check if type is FreeTDS
      elif type == 'FreeTDSNews':
        # Set variables
        self._driver = 'driver'
        self._servername = 'servername'
        self._port = 'port'
        self._pathParent = ''
        self._pathLevelOne = ''
        self._pathLevelTwo = ''
        self._filenameMedia = ''
        self._pathDB = ''
        self._database = 'database'
        self._username = 'username'
        self._password = 'password'
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
        self._categoryURL = ''
        self._torrentSearchURL = ''
        self._searchEntryURL = ''
      # Else check if type is Reddit News
      elif type == 'RedditNews':
        # Set variables
        self._driver = ''
        self._servername = ''
        self._port = ''
        self._pathParent = ''
        self._pathLevelOne = ''
        self._pathLevelTwo = ''
        self._filenameMedia = ''
        self._pathDB = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = '<URL>'
        self._rssURL = '<rssURL>?'
        self._rssLimit = 'limit=1'
        self._categoryURL = ''
        self._torrentSearchURL = ''
        self._searchEntryURL = ''
      # Else check if type is log rss
      elif type == 'LogRss':
        # Set variables
        self._driver = ''
        self._servername = ''
        self._port = ''
        self._pathParent = '/<path>/resource'
        self._pathLevelOne = '/log'
        self._pathLevelTwo = ''
        self._filenameMedia = '/rssnewsdatabasepy.log'
        self._pathDB = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
        self._categoryURL = ''
        self._torrentSearchURL = ''
        self._searchEntryURL = ''
      # Else
      else:
        self._driver = ''
        self._servername = ''
        self._port = ''
        self._pathParent = ''
        self._pathLevelOne = ''
        self._pathLevelTwo = ''
        self._filenameMedia = ''
        self._pathDB = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
        self._categoryURL = ''
        self._torrentSearchURL = ''
        self._searchEntryURL = ''
    else:
      # Else set development database information
      # Check if type is SQLite
      if type == 'SQLiteNews':
        # Set variables
        self._driver = 'sqlite:///'
        self._servername = ''
        self._port = ''
        self._pathParent = '/<path>/resource'
        self._pathLevelOne = '/database'
        self._pathLevelTwo = ''
        self._filenameMedia = ''
        # self._pathDB = '/RssFeedNews.sqlite3'
        self._pathDB = '/RssFeedNewsListTest.sqlite3'
        self._database = self._driver + self._pathParent  + self._pathLevelOne + self._pathLevelTwo + self._pathDB
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
        self._categoryURL = ''
        self._torrentSearchURL = ''
        self._searchEntryURL = ''
      # Else check if type is MySQL
      elif type == 'MySQLNews':
        # Set variables
        self._driver = 'driver'
        self._servername = 'servername'
        self._port = 'port'
        self._pathParent = ''
        self._pathLevelOne = ''
        self._pathLevelTwo = ''
        self._filenameMedia = ''
        self._pathDB = ''
        self._database = 'database'
        self._username = 'username'
        self._password = 'password'
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
        self._categoryURL = ''
        self._torrentSearchURL = ''
        self._searchEntryURL = ''
      # Else check if type is PGSQL
      elif type == 'PGSQLNews':
        # Set variables
        self._driver = 'driver'
        self._servername = 'servername'
        self._port = 'port'
        self._pathParent = ''
        self._pathLevelOne = ''
        self._pathLevelTwo = ''
        self._filenameMedia = ''
        self._pathDB = ''
        self._database = 'database'
        self._username = 'username'
        self._password = 'password'
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
        self._categoryURL = ''
        self._torrentSearchURL = ''
        self._searchEntryURL = ''
      # Else check if type is FreeTDS
      elif type == 'FreeTDSNews':
        # Set variables
        self._driver = 'driver'
        self._servername = 'servername'
        self._port = 'port'
        self._pathParent = ''
        self._pathLevelOne = ''
        self._pathLevelTwo = ''
        self._filenameMedia = ''
        self._pathDB = ''
        self._database = 'database'
        self._username = 'username'
        self._password = 'password'
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
        self._categoryURL = ''
        self._torrentSearchURL = ''
        self._searchEntryURL = ''
      # Else check if type is Reddit News
      elif type == 'RedditNews':
        # Set variables
        self._driver = ''
        self._servername = ''
        self._port = ''
        self._pathParent = ''
        self._pathLevelOne = ''
        self._pathLevelTwo = ''
        self._filenameMedia = ''
        self._pathDB = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = '<URL>'
        self._rssURL = '<rssURL>?'
        self._rssLimit = 'limit=1'
        self._categoryURL = ''
        self._torrentSearchURL = ''
        self._searchEntryURL = ''
      # Else check if type is log rss
      elif type == 'LogRss':
        # Set variables
        self._driver = ''
        self._servername = ''
        self._port = ''
        self._pathParent = '/<path>/resource'
        self._pathLevelOne = '/log'
        self._pathLevelTwo = ''
        self._filenameMedia = '/rssredditdatabasepy.log'
        self._pathDB = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
        self._categoryURL = ''
        self._torrentSearchURL = ''
        self._searchEntryURL = ''
      # Else
      else:
        self._driver = ''
        self._servername = ''
        self._port = ''
        self._pathParent = ''
        self._pathLevelOne = ''
        self._pathLevelTwo = ''
        self._filenameMedia = ''
        self._pathDB = ''
        self._database = ''
        self._username = ''
        self._password = ''
        self._mainURL = ''
        self._rssURL = ''
        self._rssLimit = ''
        self._categoryURL = ''
        self._torrentSearchURL = ''
        self._searchEntryURL = ''

  # Get database variable
  def _getConfigVars(self):
    return {'Driver': self._driver, 'Servername': self._servername, 'Port': self._port, 'PathParent': self._pathParent, 'PathLevelOne': self._pathLevelOne, 'PathLevelTwo': self._pathLevelTwo, 'PathDB': self._pathDB, 'Database': self._database, 'Username': self._username, 'Password': self._password, 'MainURL': self._mainURL, 'RssURL': self._rssURL, 'RssLimit': self._rssLimit, 'CategoryURL': self._categoryURL, 'TorrentSearchURL': self._torrentSearchURL, 'SearchEntryURL': self._searchEntryURL, 'FilenameMedia': self._filenameMedia}

  # Set filename variable
  def _setFilenameVars(self, feedAction):
    # Check if media action type is log
    if regEx.search(r'\bLog\b', feedAction, flags=regEx.IGNORECASE):
      self._pathParent = '/<path>/resource'
      self._pathLevelOne = '/log'
      self._pathLevelTwo = ''
      self._filenameMedia = '/rssredditfeedpy.log'
    else:
      self._pathParent = ''
      self._pathLevelOne = ''
      self._pathLevelTwo = ''
      self._filenameMedia = ''

  # Get filename variable
  def _getFilenameVars(self):
    return {'pathParent': self._pathParent, 'pathLevelOne': self._pathLevelOne, 'pathLevelTwo': self._pathLevelTwo, 'filenameMedia': self._filenameMedia}