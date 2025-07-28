-- Project 2
-- Library management System 
-- There are more table so we just create and IMPORT TABLE FROM
-- CREATE branch TABLE##############################################################
-- DROP TABLE  IF EXISTS branch;
CREATE TABLE branch(
         branch_id VARCHAR(20) PRIMARY KEY,
         manager_id VARCHAR(20),
         branch_address VARCHAR(50),
         contact_no VARCHAR (20)
);

-- CREATE employee table #####################################################
CREATE TABLE employee(
         emp_id VARCHAR(15) PRIMARY KEY,
         emp_name VARCHAR(20),
         job_position VARCHAR(30),
         salary INT,
         branch_id VARCHAR(15) -- FOREIGN Key
);
         
-- CREATE book Table #########################################################################
CREATE TABLE books(
         isb VARCHAR(30) PRIMARY KEY,
         book_title VARCHAR(100),
         category VARCHAR(15),
         rental_price FLOAT,
         sttus VARCHAR(15),
         author VARCHAR(35),
         publisher VARCHAR(50)
);

-- CREATE member Table###############################################################
CREATE TABLE members(
       member_id VARCHAR(15) PRIMARY KEY,
       member_name VARCHAR(25),
       member_address VARCHAR(50),
       reg_date DATE
);

-- CREATE issued_status Table#################################################################
CREATE TABLE isued_status(
       issued_id VARCHAR(15) PRIMARY KEY,
       issued_member_id VARCHAR(15), -- FOREIGN KEY
       issued_book_name VARCHAR(50),
       issued_date DATE,
       issued_book_isbn VARCHAR(50), -- FOREIGN KEY
       issued_emp_id VARCHAR(15) -- FOREIGN KEY
);
-- CREATE return_status TABLE
CREATE TABLE return_status(
return_id VARCHAR(15) PRIMARY KEY,
         issued_id VARCHAR(15),
         return_book_name VARCHAR(50),
         return_date DATE,
         return_book_isbn VARCHAR (30)
);

-- FOREIGN KEY should be primary key in other tabel and not be null
SELECT *
FROM books;

SELECT *
FROM branch;

SELECT *
FROM employee;

SELECT *
FROM isued_status;

SELECT * 
FROM members;

SELECT *
FROM return_status;

-- Project Questions
-- ==============================================================================================================================================
-- Task 1: create a new Book record " '576-1-67574-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.' "
-- =================================================================================================================================================
INSERT INTO books(isb, book_title, category, rental_price, sttus, author, publisher)
VALUES
      ('576-1-67574-456-2', 'To Kill a Mockingbird','Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.') ;
SELECT *
FROM books ;
-- ==================================================================================================================================
-- Task 2: UPDATE an Existing Member's Address
-- =======================================================================================================================
UPDATE members
SET member_address = '321 saint martin'
WHERE member_id = 'C101';
SELECT *
FROM members;
-- =================================================================================
-- Task 3: DELETE a recorde from the Issued status Table
-- Objective: DELETE the record with issued_id = 'IS104' frm the issued_status table
-- ======================================================================================== 
DELETE FROM isued_status
WHERE issued_id = 'IS104';
SELECT *
FROM isued_status;
-- =================================================================================================================================
-- Task 4: Retrieve all books issued by a Specific Employee 
-- Objetive: Select all books issued by the employee with issued_emp_id = 'E101'
-- ==================================================================================================================================
SELECT *
FROM isued_status
WHERE issued_emp_id = 'E101';
-- ===============================================================================================
-- Task 5: List Members who have issued More than one book
-- Objective: Use GROUP BY to find MEMBERs who have issued more than one book
-- ===============================================================================================
SELECT 
   issued_emp_id,
   COUNT(issued_id)
FROM isued_status
GROUP BY issued_emp_id;
-- ======================================================================================
-- Task 6: Retrieve all books in a specific category
-- ==================================================================================
SELECT 
category,
author
FROM books -- WHERE category = 'Classilc'
GROUP BY category, author;
-- =====================================================================================
-- Task 7: Find total rental Income by category
-- ===============================================================================
SELECT 
    category,
    SUM(rental_price)
FROM books
GROUP BY category;
-- =================================================================================
-- Task 8: List Members who are old_reg or New
-- =================================================================================
SELECT *,
DATEDIFF('2024-06-01',reg_date) as date_gap,
case 
   WHEN DATEDIFF('2024-06-01',reg_date) > 180 THEN 'Older_Reg'
   WHEN DATEDIFF('2024-06-01',reg_date)<=180 THEN 'New_Some'
   ELSE 'DO Registreation'
END as Registration
FROM members;
-- ===========================================================================================
-- Task 9: Employee WITH their branch manager's Name and their branch detail
-- =====================================================================================
SELECT 
employee.branch_id,
employee.emp_name,
branch.branch_address,
branch.manager_id
FROM branch
LEFT JOIN employee
ON employee.branch_id = branch.branch_id;

-- =====================================================================================
-- Task 10: CREATE a table of Books with rental price above a certain thersold 10 USD;
-- ======================================================================================
CREATE TABLE books_price_greater_than_seven
AS 
SELECT *
FROM books
WHERE rental_price >7;
SELECT *
FROM books_price_greater_than_seven










