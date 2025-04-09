SET autocommit = 0;
SET sql_safe_updates = 0;
commit;
create database Employee_Management_System_database;
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

