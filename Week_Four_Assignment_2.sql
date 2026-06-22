
--Importance of Data Warehousing in Decision-Making
--A Data Warehouse (DWH) is a centralized repository that aggregates structured data from multiple disparate sources (such as Sales, Customer CRMs, and Inventory systems) specifically optimized for analytics and business intelligence rather than transactional processing. Its importance in executive decision-making includes:

--Unified Truth & Holistic Analysis: Instead of looking at isolated operational tables, a data warehouse merges data to give a single, comprehensive view of business health. For instance, decision-makers can instantly see how a customer's demographic profile (Location, Age) correlates with their buying habits over several years.

--Enhanced Performance for Analytical Queries: Running complex aggregation queries (like calculating total revenue per month or historical trend analysis) directly on a live transactional database (OLTP) slows down operational activities. A data warehouse uses optimized architectures (such as columnar storage or star schemas) to execute massive analytical queries rapidly without interfering with everyday sales processing.

--Historical Trend Consistency: Transactional databases usually reflect only the current state of a business. A data warehouse retains years of historical snapshots, allowing corporate leadership to conduct predictive modeling, spot seasonal fluctuations, and make data-driven forecasting choices.

--Data Cleaning and Quality Assurance: During the Extract, Transform, Load (ETL) pipeline, data is standardized, deduplicated, and validated. This ensures that executive decisions are based on accurate, high-quality, and clean metrics rather than flawed operational logs.



--View joining the Customer and Sales tables, groups the records by customer details, aggregates their expenditures, and filters for users whose total purchases exceed $300,000$ Naira.

--Create the Table Customer
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    age INT,
    gender VARCHAR(10)
);

--Create Table Products
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL
);

--Create Table Sales
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

--Insert into Customer Table
INSERT INTO Customer VALUES
(1, 'John Doe', 'Lagos', 30, 'Male'),
(2, 'Jane Smith', 'Abuja', 28, 'Female'),
(3, 'Peter Adams', 'Port Harcourt', 40, 'Male'),
(4, 'Sarah Johnson', 'Kano', 35, 'Female');

Select * from Customer

--Insert into Products Table
INSERT INTO Products(product_id, product_name, category, price)
VALUES
(101, 'Laptop', 'Electronics', 350000.00),
(102, 'Phone', 'Electronics', 150000.00),
(103, 'Printer', 'Office', 85000.00);

-- Insert into Table Sales
INSERT INTO Sales VALUES
(5001, 1, 101, '2024-01-10', 1, 350000.00),
(5002, 2, 102, '2024-02-15', 2, 300000.00),
(5003, 3, 103, '2024-03-20', 1, 85000.00),
(5004, 4, 101, '2024-03-25', 1, 350000.00);

Select * from Sales

CREATE VIEW Customers_High_Spenders AS
SELECT 
    c.customer_id, 
    c.name, 
    c.location,
    SUM(s.total_amount) AS total_spent
FROM Customer c
JOIN Sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.name, c.location
HAVING SUM(s.total_amount) > 300000;

SELECT * FROM Customers_High_Spenders;


--3. Materialized View for Monthly Sales Summary
--Unlike a regular view that computes queries dynamically on every call, a Materialized View physically caches and stores the aggregated result set for high-performance retrieval. Below is the standard implementation (using PostgreSQL/Oracle style date syntax):
CREATE VIEW Monthly_Sales_Summary 
WITH SCHEMABINDING AS
SELECT 
    -- Truncates date to the start of the month (e.g., 2024-01-01)
    DATEADD(month, DATEDIFF(month, 0, s.sale_date), 0) AS sales_month,
    SUM(ISNULL(s.quantity, 0)) AS total_items_sold,
    SUM(ISNULL(s.total_amount, 0)) AS total_sales_revenue,
    -- In SQL Server indexed views, you must use COUNT_BIG(*) instead of COUNT(id)
    COUNT_BIG(*) AS total_transactions
FROM dbo.Sales s
GROUP BY DATEADD(month, DATEDIFF(month, 0, s.sale_date), 0);

-- Create Procedule
CREATE PROCEDURE update_product_price
AS
BEGIN
    -- Inform SQL Server not to return an extra "row(s) affected" message text
    SET NOCOUNT ON;

    UPDATE Products
    SET price = price * 1.10
    WHERE product_name = 'Phone';
END;
GO

EXEC update_product_price;

SELECT * FROM Products;