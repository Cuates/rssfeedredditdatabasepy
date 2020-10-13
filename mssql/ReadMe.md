# MSSQL Function, Index, Stored Procedure, Table, and or View
> MSSQL database schema for this project

## Table of Contents
* [Important Note](#important-note)
* [Dependent MSSQL Function](#dependent-mssql-function)
* [Prerequisite Data Types](#prerequisite-data-types)
* [Prerequisite Functions](#prerequisite-functions)
* [Prerequisite Conditions](#prerequisite-conditions)
* [Usage](#usage)

### **Important Note**
* This project was written with SQL Server 2019 methods

### Dependent MSSQL Function
* [Omit Characters](https://github.com/Cuates/omitcharactersmssql)

### Prerequisite Data Types
* bigint
* int
* nvarchar
* datetime2
* bit

### Prerequisite Functions
* substring
* nullif
* try_cast
* error_number
* error_line
* error_message
* lower
* iif
* datepart
* cast
* dateadd
* trim
* max
* concat

### Prerequisite Conditions
* not in

### Stored Procedure Usage
* `dbo.insertupdatedeleteMediaFeed @optionMode = 'deleteTempMovie'`
* `dbo.insertupdatedeleteMediaFeed @optionMode = 'deleteTempTV'`
* `dbo.insertupdatedeleteMediaFeed @optionMode = 'insertTempMovie'`, @titleLong = 'titleLongValue', @titleShort = 'titleShortValue', @publishDate = '2020-10-13 00:00:00'
* `dbo.insertupdatedeleteMediaFeed @optionMode = 'insertTempTV'`, @titleLong = 'titleLongValue', @titleShort = 'titleShortValue', @publishDate = '2020-10-13 00:00:00'
* `dbo.insertupdatedeleteMediaFeed @optionMode = 'updateBulkMovie'`
* `dbo.insertupdatedeleteMediaFeed @optionMode = 'updateBulkTV'`
* `dbo.insertupdatedeleteMediaFeed @optionMode = 'insertBulkMovie'`
* `dbo.insertupdatedeleteMediaFeed @optionMode = 'insertBulkTV'`
