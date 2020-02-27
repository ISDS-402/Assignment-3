/* 
	Displaying Queries for questions D-T
	
	Kroenke, Auer, Vandenberg, and Yoder	
	Database Concepts (8th Edition) Chapter 03 

	QACS Database Questions. P.257
*/

USE QACS
GO
										
/* D */
SELECT COLUMN_NAME AS 'CUSTOMER_COLUMN_NAMES'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CUSTOMER';

SELECT COLUMN_NAME AS 'EMPLOYEE_COLUMN_NAMES'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'EMPLOYEE';

SELECT COLUMN_NAME AS 'ITEM_COLUMN_NAMES'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ITEM';

SELECT COLUMN_NAME AS 'SALE_COLUMN_NAMES'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SALE';

SELECT COLUMN_NAME AS 'SALE_ITEM_COLUMN_NAMES'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'SALE_ITEM';

SELECT COLUMN_NAME AS 'VENDOR_COLUMN_NAMES'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'VENDOR';

/********************************************************************************/

										
/* E */
SELECT ItemId, ItemDescription
FROM ITEM
WHERE ItemCost >= 1000;

/*******************************/

/* F */ 
SELECT ItemID, ItemDescription, CompanyName AS 'Vendor_Company_Name'
FROM ITEM INNER JOIN VENDOR
	ON  ITEM.VendorID = VENDOR.VendorID
WHERE ITEM.ItemCost >= 1000
AND VENDOR.CompanyName LIKE 'New%'

/*******************************/

/* G */
SELECT LastName, FirstName, Phone
FROM CUSTOMER
WHERE CustomerID IN
	(SELECT SaleID
	FROM SALE
	WHERE SaleID = 1);
	
/*******************************/

/* H */
SELECT LastName, FirstName, Phone
FROM CUSTOMER AS C INNER JOIN SALE AS S
  ON C.CustomerID  = S.CustomerID
 WHERE S.SaleID = 1;
 
 /*******************************/

/* I */
SELECT LastName, FirstName, Phone  
FROM CUSTOMER
WHERE CustomerID IN   
  (SELECT CustomerID
  FROM SALE
  WHERE SaleID IN (1,2,3));
  
/*******************************/

/* J */
SELECT LastName, FirstName, Phone
FROM CUSTOMER AS C INNER JOIN SALE AS S
  ON C.CustomerID = S.CustomerID
WHERE S.SaleID IN (1,2,3);

/*******************************/

/* K */

SELECT CustomerID, LastName, FirstName, Phone 
FROM CUSTOMER
WHERE CustomerID IN 
  (SELECT CustomerID
   FROM SALE
   WHERE SubTotal > 500);

/*******************************/
 
/* L */

SELECT C.CustomerID, LastName, FirstName, Phone
FROM CUSTOMER AS C INNER JOIN SALE AS S
  ON C.CustomerID = S.CustomerID
WHERE S.SubTotal > 500;

/*******************************/

/* M */
SELECT LastName, FirstName, Phone
FROM   CUSTOMER
WHERE  CustomerID IN
	(SELECT CustomerID
	 FROM SALE
	 WHERE SaleID IN
	 (SELECT SaleID
	  FROM SALE_ITEM
	  WHERE ItemPrice > 500));

/*******************************/

/* N */
SELECT LastName, FirstName, Phone
FROM CUSTOMER AS C JOIN SALE AS S
	ON C.CustomerID = S.SaleID
	JOIN SALE_ITEM AS SI
	ON S.SaleID = SI.SaleID
WHERE ItemPrice > 500;

/*******************************/

/* O */
SELECT LastName, FirstName, Phone
FROM CUSTOMER
WHERE CustomerID IN
	(SELECT CustomerID
	 FROM SALE
	 WHERE SaleID IN
	 (Select SaleID
	 FROM SALE_ITEM
	 WHERE ItemID IN
	 (SELECT ItemID 
	  FROM ITEM
	  WHERE VendorID IN
	  (SELECT VendorID 
	   FROM VENDOR
	   WHERE CompanyName LIKE 'L%'))));

/*******************************/

/*P*/
SELECT DISTINCT LastName, FirstName, C.Phone
FROM CUSTOMER AS C JOIN SALE AS S
	ON C.CustomerID = S.SaleID
	JOIN SALE_ITEM AS SI
	ON S.SaleID = SI.SaleID
	JOIN ITEM AS I
	ON SI.ItemID = I.ItemID
	JOIN VENDOR AS V
	ON I.VendorID = V.VendorID
	WHERE CompanyName LIKE 'L%';

/*******************************/

/* Q */
/* Write SQL statement to show sum of SubTotal for each customer. List CustomerID, LastName. FirstName, Phone, and the calcualted result.
Name the result as SumOfSubTotal and sort the results by CustomerID. in descending order */

SELECT C.CustomerID, LastName, FirstName, Phone, SUM(SubTotal) AS SumOfSubTotal
FROM CUSTOMER AS C JOIN SALE AS S
	ON C.CustomerID = S.CustomerID
GROUP BY C.CustomerID, LastName, FirstName, Phone
ORDER BY C.CustomerID DESC;

/*******************************/

/*R */
UPDATE VENDOR
 SET CompanyName = 'Linens and Other Stuff'
 WHERE CompanyName = 'Linens and Things';

 /*******************************/

/* S */
UPDATE VENDOR
SET CompanyName = 'Temp'
WHERE CompanyName = 'Lamps and Lighting';

UPDATE VENDOR
SET CompanyName = 'Lamps and Lighting'
WHERE CompanyName = 'Linens and Things';

UPDATE VENDOR
SET CompanyName = 'Linens and Things'
WHERE CompanyName = 'Temp';

/*******************************/

/* T */
/* Given assumptions about cascading deletions, write the fewest number of DELETE statements possible to remove all data in database but leave table structure intact */
TRUNCATE TABLE SALE_ITEM;
TRUNCATE TABLE CUSTOMER;
TRUNCATE TABLE VENDOR;
TRUNCATE TABLE EMPLOYEE;
TRUNCATE TABLE ITEM;
TRUNCATE TABLE SALE;
