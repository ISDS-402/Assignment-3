/* 
	Displaying Queries for questions D-T
	
	Kroenke, Auer, Vandenberg, and Yoder	
	Database Concepts (8th Edition) Chapter 03 

	QACS Database Questions. P.257
*/

USE QACS
GO
										/* Displaying column names for all table*/
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

										
/* SQL statement to list ItemID and ItemDescription for all items that cost $1000 or more.*/

SELECT ItemId, ItemDescription
FROM ITEM
WHERE ItemCost >= 1000;

/*******************************/

/* Listing ItemID and ItemDescription for all items that cost $1000 or more purchased from a vendor whose CompanyName starts with letters New.*/ 
SELECT ItemID, ItemDescription, CompanyName AS 'Vendor_Company_Name'
FROM ITEM INNER JOIN VENDOR
	ON  ITEM.VendorID = VENDOR.VendorID
WHERE ITEM.ItemCost >= 1000
AND VENDOR.CompanyName LIKE 'New%'

/*******************************/

/* Listing LastName, FirstName, and Phone of the customer who made the purchase with SaleID 1 using a subquery*/
SELECT FirstName, LastName, Phone
FROM CUSTOMER
WHERE CustomerID IN
	(SELECT SaleID
	FROM SALE
	WHERE SaleID = 1)

/*******************************/