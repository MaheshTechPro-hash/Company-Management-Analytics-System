🏢 Complete Company Management & Analytics System
📋 Project Overview

This project demonstrates a complete company database system that manages departments, employees, projects, sales, and inventory.
It covers basic to advanced SQL concepts, including:

• CRUD operations

• Joins and Aggregations

• Ranking functions

• Views

• Stored Procedures

• Triggers

• User-defined Functions

The goal is to provide a comprehensive SQL learning project that simulates real-world company management.

🧩 Database Schema

• Departments – Stores department details

• Employees – Manages employee records and links to departments

• Projects – Tracks company projects, budgets, and timelines

• EmployeeProjects – Handles many-to-many relationships between employees and projects

• Sales – Records sales transactions per employee

• Inventory – Tracks product stock and pricing

🧮 Sample Data

Sample data is inserted for all tables — departments, employees, projects, sales, and inventory — for testing and demonstration purposes.

📊 SQL Queries
🔹 Basic Queries

• List all employees and departments

• Show employees with their department names

• View inventory products

🔹 Intermediate Queries

• Top 3 highest salaries in each department

• Employees with multiple projects

• Total sales by each employee

• Average salary per department

🔹 Advanced Queries

• Employees not assigned to any project

• Rank employees by total sales

• Employees earning above department average

👁️ Views
EmployeePerformance

Displays performance summary with department, salary, total sales, and project contribution.

⚙️ Stored Procedure
AddEmployee

Inserts a new employee record dynamically into the Employees table.

🧾 Trigger
trgSalaryChange

Automatically logs every salary update in the SalaryLog table.

🧠 Function
GetTenure

Calculates the total number of years an employee has worked based on their hire date.

🧰 Features Covered

✅ Table Design (Normalization)
✅ Primary and Foreign Keys
✅ Aggregate Functions (SUM, AVG, COUNT)
✅ Joins (INNER, LEFT)
✅ Window Functions (RANK, DENSE_RANK)
✅ CTEs (Common Table Expressions)
✅ Views
✅ Stored Procedures
✅ Triggers
✅ Functions

💻 How to Use

1)Open SQL Server Management Studio (SSMS)

2)Create a new database (e.g., CompanyDB)

3)Run all SQL scripts in order:

• Tables

• Sample Data

• Queries

• Views, Procedures, Triggers, Functions

Test and explore using SELECT statements

📁 Project Structure
📂 CompanyManagementSystem
 ├── CompanyDB.sql      # Full SQL script (tables + data + logic)
 ├── README.md          # Project documentation

🧑‍💼 Author

Mahesh Palave
📧 mailto:your-maheshpalave.techgmail.com

🌐 [https://github.com/MaheshTechPro-hash]

🏁 License

This project is open-source and available for educational use under the MIT License.
