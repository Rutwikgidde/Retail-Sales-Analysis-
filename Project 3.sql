CREATE DATABASE Retailsalesdb;

USE Retailsalesdb

-- Create the Products table

CREATE TABLE Products(Product_Id INT PRIMARY KEY, Product_name VARCHAR(100), Category VARCHAR (100), Price DECIMAL(10,2))

-- Create the sales table
CREATE TABLE sales(salesid INT PRIMARY KEY , productid INT, customerid INT, salesdate DATETIME, quantity INT , FOREIGN KEY (productid)REFERENCES products(product_Id))

-- Create the customers table

CREATE TABLE customers (customerid INT PRIMARY KEY , firstname CHAR(10), lastname CHAR(10))

-- Insert sample data into Products table

INSERT INTO Products(Product_Id,Product_name,Category,Price) VALUES
(1, 'Laptop', 'Electronics', 1000.00),
(2, 'Smartphone', 'Electronics', 500.00),
(3, 'Headphones', 'Accessories', 150.00),
(4, 'Mouse', 'Accessories', 25.00);

-- Insert sample data into customers table

INSERT INTO customers (customerid, firstname, lastname) VALUES
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Bob', 'Johnson');-- Insert sample data into sales tableINSERT INTO sales(salesid, productid, customerid, salesdate, quantity) VALUES
(1, 1, 1, '2023-08-01', 2),
(2, 2, 2, '2023-08-02', 1),
(3, 3, 1, '2023-08-03', 3),
(4, 4, 3, '2023-08-04', 4),
(5, 1, 3, '2023-08-05', 1);-- Select all columns from Products tableSELECT * FROM Products;-- Select all customers and their firstname and lastnameSELECT CustomerID, FirstName, LastName FROM Customers;-- Group sales by Product and calculate the total salesSELECT p.Product_name , SUM(s.quantity) AS totalsales
FROM sales AS s inner join Products AS p ON s.productid=p.Product_Id
GROUP BY p.Product_name
ORDER BY totalsales
-- Count number of sales for each customerSELECT c.firstname,c.lastname, COUNT(s.salesid) AS numberofpurchasesFROM sales AS s inner join customers AS c ON s.customerid=c.customeridGROUP BY c.firstname,c.lastnameORDER BY numberofpurchases desc-- Use HAVING to find products with sales greater thanSELECT product_name FROM Products WHERE Product_Id in ( SELECT Product_Id FROM sales GROUP BY productid HAVING sum (quantity)>1)-- Pagination: Get sales records from row 11 to row 20SELECT s.salesid,p.Product_Id, p.Product_Id, c.firstname,s.quantityFROM sales AS s inner join Products AS p ON s.productid=p.Product_Idinner join customers AS c ON s.customerid=c.customeridORDER BY s.salesdateoffset 10 ROWS FETCH NEXT 10 ROWS only-- Generate a summary reportSELECT p.Category, COUNT(DISTINCT  c.customerid) as total_customers FROM sales AS s inner join Products AS p ON s.productid=p.Product_Idinner join customers AS c ON s.customerid=c.customeridGROUP BY p.Category