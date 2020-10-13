# PostgreSQL Function, Index, Stored Procedure, Table, and or View
> PostgreSQL database schema for this project

## Table of Contents
* [Important Note](#important-note)
* [Prerequisite Data Types](#prerequisite-data-types)
* [Prerequisite Functions](#prerequisite-functions)
* [Prerequisite Conditions](#prerequisite-conditions)
* [Stored Procedure Usage](#stored-procedure-usage)

### **Important Note**
* This project was written with PostgreSQL 13.0 methods
* Install citext

### Prerequisite Data Types
* bigint
* int
* varchar
* datetime2
* bit
* text

### Prerequisite Functions
* trim
* regexp_replace
* substring
* nullif
* str_to_date
* lower
* current_timestamp
* date_format
* date_add
* concat
* cast
* max
* if

### Prerequisite Conditions
* N/A

### Stored Procedure Usage
* `call insertupdatedeleteMediaFeed ('deleteTempMovie', '', '', '', '', '');`
* `call insertupdatedeleteMediaFeed ('deleteTempTV', '', '', '', '', '');`
* `call insertupdatedeleteMediaFeed ('insertTempMovie', 'titleLongValue', 'titleShortValue', '2020-10-13 00:00:00');`
* `call insertupdatedeleteMediaFeed ('insertTempTV', 'titleLongValue', 'titleShortValue', '2020-10-13 00:00:00');`
* `call insertupdatedeleteMediaFeed ('updateBulkMovie', '', '', '', '', '');`
* `call insertupdatedeleteMediaFeed ('updateBulkTV', '', '', '', '', '');`
* `call insertupdatedeleteMediaFeed ('insertBulkMovie', '', '', '', '', '');`
* `call insertupdatedeleteMediaFeed ('insertBulkTV', '', '', '', '', '');`
