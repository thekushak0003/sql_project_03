SELECT * FROM employees;
SELECT * FROM books;
SELECT * FROM members;
SELECT * FROM issued_status;
SELECT * FROM branch;
SELECT * FROM return_status;


-- Data Analysis & Problem Solving

-- Q1: Create a New Book Record -- (978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;

-- Q2: Update an Existing Member's Address
UPDATE members
SET member_address = '125 Main St'
WHERE member_id = 'C101';
SELECT * FROM members;

-- Q3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

SELECT * FROM issued_status
WHERE issued_id = 'IS121';

DELETE FROM issued_status
WHERE issued_id = 'IS121';

-- Q4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';

-- Q5: List Members Who Have Issued More Than One Book 
SELECT 
    isd.issued_emp_id,
     e.emp_name
FROM issued_status isd
JOIN employees e ON e.emp_id = isd.issued_emp_id
GROUP BY 1, 2
HAVING COUNT(isd.issued_id) > 1;

-- Q6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
CREATE TABLE book_cnts
AS    
SELECT 
    b.isbn,
    b.book_title,
    COUNT(isd.issued_id) no_issued
FROM books b
JOIN issued_status isd ON isd.issued_book_isbn = b.isbn
GROUP BY 1, 2;
SELECT * FROM book_cnts;

-- Q7: Retrieve All Books in a Specific Category
SELECT * FROM books
WHERE category = 'Classic';

-- Q8: Find Total Rental Income by Category
SELECT
    b.category,
    SUM(b.rental_price),
    COUNT(*)
FROM books b
JOIN issued_status isd ON isd.issued_book_isbn = b.isbn
GROUP BY 1;

-- Q9: List Members Who Registered in the Last 180 Days
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';    

-- Q10: List Employees with Their Branch Manager's Name and their branch details
SELECT 
    e1.*,
    b.manager_id,
    e2.emp_name manager
FROM employees e1
JOIN branch b ON b.branch_id = e1.branch_id
JOIN employees e2 ON b.manager_id = e2.emp_id;

-- Q11: Create a Table of Books with Rental Price Above a Certain Threshold 7USD
CREATE TABLE books_price_greater_than_seven
AS    
SELECT * FROM Books
WHERE rental_price > 7;

SELECT * FROM 
books_price_greater_than_seven;


-- Q12: Retrieve the List of Books Not Yet Returned

SELECT 
    DISTINCT isd.issued_book_name
FROM issued_status isd
LEFT JOIN return_status rs ON isd.issued_id = rs.issued_id
WHERE rs.return_id IS NULL;
    
SELECT * FROM return_status;

-- Q13: List All Employees and Their Branch Address
SELECT e.emp_name, e.position, b.branch_address
FROM employees e
JOIN branch b ON e.branch_id = b.branch_id;


-- Q14: Count of Books Per Category
SELECT category, COUNT(*) AS book_count
FROM books
GROUP BY category;

-- Q15: Members Who Have Not Issued only 1 Book
SELECT m.member_id, m.member_name
FROM members m
JOIN issued_status i ON m.member_id = i.issued_member_id
GROUP BY m.member_id, m.member_name
HAVING COUNT(i.issued_id) = 1;

-- Q16: Employees Who Have Not Issued Any Books Yet
SELECT emp_id, emp_name
FROM employees
WHERE emp_id NOT IN (
    SELECT DISTINCT issued_emp_id FROM issued_status
);

-- Q17: Show All Books Currently Not Available (status = 'no')
SELECT book_title, author FROM books
WHERE status = 'no';

-- Q18: Find Total Number of Books Issued by Each Category
SELECT b.category, COUNT(*) AS total_issued
FROM books b
JOIN issued_status i ON b.isbn = i.issued_book_isbn
GROUP BY b.category;


-- Q19: Members with Latest Registration (Top 5)
SELECT * FROM members
ORDER BY reg_date DESC
LIMIT 5;

-- Q20: Calculate Average Salary by Position in Each Branch
SELECT branch_id, position, ROUND(AVG(salary),1) AS avg_salary
FROM employees
GROUP BY branch_id, position;

-- Q21: Top Member by Most Books Issued
SELECT issued_member_id, COUNT(*) AS total_books_issued
FROM issued_status
GROUP BY issued_member_id
ORDER BY total_books_issued DESC
LIMIT 1;

-- Q22: Calculate Days Between Issue and Return for Each Book
SELECT 
  i.issued_id, 
  i.issued_book_name, 
  r.return_date - i.issued_date AS days_kept
FROM issued_status i
JOIN return_status r ON i.issued_id = r.issued_id;

-- Q23: Find Average Rental Price per Author
SELECT author, ROUND(AVG(rental_price),2) AS avg_rent
FROM books
GROUP BY author;

-- Q24: Employees Working at the Same Branch as 'E101'
SELECT e2.emp_id, e2.emp_name
FROM employees e1
JOIN employees e2 ON e1.branch_id = e2.branch_id
WHERE e1.emp_id = 'E101' AND e1.emp_id != e2.emp_id;

-- Q25: List All Books That Have Been Issued But Not Yet Returned
SELECT 
  i.issued_id,
  i.issued_book_name,
  i.issued_book_isbn,
  i.issued_member_id,
  i.issued_date
FROM issued_status i
LEFT JOIN return_status r ON i.issued_id = r.issued_id
WHERE r.return_id IS NULL;












































