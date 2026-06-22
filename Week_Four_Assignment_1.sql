---Creating Employee Data
CREATE TABLE Employee_Data (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    department_location VARCHAR(100),
    manager_id INT
);

--Inserting into the Employee Table
INSERT INTO Employee_Data 
(emp_id, emp_name, department, salary, department_location, manager_id)
VALUES
(101, 'Umar Adamu', 'HR', 50000, 'Lokoja', 201),
(102, 'Jane Abu', 'IT', 60000, 'Cross River', 202),
(103, 'Caroline Agu', 'Finance', 55000, 'Sokoto', 203),
(104, 'Shehu Umar', 'Logistics', 48000, 'Zamfara', 204),
(105, 'Mohammed Bello', 'Procurement', 53000, 'Jigawa', 205),
(106, 'Frank Ewu', 'IT', 62000, 'Delta', 202);

SELECT * FROM Employee_Data


-- 1NF Table
CREATE TABLE Employee_1NF (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    department_location VARCHAR(100),
    manager_id INT
);

--Create Department Table
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    department_location VARCHAR(100),
    manager_id INT
);

--Create Employee Table
CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    salary DECIMAL(10,2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

--Insert into Department Table

INSERT INTO Department
(department_id, department_name, department_location, manager_id)
VALUES
(1, 'HR', 'Lokoja', 201),
(2, 'IT', 'Cross River', 202),
(3, 'Finance', 'Sokoto', 203),
(4, 'Logistics', 'Zamfara', 204),
(5, 'Procurement', 'Jigawa', 205);

SELECT * FROM Department

--Insert into Employee Table
INSERT INTO Employee
(emp_id, emp_name, salary, department_id)
VALUES
(101, 'Umar Adamu', 50000, 1),
(102, 'Jane Abu', 60000, 2),
(103, 'Caroline Agu', 55000, 3),
(104, 'Shehu Umar', 48000, 4),
(105, 'Mohammed Bello', 53000, 5),
(106, 'Frank Ewu', 62000, 2);

--Create Manager Table
CREATE TABLE Manager (
    manager_id INT PRIMARY KEY,
    manager_name VARCHAR(100)
);

--Modified Department Table
CREATE TABLE Department_3NF (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    department_location VARCHAR(100),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES Manager(manager_id)
);

--Employee Table in 3NF
CREATE TABLE Employee_3NF (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    salary DECIMAL(10,2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department_3NF(department_id)
);

--Salary Transformation (10% Increase for IT Department)
UPDATE Employee
SET salary = salary * 1.10
WHERE department_id = (
    SELECT department_id
    FROM Department
    WHERE department_name = 'IT'
);

SELECT * FROM Employee;