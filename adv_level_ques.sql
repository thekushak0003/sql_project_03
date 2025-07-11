-- SQL Project - Library Management System N2

SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM issued_status;
SELECT * FROM members;
SELECT * FROM return_status;


-- Advance Problem Solving
-- Q26: Identify Members with Overdue Books
/* 
Write a query to identify members who have overdue books (assume a 30-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue.
*/

-- issued_status == members == books == return_status
-- filter books which is return
-- overdue > 30 
SELECT CURRENT_DATE


SELECT 
    isd.issued_member_id,
    m.member_name,
    bk.book_title,
    isd.issued_date,
    -- rs.return_date,
    CURRENT_DATE - isd.issued_date as over_dues_days
FROM issued_status as isd
JOIN members m ON m.member_id = isd.issued_member_id
JOIN books bk ON bk.isbn = isd.issued_book_isbn
LEFT JOIN return_status rs ON rs.issued_id = isd.issued_id
WHERE 
    rs.return_date IS NULL
    AND
    (CURRENT_DATE - isd.issued_date) > 30
ORDER BY 1;


-- Q27: Branch Performance Report
/* Create a query that generates a performance report for each branch, 
showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.
*/

CREATE TABLE branch_reports
AS
SELECT 
    b.branch_id,
    b.manager_id,
    COUNT(ist.issued_id) as number_book_issued,
    COUNT(rs.return_id) as number_of_book_return,
    SUM(bk.rental_price) as total_revenue
FROM issued_status as ist
JOIN 
employees as e
ON e.emp_id = ist.issued_emp_id
JOIN
branch as b
ON e.branch_id = b.branch_id
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
JOIN 
books as bk
ON ist.issued_book_isbn = bk.isbn
GROUP BY 1, 2;

SELECT * FROM branch_reports;

-- Q28: CTAS: Create a Table of Active Members
/* Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members 
who have issued at least one book in the last 2 months.
*/
CREATE TABLE active_members
AS
SELECT * FROM members
WHERE member_id IN (SELECT 
                        DISTINCT issued_member_id   
                    FROM issued_status
                    WHERE 
                        issued_date >= CURRENT_DATE - INTERVAL '2 month');

SELECT * FROM active_members;


-- Q29: Find Employees with the Most Book Issues Processed
/* Write a query to find the top 3 employees who have processed the most book issues. 
Display the employee name, number of books processed, and their branch.
*/
SELECT 
    e.emp_name,
    b.*,
    COUNT(isd.issued_id) as no_book_issued
FROM issued_status as isd
JOIN
employees as e
ON e.emp_id = isd.issued_emp_id
JOIN
branch as b
ON e.branch_id = b.branch_id
GROUP BY 1, 2


-- Q30: Aggregation with Condition (CASE)
/*Count how many books are currently:
   Available (status='yes')
   Unavailable (status='no')
*/
SELECT 
  COUNT(CASE WHEN status = 'yes' THEN 1 END) AS available_books,
  COUNT(CASE WHEN status = 'no' THEN 1 END) AS unavailable_books
FROM books;

-- Q31: Detecting Overlaps or Conflicts
-- Detect if any book has been issued again before being returned
SELECT i1.issued_book_isbn, i1.issued_date, r.return_date, i2.issued_date AS next_issue_date
FROM issued_status i1
JOIN return_status r ON i1.issued_id = r.issued_id
JOIN issued_status i2 ON i1.issued_book_isbn = i2.issued_book_isbn 
   AND i2.issued_date > i1.issued_date
WHERE i2.issued_date < r.return_date;

-- Q32: Identify Redundancy or Anomalies
-- Find if there are any books with duplicate titles but different ISBNs

SELECT book_title, COUNT(DISTINCT isbn) AS versions
FROM books
GROUP BY book_title
HAVING COUNT(DISTINCT isbn) > 1;


-- Q33: List Members Who Have Returned a Book Late More Than Once
-- Identify members who have returned books late (>30 days) more than once
SELECT 
    m.member_id,
    m.member_name,
    COUNT(*) AS late_returns
FROM members m
JOIN issued_status isd ON m.member_id = isd.issued_member_id
JOIN return_status r ON isd.issued_id = r.issued_id
WHERE r.return_date - isd.issued_date > 30
GROUP BY m.member_id, m.member_name
HAVING COUNT(*) > 1;

-- Q34: Add a Column to Books Table for Book Age
/* Add a column book_age that calculates how old the book is (based on a hypothetical published_date column). 
(Assumes published_date exists.) */

ALTER TABLE books ADD COLUMN published_date DATE;

UPDATE books
SET published_date = '2010-01-01'
WHERE isbn = '978-0-553-29698-2';

SELECT 
  isbn, book_title, 
  CURRENT_DATE - published_date AS book_age
FROM books;

-- Q35: Fine Calculation Table Using CTAS
-- Create a summary table that includes member ID, book title, overdue days, and total fine (₹2 per day)

CREATE TABLE fine_summary AS
SELECT 
    m.member_id,
    m.member_name,
    b.book_title,
    i.issued_date,
    r.return_date,
    GREATEST(r.return_date - i.issued_date - 30, 0) AS overdue_days,
    GREATEST(r.return_date - i.issued_date - 30, 0) * 2 AS total_fine
FROM members m
JOIN issued_status i ON m.member_id = i.issued_member_id
JOIN return_status r ON i.issued_id = r.issued_id
JOIN books b ON i.issued_book_isbn = b.isbn;


















