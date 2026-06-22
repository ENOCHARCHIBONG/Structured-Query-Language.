
--Creating Table Orders
CREATE TABLE Orders (
	OrderID INT PRIMARY KEY,
	CustomerName VARCHAR (100),
	OrderDate DATE,
	Product VARCHAR (50),
	Quantity INT,
	Price DECIMAL (12, 2),
	State VARCHAR (50));

-- Create Payments Table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATE,
    PaymentAmount DECIMAL(12,2),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into Orders Table
INSERT INTO Orders
(OrderID, CustomerName, OrderDate, Product, Quantity, Price, State)
VALUES
(1, 'Gabriel Aliyu', '2023-01-15', 'Laptop', 2, 350000, 'Sokoto'),
(2, 'Brown Abu', '2023-02-10', 'Phone', 5, 250000, 'Cross River'),
(3, 'Janet Ugo', '2023-03-20', 'Tablet', 3, 700000, 'Imo'),
(4, 'Abi Jude', '2023-01-20', 'Phone', 1, 150000, 'Kogi'),
(5, 'Garba Shehu', '2023-04-05', 'Laptop', 1, 500000, 'Borno');


Select * from Orders

-- Insert data into Payments Table
INSERT INTO Payments
(PaymentID, OrderID, PaymentDate, PaymentAmount, PaymentMethod)
VALUES
(101, 1, '2023-01-16', 700000, 'Card'),
(102, 2, '2023-02-11', 1250000, 'Cash'),
(103, 3, '2023-03-21', 2100000, 'Bank Transfer'),
(104, 4, '2023-01-21', 150000, 'Card'),
(105, 5, '2023-04-06', 500000, 'Cash');

Select * from Payments

-- CTE to calculate total amount spent by each customer

;WITH CustomerTotals AS (
    SELECT 
        o.CustomerName,
        SUM(p.PaymentAmount) AS TotalAmountSpent
    FROM Orders o
    JOIN Payments p
        ON o.OrderID = p.OrderID
    GROUP BY o.CustomerName
)
SELECT 
    CustomerName,
    TotalAmountSpent
FROM CustomerTotals
ORDER BY TotalAmountSpent DESC;

--Analyze total revenue grouped by State and Product using ROLLUP
SELECT 
    State,
    Product,
    SUM(Quantity * Price) AS TotalRevenue
FROM Orders
GROUP BY ROLLUP (State, Product);

--Extract year and month from OrderDate

SELECT
	OrderID,
	OrderDate,
	YEAR(OrderDate) AS Year_Only,
	MONTH(OrderDate) AS Month_Only
	from Orders;
