Here are the SQL queries to solve each question:

Question 1: Achieving 1NF

CREATE TABLE ProductDetail_1NF (
  OrderID INT,
  CustomerName VARCHAR(255),
  Product VARCHAR(255)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT 
  OrderID,
  CustomerName,
  TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM 
  ProductDetail
  JOIN (SELECT a.N + b.N * 10 + 1 n FROM (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a , (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b ORDER BY n) n
  ON CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= n.n - 1;


Question 2: Achieving 2NF

CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerName VARCHAR(255)
);

CREATE TABLE OrderDetails (
  OrderID INT,
  Product VARCHAR(255),
  Quantity INT,
  PRIMARY KEY (OrderID, Product),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT 
  OrderID,
  CustomerName
FROM 
  OrderDetails;

INSERT INTO OrderDetails (OrderID, Product, Quantity)
SELECT 
  OrderID,
  Product,
  Quantity
FROM 
  OrderDetails;
