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




