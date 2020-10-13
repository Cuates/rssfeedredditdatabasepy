# MariaDB SQL Function, Index, Stored Procedure, Table, and or View
> MariaDB SQL database schema for this project

## Table of Contents
* [Important Note](#important-note)
* [Dependent MSSQL Function](#dependent-mssql-function)
* [Prerequisite Data Types](#prerequisite-data-types)
* [Prerequisite Functions](#prerequisite-functions)
* [Prerequisite Conditions](#prerequisite-conditions)
* [Stored Procedure Usage](#stored-procedure-usage)

### **Important Note**
* This project was written with MariaDB 10.5.6 methods
* Configured utf8mb4 charset

### Prerequisite Data Types
* bigint
* varchar
* datetime
* text

### Prerequisite Functions
* regexp_replace
* substring
* nullif
* str_to_date
* current_timestamp
* trim
* cast
* date_add
* max
* if

### Prerequisite Conditions
* N/A

### Stored Procedure Usage
* `call insertupdatedeleteNewsFeed ('deleteTempNews', '', '', '', '', '');`
* `call insertupdatedeleteNewsFeed ('insertTempNews', 'titleValue', 'imageUrlValue', 'feedUrlValue', 'actualUrlValue', '2020-10-13 00:00:00');`
* `call insertupdatedeleteNewsFeed ('updateBulkNews', '', '', '', '', '');`
* `call insertupdatedeleteNewsFeed ('insertBulkNews', '', '', '', '', '');`
