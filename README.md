# Employee-Management-System-Database
# 📊 Employee Management System - SQL Database
This project is a structured **Employee Management System** implemented using **MySQL**. It includes all essential entities such as Employees, Departments, Roles, Salaries, and relevant stored procedures and views for managing and analyzing employee data.
---
## 🏗️ Database Structure
### 🔹 Tables
- **Departments**  
  Stores department details.
- **Roles**  
  Stores role/job descriptions.
- **Employees**  
  Stores employee information and links to departments and roles.
- **Salaries**  
  Stores employee salary history.
---
## ⚙️ Stored Procedures
- `AddEmployee(...)`  
  Adds a new employee.
- `AddDepartment(...)`  
  Adds a new department.
- `AddRole(...)`  
  Adds a new role.
- `UpdateEmployeeSalary(...)`  
  Ends the current salary (if exists) and adds a new salary record.
---
## 👁️ Views
- **EmployeeView**  
  Combines employee details with their department,
- **DepartmentSummary**  
  Lists departments with the number of employees in each.
- **SalaryHistoryView**  
  Shows the salary history for each employee with names and amounts.
---
## 📌 Indexing
Efficient indexing has been implemented to speed up queries:
- Automatic indexes on primary and foreign keys.
- Composite index on `(EmployeeID, EndDate)` in `Salaries`.
- Indexes on `DepartmentID` and `RoleID` in `Employees`.
---
## 🚀 How to Run
1. Make sure MySQL server is running.
2. Open a MySQL client or MySQL Workbench.
3. Run the script file:  
   ```sql
   SOURCE path/to/Employee_managing_system.sql;
  📬 Contact
For any questions or improvements, feel free to reach out!
Name:Robel welday Bahta
Email:Robelwelday16@gmail.com

