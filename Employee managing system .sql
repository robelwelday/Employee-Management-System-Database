SET autocommit = 0;
SET sql_safe_updates = 0;
create database Employee_Management_System_database;
USE Employee_Management_System_database;
commit;
CREATE TABLE Departments (
    DepartmentID SERIAL PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);
CREATE TABLE Roles (
    RoleID SERIAL PRIMARY KEY,
    RoleTitle VARCHAR(100) NOT NULL,
    Description TEXT
);
CREATE TABLE Employees (
    EmployeeID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    HireDate DATE NOT NULL,
    DepartmentID INT NOT NULL,
    RoleID INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);
CREATE TABLE Salaries (
    SalaryID SERIAL PRIMARY KEY,
    EmployeeID INT NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);
DELIMITER $$

CREATE PROCEDURE AddEmployee(
    IN f_name VARCHAR(50),
    IN l_name VARCHAR(50),
    IN email VARCHAR(100),
    IN phone VARCHAR(20),
    IN hire_date DATE,
    IN dept_id INT,
    IN role_id INT
)
BEGIN
    INSERT INTO Employees (FirstName, LastName, Email, Phone, HireDate, DepartmentID, RoleID)
    VALUES (f_name, l_name, email, phone, hire_date, dept_id, role_id);
END$$
DELIMITER ;
DELIMITER $$
CREATE PROCEDURE AddDepartment(
    IN dept_name VARCHAR(100),
    IN dept_location VARCHAR(100)
)
BEGIN
    INSERT INTO Departments (DepartmentName, Location)
    VALUES (dept_name, dept_location);
END$$
DELIMITER ;
commit;
DELIMITER $$
CREATE PROCEDURE AddRole(
    IN role_title VARCHAR(100),
    IN role_desc TEXT
)
BEGIN
    INSERT INTO Roles (RoleTitle, Description)
    VALUES (role_title, role_desc);
END$$
DELIMITER ;
DELIMITER $$
CREATE PROCEDURE UpdateEmployeeSalary(
    IN emp_id INT,
    IN new_amount DECIMAL(10,2),
    IN start_date DATE
)
BEGIN
    -- End previous salary if it exists
    UPDATE Salaries
    SET EndDate = start_date
    WHERE EmployeeID = emp_id AND EndDate IS NULL;

    -- Insert new salary record
    INSERT INTO Salaries (EmployeeID, Amount, StartDate)
    VALUES (emp_id, new_amount, start_date);
END$$
DELIMITER ;
commit;
CREATE VIEW EmployeeView AS
SELECT 
    e.EmployeeID, e.FirstName, e.LastName, e.Email, e.Phone, e.HireDate,
    d.DepartmentName, r.RoleTitle,
    s.Amount AS CurrentSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN Roles r ON e.RoleID = r.RoleID
LEFT JOIN Salaries s ON e.EmployeeID = s.EmployeeID AND s.EndDate IS NULL;
CREATE VIEW DepartmentSummary AS
SELECT 
    d.DepartmentID, d.DepartmentName,
    COUNT(e.EmployeeID) AS EmployeeCount
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName;
CREATE VIEW SalaryHistoryView AS
SELECT 
    s.SalaryID, s.EmployeeID, CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    s.Amount, s.StartDate, s.EndDate
FROM Salaries s
JOIN Employees e ON s.EmployeeID = e.EmployeeID
ORDER BY s.EmployeeID, s.StartDate DESC;
commit;
CREATE INDEX idx_salaries_emp_end ON Salaries(EmployeeID, EndDate);
CREATE INDEX idx_employees_department ON Employees(DepartmentID);
CREATE INDEX idx_employees_role ON Employees(RoleID);
commit;

