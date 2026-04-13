# SQL fundamentals: DDL, DML, filtering, and CASE WHEN
 
## What is SQL?
 
SQL (Structured Query Language) is the standard language for interacting with relational databases. Whether you are storing customer records, tracking exam results, or analysing transactions, SQL is how you talk to the database.
 
---
 
## The five command categories
 
SQL commands are grouped into five categories:
 
| Category | Its Function | Commands |
|----------|-------------|----------|
| DDL (Data Definition Language) | Defines and modifies the database structure | CREATE, ALTER, DROP, TRUNCATE |
| DML (Data Manipulation Language) | Manages/manipulates data inside tables | INSERT, UPDATE, DELETE |
| DQL (Data Query Language) | Retrieves data from the tables | SELECT |
| TCL (Transaction Control Language) | Manages transactions | COMMIT, ROLLBACK, SAVEPOINT |
| DCL (Data Control Language) | Controls access and permissions | GRANT, REVOKE |
 
This article focuses on DDL, DML, and DQL.
 
---
 
## DDL (Data Definition Language)
 
DDL creates the schemas, tables and columns. It defines the shape of your data before any data exists. It has four commands, as mentioned in the table: CREATE, ALTER, DROP and TRUNCATE.
 
`CREATE TABLE` sets up a table with its columns, data types, and constraints. `ALTER TABLE` modifies an existing table by adding columns, renaming them, or dropping ones that are no longer needed. `TRUNCATE TABLE` removes the contents of the table; however, it retains the table structure. `DROP TABLE` removes the entire table.
 
> **A lightbulb moment:** `CREATE TABLE` wraps its column definitions in parentheses. `ALTER TABLE` does not — the instruction follows directly after the table name.
 
-- Creation of a student table
CREATE TABLE students (
    student_id    INT PRIMARY KEY,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    gender        VARCHAR(1),
    date_of_birth DATE,
    class         VARCHAR(10),
    city          VARCHAR(50)
);
 
-- Addition of a phone number column
ALTER TABLE students
ADD COLUMN phone_number VARCHAR(20);
```
 
---
 
## DML (Data Manipulation Language)
 
`INSERT INTO` adds rows to a table. You list the target columns, follow with `VALUES`, and can insert multiple rows in one statement by separating them with commas. Always quote dates — without quotes, PostgreSQL reads `2008-03-12` as arithmetic (2008 − 3 − 12 = 1993).
 
INSERT INTO students (student_id, first_name, gender, date_of_birth, class, city)
VALUES
    (1, 'Amina', 'F', '2008-03-12', 'Form 3', 'Nairobi'),
    (2, 'Brian', 'M', '2007-07-25', 'Form 4', 'Mombasa');
```
 
`UPDATE` modifies existing rows. `DELETE` removes them. Both require a `WHERE` clause — without it, every row in the table is affected, not just the one you intended.

-- Updating a student's current city of residence:
UPDATE students
SET city = 'Nairobi'
WHERE student_id = 5;
 
-- Deleting an exam result from a student whose id is 9:
DELETE FROM exam_results
WHERE result_id = 9;
```
 
---
 
## WHERE clause
 
SQL has a variety of operators that allow for various filtering conditions. The `WHERE` clause, when used with these operators, allows you to target specific rows.
 
Some operators include:
 
- `BETWEEN` filters a range and is inclusive on both ends.
- `IN` checks against a list of values. It is cleaner than chaining multiple `OR` conditions.
- `LIKE` matches text patterns, where `%` represents any sequence of characters.

WHERE marks BETWEEN 50 AND 80
WHERE city IN ('Nairobi', 'Mombasa', 'Kisumu')
WHERE class NOT IN ('Form 1', 'Form 2')
WHERE first_name LIKE 'A%' OR first_name LIKE 'E%'
```
 
---
 
## CASE WHEN
 
`CASE WHEN` lets you apply conditional logic directly inside a query, generating a new column based on rules you define — without touching the underlying table.

-- Exam results labelling:
SELECT *,
    CASE
        WHEN marks >= 80 THEN 'Distinction'
        WHEN marks >= 60 THEN 'Merit'
        WHEN marks >= 40 THEN 'Pass'
        ELSE 'Fail'
    END AS performance
FROM exam_results;
 
PostgreSQL evaluates conditions top to bottom and stops at the first match, so order matters. The `ELSE` clause covers anything that falls outside your defined conditions. Without it, unmatched rows return `NULL`.
 
In `CASE WHEN`, the result exists only in the query output. The table structure is never changed.
 
What makes `CASE WHEN` powerful is that it lets you enhance your data at query time without needing extra columns in your schema. For reporting and analysis, that flexibility is very useful.
