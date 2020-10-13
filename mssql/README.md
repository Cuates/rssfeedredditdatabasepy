# MSSQL Function, Index, Stored Procedure, Table, and or View
> MSSQL database schema for this project

## Table of Contents
* [Important Note](#important-note)
* [Dependent MSSQL Function](#dependent-mssql-function)
* [Prerequisite Data Types](#prerequisite-data-types)
* [Prerequisite Functions](#prerequisite-functions)
* [Prerequisite Conditions](#prerequisite-conditions)
* [Stored Procedure Usage](#stored-procedure-usage)

### **Important Note**
* This project was written with SQL Server 2019 methods

### Dependent MSSQL Function
* [Omit Characters](https://github.com/Cuates/omitcharactersmssql)

### Prerequisite Data Types
* bigint
* nvarchar
* datetime2

### Prerequisite Functions
* substring
* nullif
* try_cast
* error_number
* error_line
* error_message
* trim
* cast
* dateadd
* max
* iif

### Prerequisite Conditions
* N/A

### Stored Procedure Usage
* `dbo.insertupdatedeleteNewsFeed @optionMode = 'deleteTempNews'`
* `dbo.insertupdatedeleteNewsFeed @optionMode = 'insertTempNews', @title = 'titleValue', @imageurl = 'imageUrlValue', @feedurl = 'feedUrlValue', @actualurl = 'actualUrlValue', @publishDate = '2020-10-13 00:00:00'`
* `dbo.insertupdatedeleteNewsFeed @optionMode = 'updateBulkNews'`
* `dbo.insertupdatedeleteNewsFeed @optionMode = 'insertBulkNews'`
