🧹 SQL Data Cleaning Project – Layoffs Dataset

 📌 Overview

This project was completed as part of **Task 4** of my **Data Analytics Internship**. The objective was to demonstrate proficiency in **SQL for data cleaning and transformation** by working with a real-world dataset related to company layoffs. Using MySQL, I applied data cleaning techniques to convert unstructured, messy data into a clean, consistent, and analysis-ready format.

This task mimics the kind of foundational work performed by data analysts and engineers in real business environments — ensuring that raw data is reliable, standardized, and meaningful before any analysis is conducted.

---

 🧰 Tools Used

- SQL (MySQL Workbench)
- Window Functions
- Common Table Expressions (CTEs)
- Joins & Subqueries
- Aggregate Functions
- Text Processing Functions (e.g., TRIM)
- Data Type Conversions

---

 🎯 Key Tasks Completed

 1. Removing Duplicates  
Used SQL window functions to identify and remove duplicate records based on multiple columns. Raw data was preserved in a staging table to ensure safety and traceability.

 2. Standardizing Data  
- Trimmed whitespace from textual fields (like `company`)
- Merged inconsistent labels (e.g., multiple variations of "crypto")
- Standardized country names by removing punctuation (e.g., `United States.` → `United States`)

 3. Handling Null & Blank Values  
- Identified nulls and blanks in important columns (`industry`, `total_laid_off`, etc.)
- Deleted rows with missing critical values
- Used joins to reference non-null rows for updating incomplete ones

 4. Converting Data Types  
Converted the `date` field from `TEXT` format to proper `DATE` format using MySQL’s string-to-date functions to ensure consistency and query readiness.

 5. Optimizing Table Structure  
Dropped unnecessary helper columns and ensured clean schema design after transformations were complete.

---

📈 Dataset Summary

- Source: Provided as `layoffs.csv`
- Columns: Company, Location, Industry, Total Laid Off, Percentage Laid Off, Date, Stage, Country, Funds Raised
- Common Issues Identified:
  - Duplicate entries
  - Text inconsistencies and formatting issues
  - Nulls in important columns
  - Dates stored as strings

---

📂 Repository Structure

| File Name                     | Description                                      |
|------------------------------|--------------------------------------------------|
| `Task4_SQL_data_cleaning.sql`| Full SQL script with step-by-step cleaning logic |
| `layoffs.csv`                | Original dataset used for the project            |
| `README.md`                  | Project documentation                            |
| `screenshots/` *(optional)*  | Screenshots of results/output (if required)      |

---

💡 What I Learned

- How to clean and prepare data efficiently using SQL
- Best practices in creating staging tables and preserving raw data
- The importance of standardizing and validating fields before analysis
- How null values can impact data quality and how to handle them effectively
- Real-world SQL patterns like CTEs, deduplication, data type conversion

---

 🎯 Relevance to Business Use Cases

In the real world, organizations rely on clean and reliable data to make informed decisions. This project simulates that need by transforming raw data into a usable format, allowing:
- Accurate performance tracking
- Clean dashboards and KPIs
- Better insight into market patterns like layoffs per industry or geography


 ✅ Task Submission Summary

- ☑ Cleaned and optimized SQL dataset
- ☑ Applied core SQL techniques for real-world business use
- ☑ Project uploaded to GitHub with structured files and documentation
- ☑ Delivered as per internship guidelines
