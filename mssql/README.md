# MSSQL Function, Index, Stored Procedure, Table, and or View
> MSSQL database schema for this project

## Table of Contents
* [Important Note](#important-note)
* [Dependent MSSQL Function](#dependent-mssql-function)
* [Stored Procedure Usage](#stored-procedure-usage)

### **Important Note**
* This project was written with SQL Server 2019 methods

### Dependent MSSQL Function
* [Omit Characters](https://github.com/Cuates/omitcharactersmssql)

### Stored Procedure Usage
* `exec dbo.insertupdatedeleteBulkNewsFeed @optionMode = 'deleteTempNews'`
* `exec dbo.insertupdatedeleteBulkNewsFeed @optionMode = 'insertTempNews', @title = 'titleValue', @imageurl = 'imageUrlValue', @feedurl = 'feedUrlValue', @actualurl = 'actualUrlValue', @publishDate = '2020-10-13 00:00:00'`
* `exec dbo.insertupdatedeleteBulkNewsFeed @optionMode = 'updateBulkNews'`
* `exec dbo.insertupdatedeleteBulkNewsFeed @optionMode = 'insertBulkNews'`
