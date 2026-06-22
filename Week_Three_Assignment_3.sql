
--Create Customers Table
CREATE TABLE Customers (
    customer_id			INT PRIMARY KEY,
    name				VARCHAR(100),
    loyalty_points		INT,
    registration_date	DATE,
    age					INT
);

--Create Transactions Table
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    amount_spent DECIMAL(10,2),
    transaction_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

select * from Transactions

--Create Products Table
CREATE TABLE Products (
	Product_id		int Primary key,
	product_name	Varchar (50),
	Price			Decimal (10,2),
	Cetagory		Varchar (50)
);

-- Insert Data into Customers Table
INSERT INTO Customers (customer_id, name, loyalty_points, registration_date, age)
VALUES
(101, 'Shehu Salihu', 150, '2019-05-15', 35),
(201, 'Job Timothy', 200, '2020-06-20', 42),
(305, 'Agnes Pam', 300, '2018-08-10', 29),
(405, 'Esther James', 120, '2022-01-05', 50),
(509, 'Larry Adams', 250, '2021-10-12', 32);

select * from Customers


--Insert Data into Transactions Table
INSERT INTO Transactions (transaction_id, customer_id, amount_spent, transaction_date)
VALUES
(1, 101, 100, '2023-05-10'),
(2, 201, 200, '2023-05-11'),
(3, 305, 300, '2023-05-12'),
(4, 405, 400, '2023-05-13'),
(5, 509, 150, '2023-05-14'),
(6, 305, 500, '2023-05-15');

select * from Transactions

--Insert Data into Products Table
insert into Products(Product_id, product_name, Price, Cetagory)
Values
(102, 'Laptop', 200000, 'Electronics'),
(201, 'Smartphone', 500000, 'Electronics'),
(203, 'Blender', 120000, 'Home Appliance'),
(104, 'Sofa', 450000, 'Furniture'),
(107, 'Dask Lamb', 350000, 'Furniture');

select * from Products

SELECT
    CASE 
        WHEN c.age < 40 THEN 'Below 40'
        ELSE '40 and Above'
    END AS age_group,
    SUM(t.amount_spent) AS total_amount_spent
FROM Customers c
JOIN Transactions t
    ON c.customer_id = t.customer_id
GROUP BY 
    CASE 
        WHEN c.age < 40 THEN 'Below 40'
        ELSE '40 and Above'
    END;

--Explanation:
--I join Customers + Transactions
--Use CASE to create age groups
--Then aggregate using SUM(amount_spent)
--Group results by the CASE expression

-- Create Index on transaction_date
CREATE INDEX idx_transaction_date
ON Transactions (transaction_date);

--Total Sales + Number of Transactions per Customer
SELECT 
    customer_id,
    SUM(amount_spent) AS total_sales,
    COUNT(transaction_id) AS number_of_transactions
FROM Transactions
GROUP BY customer_id;

--Using EXPLAIN to Analyze Query Execution Plan
EXPLAIN
SELECT 
    customer_id,
    SUM(amount_spent) AS total_sales,
    COUNT(transaction_id) AS number_of_transactions
FROM Transactions
GROUP BY customer_id;