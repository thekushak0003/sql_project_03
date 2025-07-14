<h1 align="center">📚 Library Management System – SQL Project</h1>

<p align="center">
A fully-functional SQL project to simulate a real-world Library Management System, showcasing relational database design, advanced SQL queries, analytics, stored procedures, and triggers.
</p>

---

## 🚀 Overview

This project simulates the operations of a library such as book issue/return, overdue management, fine calculation, branch performance, and member activity tracking using **PostgreSQL**. It demonstrates hands-on experience with:

- 💾 **Schema Design**
- 🔁 **Joins & Aggregations**
- 🛠 **Stored Procedures & Triggers**
- 📊 **Reporting & CTAS Queries**
- 🔐 **Data Consistency & Business Logic**

> 🎓 Ideal for **portfolios, resumes, DBMS projects, internships**, and practical SQL mastery.

---

## 🧱 Database Schema

```plaintext
📦 Tables:
├── branch(branch_id, manager_id, branch_address, contact_no)
├── employees(emp_id, emp_name, position, salary, branch_id)
├── members(member_id, member_name, member_address, reg_date)
├── books(isbn, book_title, category, rental_price, status, author, publisher)
├── issued_status(issued_id, issued_member_id, issued_date, issued_book_isbn, issued_emp_id)
└── return_status(return_id, issued_id, return_date, return_book_isbn, book_quality)
```
## 🧩 SQL Task List & Query Highlights
Below are 35 curated questions (Q1–Q35) covering CRUD, CTAS, aggregation, analytics, business logic, and advanced SQL concepts in the context of the Library Management System:

### 🔧 Basic CRUD & Query Operations
- Q1: Create a New Book Record
- Q2: Update an Existing Member's Address


- Q3: Delete a Record from the Issued Status Table


- Q4: Retrieve All Books Issued by a Specific Employee


- Q5: List Members Who Have Issued More Than One Book


### 🧱 CTAS (Create Table As Select)
- Q6: Summary Table – Book and Total Issue Count


- Q28: Create a Table of Active Members

### 🔍 Filter-Based & Aggregation Queries
- Q7: Retrieve All Books in a Specific Category


- Q8: Find Total Rental Income by Category


- Q9: Members Registered in the Last 180 Days

- Q10: Employees with Branch Manager and Branch Details

### 📚 Advanced Filtering, Joins & Analytics
- Q11: Books with Rental Price Above $7


- Q12: Books Issued But Not Yet Returned

- Q13: List All Employees and Their Branch Address


- Q14: Count of Books Per Category


### 🚫 Negation, Filtering, and Redundancy
- Q15: Members Who Have Not Issued Only 1 Book


- Q16: Employees Who Have Not Issued Any Books Yet


- Q17: Show All Books Currently Not Available


- Q18: Total Number of Books Issued by Category


### 🎯 Top N, Sorting, and Ranking
- Q19: Members with Latest Registration (Top 5)


- Q20: Average Salary by Position in Each Branch


- Q21: Top Member by Most Books Issued

### ⏱ Time & Duration Based
- Q22: Calculate Days Between Issue and Return

- Q23: Average Rental Price per Author


### 🧩 Employee & Member Relationships
- Q24: Employees Working at the Same Branch as E101

### 🔐 Late Returns, Fines, and Cleanup
- Q25: Books Issued But Not Returned


- Q26: Members with Overdue Books (30+ days)

- Q27: Branch Performance Report


### 🔐 Late Returns, Fines, and Cleanup
- Q25: Books Issued But Not Returned

- Q26: Members with Overdue Books (30+ days)


- Q27: Branch Performance Report

### 📊 Conditional Aggregations & Fines
- Q30: Aggregation with Condition (CASE)

- Q33: Members Who Returned Books Late More Than Once


### 🧱 Schema Evolution & Fine Calculation
- Q34: Add Column to Books Table for Book Age

- Q35: Fine Calculation Table Using CTAS




