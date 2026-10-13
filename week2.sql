CREATE DATABASE Ecommerce;
USE Ecommerce;

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50) NOT NULL
);

CREATE TABLE Seller (
    Seller_ID VARCHAR(10) PRIMARY KEY,
    Seller_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Address VARCHAR(100)
);

CREATE TABLE Inventory (
    Inventory_ID INT PRIMARY KEY,
    Product_ID INT NOT NULL,
    Seller_ID VARCHAR(10) NOT NULL,
    Stock_Quantity INT NOT NULL CHECK (Stock_Quantity >= 0),
    Stock_Status VARCHAR(20) NOT NULL,
    Last_Updated DATE,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Seller_ID) REFERENCES Seller(Seller_ID)
);

INSERT INTO Product VALUES
(101,'Laptop'),
(102,'Shoes'),
(103,'Mobile');

INSERT INTO Seller VALUES
('S101','ABC Store','abc@gmail.com','9876543210','Chennai'),
('S102','Tech Store','tech@gmail.com','9876543211','Bangalore'),
('S103','Fashion Store','fashion@gmail.com','9876543212','Mumbai');

INSERT INTO Inventory VALUES
(1,101,'S101',20,'Available',CURDATE()),
(2,101,'S102',15,'Available',CURDATE()),
(3,102,'S103',50,'Available',CURDATE()),
(4,103,'S101',0,'Out of Stock',CURDATE());

-- Add Seller
INSERT INTO Seller VALUES
('S104','New Store','new@gmail.com','9876543213','Delhi');


SELECT s.Seller_Name,p.Product_Name,i.Stock_Quantity
FROM Seller s
JOIN Inventory i ON s.Seller_ID=i.Seller_ID
JOIN Product p ON i.Product_ID=p.Product_ID;


SELECT s.Seller_Name,COUNT(i.Product_ID) AS Products_Supplied
FROM Seller s
LEFT JOIN Inventory i ON s.Seller_ID=i.Seller_ID
GROUP BY s.Seller_Name;


UPDATE Seller
SET Phone='9999999999'
WHERE Seller_ID='S101';


SELECT p.Product_Name,i.Stock_Quantity
FROM Product p
JOIN Inventory i ON p.Product_ID=i.Product_ID
WHERE i.Stock_Quantity>0;


SELECT p.Product_Name
FROM Product p
JOIN Inventory i ON p.Product_ID=i.Product_ID
WHERE i.Stock_Quantity=0;


SELECT Product_ID,Stock_Quantity
FROM Inventory
WHERE Stock_Quantity<10;


UPDATE Inventory
SET Stock_Quantity=Stock_Quantity+10,
    Stock_Status='Available',
    Last_Updated=CURDATE()
WHERE Inventory_ID=4;

-- Remove Discontinued Inventory
DELETE FROM Inventory
WHERE Inventory_ID=4;

-- Seller-wise Report
SELECT s.Seller_Name,
COUNT(DISTINCT i.Product_ID) AS Products_Supplied,
SUM(i.Stock_Quantity) AS Available_Stock
FROM Seller s
LEFT JOIN Inventory i ON s.Seller_ID=i.Seller_ID
GROUP BY s.Seller_Name;

-- Stock Availability Report
SELECT p.Product_Name,i.Stock_Quantity,i.Stock_Status
FROM Product p
JOIN Inventory i ON p.Product_ID=i.Product_ID;


SELECT COUNT(DISTINCT Product_ID) AS Total_Products
FROM Inventory
WHERE Stock_Quantity>0;


SELECT COUNT(DISTINCT Product_ID) AS Out_Of_Stock
FROM Inventory
WHERE Stock_Quantity=0;


SELECT Product_ID,MAX(Stock_Quantity) AS Highest_Stock
FROM Inventory
GROUP BY Product_ID;

SELECT AVG(Stock_Quantity) AS Average_Quantity
FROM Inventory;

select * from product;