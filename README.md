# Project: Human Resources Database Design

## Project overview

In this project, I have designed, built, and populated a database for the Human Resources (HR) Department at the imaginary Tech ABC Corp, a video game company. 

Suppose that the project started with a request from the HR Manager. From there, I was commissioned to design a database using the foundational principals of data architecture that is best suited to the department's needs. 

I went through the steps of database architecture, creating database proposals, database entity relationship diagrams (ERD), and finally creating the database itself. This project is important, as it is a scaled-down simulation of the kind of real-world assignments data architects work on every day.

## Business scenario & requirments

> Tech ABC Corp saw explosive growth with a sudden appearance onto the gaming scene with its new AI-powered video game console. As a result, they have gone from a small 10 person operation to 200 employees and 5 locations in under a year. HR is having trouble keeping up with the growth since they are still maintaining employee information in a spreadsheet. While that worked for ten employees, it has become increasingly cumbersome to manage as the company expands.

As such, the HR department required the data architect to design and build a database capable of managing their employee. information.

## Dataset

The HR dataset is an Excel workbook (data/hr-dataset.csv) consisting of 206 records, with eleven columns. The data is in human-readable format and has not been normalized at all. The data lists the names of employees at Tech ABC Corp, as well as information such as job title, department, manager's name, hire date, start date, end date, work location, and salary.

## IT Department Best Practices

The IT Department has certain Best Practices policies for databases to follow, as detailed in the Best Practices document.

## Project Steps

The project is broken down into three major steps, with a fourth optional step. Each step informs the step that follows. The project has been designed to mimic the flow of a real-world database design project.

-   **`Step 1:`** This step is all about information gathering and putting it down on paper. In this step expects to complete both business and technical proposal documents required to begin the database design process.

-   **`Step 2:`** Step 2 walks through the design process. [Lucidchart](https://www.lucidchart.com/pages/) is used as a tool to create database diagrams, used to construct an actual database with SQL queries.

-   **`Step 3:`** In step 3, PostgresSQL DDL queries were used to create a database. Then the database is populated with the HR dataset. From there, some SQL CRUD queries will be executed.

-   **`Step 4:`** if necessary, some custom queries, such as views, stored procedures, and security, were added.

## File description

-   `proposal.pdf` : the completed report that explains data architecture overview and process for this project

-   `IT_best_practices.pdf` : a reference document that specifies best practices of IT application within the company

-   `sql_files` : a folder that contains 3 SQL files

    -   **StageTableLoad.sql** : SQL codes provided to create a staging table and insert data
    -   **DDL_DML.sql** : SQL codes to create the physical database
    -   **aCustomQueries.sql** : SQL codes for custom queries corresponding `Step 4`
    
-   `data` : a directory that contains the original HR dataset (an Excel workbook)

