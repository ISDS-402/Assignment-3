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
SELECT LastName, FirstName, Phone
FROM CUSTOMER
WHERE CustomerID IN
	(SELECT SaleID
	FROM SALE
	WHERE SaleID = 1);
	
/*******************************/

/* Listing LastName, FirstName, and Phone of the customer who made the purchase with SaleID 1 using an inner join*/
SELECT LastName, FirstName, Phone
FROM CUSTOMER AS C INNER JOIN SALE AS S
  ON C.CustomerID  = S.CustomerID
 WHERE S.SaleID = 1;
 
 /*******************************/

/* LastName, FirstName, and Phone of the customers who made the purchases with SaleIDs 1, 2, and 3 using asubquery.*/
SELECT LastName, FirstName, Phone  
FROM CUSTOMER
WHERE CustomerID IN   
  (SELECT CustomerID
  FROM SALE
  WHERE SaleID IN (1,2,3));
  
/*******************************/

/*LastName, FirstName, and Phone of the customers who made the purchases with SaleIDs 1, 2, and 3 using an INNER JOIN. */
SELECT LastName, FirstName, Phone
FROM CUSTOMER AS C INNER JOIN SALE AS S
  ON C.CustomerID = S.CustomerID
WHERE S.SaleID IN (1,2,3);

/*******************************/

/* LastName, FirstName, and Phone of customers who have made at least one purchase with SubTotal greater 
than $500. Use a subquery */

SELECT CustomerID, LastName, FirstName, Phone 
FROM CUSTOMER
WHERE CustomerID IN 
  (SELECT CustomerID
   FROM SALE
   WHERE SubTotal > 500);
/*******************************/
 
/* LastName, FirstName, and Phone of customers who have made at least one purchase with SubTotal greater 
than $500. Use a JOIN */

SELECT C.CustomerID, LastName, FirstName, Phone
FROM CUSTOMER AS C INNER JOIN SALE AS S
  ON C.CustomerID = S.CustomerID
WHERE S.SubTotal > 500;

/*******************************/

/* Listing the LastName, FirstName, and Phone of customers who
have purchased an item that has an ItemPrice of $500 or more. Use a subquery.*/ 

	/* Use the CUSTOMER, SALE, AND SALE_ITEM tables. Refer to P.185.
	For Inner Join on the three tables, refer to p. 191 */

/*******************************/

/* LastName, FirstName, and Phone of customers who have purchased an item that was supplied by a vendor with a 
CompanyName that begins with the letter L. Use a subquery. */
	
	/* Use the CUSTOMERS, SALE, */

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

	/* Use the CUSTOMER, SALE, AND SALE_ITEM tables. Refer to P.185.
	For Inner Join on the three tables, refer to p. 191 */

/* N */
SELECT LastName, FirstName, Phone
FROM CUSTOMER AS C JOIN SALE AS S
	ON C.CustomerID = S.SaleID
	JOIN SALE_ITEM AS SI
	ON S.SaleID = SI.SaleID
WHERE ItemPrice > 500;

/*******************************/

/* LastName, FirstName, and Phone of customers who have purchased an item that was supplied by a vendor with a 
CompanyName that begins with the letter L. Use a subquery. */

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

	/* Use the CUSTOMERS, SALE, */

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

/* Q */
/* Write SQL statement to show sum of SubTotal for each customer. List CustomerID, LastName. FirstName, Phone, and the calcualted result.
Name the result as SumOfSubTotal and sort the results by CustomerID. in descending order */

SELECT CustomerID, LastName, FirstName, Phone, SUM(SubTotal) AS SumOfSubTotal
FROM CUSTOMER AS C JOIN SALE AS S
	ON C.CustomerID = S.CustomerID
GROUP BY C.CustomerID, LastName, FirstName, Phone
ORDER BY C.CustomerID DESC;

/*R */
UPDATE VENDOR
 SET CompanyName = 'Linens and Other Stuff'
 WHERE CompanyName = 'Linens and Things';

/* S */
UPDATE VENDOR
SET CompanyName = 'Linens and Things'
WHERE CompanyName = 'Lamps and Lighting';

/* T */
/* Given assumptions about cascading deletions, write the fewest number of DELETE statements possible to remove all data in database but leave table structure intact */
TRUNCATE TABLE CUSTOMER;
TRUNCATE TABLE EMPLOYEE;
TRUNCATE TABLE VENDOR;
TRUNCATE TABLE ITEM;
TRUNCATE TABLE SALE;
TRUNCATE TABLE SALE_ITEM;

