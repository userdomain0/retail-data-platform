 
-- 資料來源
-- Kaggle / Grocery Sales Database

 
-- 1. sales 約675萬筆資料
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[raw].[sales]') AND type in (N'U'))
DROP TABLE [raw].[sales]

 
CREATE TABLE [raw].[sales](
	[SalesID] [int] NULL,
	[SalesPersonID] [int] NULL,
	[CustomerID] [int] NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NULL,
	[Discount] [float] NULL,
	[TotalPrice] [float] NULL,
	[SalesDate] [datetime] NULL,
	[TransactionNumber] [varchar](50) NULL,
	-- audit 
    load_date DATETIME DEFAULT GETDATE()
) ON [PRIMARY]

 
-- 2. products.csv 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[raw].[products]') AND type in (N'U'))
DROP TABLE [raw].products 


CREATE TABLE raw.products  (
    ProductID INT  NULL, 
    ProductName VARCHAR(255)  NULL, 
    Price FLOAT  NULL, 
    CategoryID  VARCHAR(50)  NULL, 
    Class VARCHAR(50)  NULL,
    ModifyDate DATETIME  NULL,
    Resistant VARCHAR(50) NULL,
    IsAllergic VARCHAR(50) NULL,
    VitalityDays INT NULL,
	-- audit 
    load_date DATETIME DEFAULT GETDATE() NULL 
);
 

 -- 3. employees.csv 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[raw].[employees]') AND type in (N'U'))
DROP TABLE [raw].employees

--EmployeeID,FirstName,MiddleInitial,LastName,BirthDate,Gender,CityID,HireDate
CREATE TABLE raw.employees (
    EmployeeID INT  NULL, 
    FirstName VARCHAR(50) NULL,
    MiddleInitial VARCHAR(50) NULL,
    LastName VARCHAR(50) NULL,
    BirthDate [datetime] NULL,
    Gender VARCHAR(2) NULL,
    CityID VARCHAR(50) NULL,
    HireDate [datetime] NULL, 
	-- audit 
    load_date DATETIME DEFAULT GETDATE() NULL
);

 -- 4. customers.csv 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[raw].[customers]') AND type in (N'U'))
DROP TABLE [raw].customers

--CustomerID,FirstName,MiddleInitial,LastName,CityID,Address
CREATE TABLE raw.customers (
    CustomerID INT  NULL, 
    FirstName VARCHAR(50) NULL,
    MiddleInitial VARCHAR(50) NULL,
    LastName VARCHAR(50) NULL, 
    CityID VARCHAR(2) NULL,
    Address  VARCHAR(50) NULL,
	-- audit 
    load_date DATETIME DEFAULT GETDATE() NULL
);


-- 5. countries.csv 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[raw].[country]') AND type in (N'U'))
DROP TABLE [raw].country

--CountryID,CountryName,CountryCode

CREATE TABLE raw.country (
    CountryID INT  , 
    CountryName VARCHAR(50) ,
    CountryCode VARCHAR(50) , 
	-- audit 
    load_date DATETIME DEFAULT GETDATE() NULL
);



-- 6. cities.csv 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[raw].[city]') AND type in (N'U'))
DROP TABLE [raw].city

--CityID,CityName,Zipcode,CountryID

CREATE TABLE raw.city (
    CityID INT  NULL, 
    CityName VARCHAR(50) NULL,
    Zipcode INT NULL,
    CountryID INT NULL, 
	-- audit 
    load_date DATETIME DEFAULT GETDATE() NULL
);




-- 7. category.csv 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[raw].[category]') AND type in (N'U'))
DROP TABLE [raw].category 

--CateryID,CateryName

CREATE TABLE raw.category (
    CategoryID INT  NULL, 
    CategoryName VARCHAR(50) NULL, 
	-- audit 
    load_date DATETIME DEFAULT GETDATE() NULL
);

