# Cafe Sales SQL Project
Topics: SQL, SQLite, Data Analysis, Data Cleaning, Database Design

This project demonstrates transforming raw sales data into a clean, structured, and queryable relational database. It includes data cleaning, normalization into 3NF, schema design, data insertion with Pandas, and SQL queries. 
Raw data from: https://www.kaggle.com/datasets/ahmedmohamed2003/cafe-sales-dirty-data-for-cleaning-training?resource=download

--ERD Diagram-------------------------------------

The original data (dirty_cafe_sales.csv) was a flat, unnormalized table. In order to achieve 3NF within the data, I constructed an ERD Diagram (ERD Diagram.PNG) showcasing the different connections within the data through separate tables and keys, involving both cardinality and modality, key relationships, and data types.

--Data Dictionary-------------------------------------

In order to have a clear reference for my data, I created a data dictionary (Cafe Sales Data Dictionary.pdf) that specifies the characteristics of each input, separated into the tables the final database would hold.

--Data Cleaning-------------------------------------

I utilized Pandas to clean the dirty_cafe_sales.csv (10,000 rows of data). Although I didn't have much prior experience with Pandas, I learned a lot as I worked towards how exactly I wanted to clean the data and what would make sense in a real-world scenario. I removed duplicates and standardized formatting, converted data types, calculated missing values, and ensured NaN usage, preserving rows with missing values in the Transactions table as to not lose/skew data.

--Schema and Insert-------------------------------------

In order to create my database tables, I used both Pandas and SQL. I used SQL to create the relational tables, which I based on my Data Dictionary and ERD Diagram. I used Pandas to insert data from the new cleaned CSV into my schema tables, and ensured uniqueness in entries and correct usage of merging. 

--Queries-------------------------------------

I came up with 10 different questions to write queries for to demonstrate aggregate functions, joins, grouping, and more. I wrote each question keeping in mind what the data could be used for in the real world. View query results in 'Cafe Sales Query Results.pdf'
