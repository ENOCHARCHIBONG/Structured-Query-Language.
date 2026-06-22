-- Create Customers Table
Create table Customers (
 Customer_ID	INT PRIMARY KEY,
    Name		VARCHAR(100),
    State		VARCHAR(50),
    Income		DECIMAL(10,2)
);
select * from Customers

-- Insert data into Customers Table
INSERT INTO Customers (Customer_ID, Name, State, Income)
VALUES
(3021, 'Kolawale Saidu', 'Lagos', 85000),
(3028, 'Ade Abu', 'Edo', 120000),
(3067, 'Imabong Udo', 'Akwa Ibom', 65000),
(3078, 'Diana Ross', 'Cross River', 95000),
(3097, 'Adullahi Usman', 'Yobe', 70000),
(3043, 'Jefferson Chris', 'Taraba', 51000),
(3056, 'Chidima Ikena', 'Abia', 67000);

select * from Customers

-- Create Transactions Table
CREATE TABLE TRANSACTIONS(
Transaction_ID		VARCHAR(10)	PRIMARY KEY,
Customer_ID			INT,
Amount				DECIMAL(10,2),
Transaction_Type	VARCHAR(20),
Date DATE,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Insert data into Transactions Table
INSERT INTO Transactions 
(Transaction_ID, Customer_ID, Amount, Transaction_Type, Date)
VALUES
('T001', 3021, 8000, 'Credit', '2024-12-01'),
('T002', 3028, 1000, 'Debit', '2024-12-02'),
('T003', 3078, 4000, 'Credit', '2024-12-03'),
('T004', 3067, 1500, 'Credit', '2024-12-03'),
('T005', 3021, 15000, 'Debit', '2024-12-04'),
('T006', 3097, 30000, 'Debit', '2024-12-05'),
('T007', 3028, 90000, 'Credit', '2024-12-05'),
('T008', 3056, 7600, 'Debit', '2024-12-06'),
('T009', 3043, 5800, 'Credit', '2024-12-06');

select * from TRANSACTIONS

--Query to list all customers and their transaction details
SELECT 
    c.Customer_ID,
    c.Name,
    c.State,
    c.Income,
    t.Transaction_ID,
    t.Amount,
    t.Transaction_Type,
    t.Date
FROM Customers c
FULL OUTER JOIN Transactions t
ON c.Customer_ID = t.Customer_ID;

-- Identify the customer(s) who have the highest total transaction amount using a subquery
SELECT 
    c.Customer_ID,
    c.Name,
    SUM(t.Amount) AS Total_Transaction
FROM Customers c
JOIN Transactions t
ON c.Customer_ID = t.Customer_ID
GROUP BY c.Customer_ID, c.Name
HAVING SUM(t.Amount) = (
    SELECT MAX(TotalAmount)
    FROM (
        SELECT SUM(Amount) AS TotalAmount
        FROM Transactions
        GROUP BY Customer_ID
    ) AS SubQuery
);

--A query to combine the list of customers from Lagos and Edo using UNION, excluding duplicates.
Select
	name,
	state
	from Customers
	where State = 'Lagos'

	Union

select
	name,
	state
	from Customers
	where State = 'Edo';







