Use RetailDW;
go

-- 建立維度表（Dimensions）
-- 1.dim_date 
DROP TABLE IF EXISTS dw.dim_date;
CREATE TABLE dw.dim_date (
    date_key DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT,
    weekday INT,
    weekday_name NVARCHAR(10),
    is_weekend BIT
);

WITH d AS (
    SELECT CAST('2018-01-01' AS DATE) AS d
    UNION ALL
    SELECT DATEADD(DAY, 1, d)
    FROM d
    WHERE d < '2018-12-31'
)
INSERT INTO dw.dim_date(
    date_key,
    year,
    month,
    day,
    weekday,
    weekday_name,
    is_weekend
)

SELECT
    d AS date_key,
    YEAR(d),
    MONTH(d),
    DAY(d),
    case when DATEPART(WEEKDAY, d)=1 then 7
    else DATEPART(WEEKDAY, d) -1 end  , 
    DATENAME(WEEKDAY, d),
    CASE 
        WHEN DATENAME(WEEKDAY, d) IN ('星期六', '星期日') THEN 1 
        ELSE 0 
    END
FROM d
OPTION (MAXRECURSION 0);

-- fact_sales中的欄位date有遺失值,使用1900-01-01補值
INSERT INTO dw.dim_date (
    date_key,
    year,
    month,
    day,
    weekday,
    weekday_name,
    is_weekend 
)
VALUES (
    '1900-01-01',
    1900,
    1,
    1,
    case when DATEPART(WEEKDAY, '1900-01-01')=1 then 7
    else DATEPART(WEEKDAY, '1900-01-01') -1 end  , 
    DATENAME(WEEKDAY, '1900-01-01'), 
    0
);

ALTER TABLE dw.dim_date ADD date_desc VARCHAR(50);
UPDATE dw.dim_date
SET date_desc = 'Unknown'
WHERE date_key = '1900-01-01';

-- 2.dim_product
DROP TABLE IF EXISTS dw.dim_products ;
CREATE TABLE dw.dim_products (
    product_key INT IDENTITY(1,1) PRIMARY KEY, 
    product_id INT UNIQUE,   -- business key（Type1可以unique）
    product_name NVARCHAR(100),
    price DECIMAL(10,2),
    category_id INT,
    class NVARCHAR(50),
    resistant NVARCHAR(50),
    is_allergic NVARCHAR(50),
    vitality_days INT,

    load_date DATE
);

INSERT INTO dw.dim_products(
    product_id,
    product_name,
    price,
    category_id,
    class,
    resistant,
    is_allergic,
    vitality_days,
    load_date
)
SELECT
    ProductID,
    ProductName,
    Price,
    CategoryID,
    Class,
    Resistant,
    IsAllergic,
    VitalityDays,
    load_date
FROM raw.products;


-- 3.dim_category

DROP TABLE IF EXISTS dw.dim_category ;
CREATE TABLE dw.dim_category (
    Category_key INT IDENTITY(1,1) PRIMARY KEY,  
    [CategoryID] INT UNIQUE,   -- business key 
    [CategoryName] NVARCHAR(100), 
    load_date DATE
);

INSERT INTO DW.dim_category(
    [CategoryID],
    [CategoryName],
    [load_date]
)
SELECT 
    [CategoryID],
    [CategoryName],
    [load_date]

FROM RAW.category


-- 4. dim_customer
DROP TABLE IF EXISTS dw.dim_customer;
CREATE TABLE dw.dim_customer (
    customer_key INT IDENTITY(1,1) PRIMARY KEY,
    [CustomerID]INT UNIQUE,   -- business key 
    [FirstName] NVARCHAR(100),
    [MiddleInitial] NVARCHAR(100),
    [LastName] NVARCHAR(100),
    [CityID] INT ,
    [Address] NVARCHAR(100),
    [load_date] DATE
);

INSERT INTO dw.dim_customer(
        [CustomerID]
      ,[FirstName]
      ,[MiddleInitial]
      ,[LastName]
      ,[CityID]
      ,[Address]
      ,[load_date]
)
SELECT
        [CustomerID]
      ,[FirstName]
      ,[MiddleInitial]
      ,[LastName]
      ,[CityID]
      ,[Address]
      ,[load_date]
 FROM [RetailDW].[raw].[customers]

-- 5. dim_salesperson
DROP TABLE IF EXISTS dw.dim_salesperson;
CREATE TABLE dw.dim_salesperson (
    salesperson_key INT IDENTITY(1,1) PRIMARY KEY,
    [EmployeeID]INT UNIQUE,   -- business key 
    [FirstName] NVARCHAR(100), 
    [MiddleInitial] NVARCHAR(100),
    [LastName]NVARCHAR(100),
    [BirthDate] DATE,
    [Gender]NVARCHAR(100),
    [CityID] INT,
    [HireDate]DATE,
    [load_date]DATE

);

INSERT INTO dw.dim_salesperson (
        [EmployeeID]
      ,[FirstName]
      ,[MiddleInitial]
      ,[LastName]
      ,[BirthDate]
      ,[Gender]
      ,[CityID]
      ,[HireDate]
      ,[load_date] 
)SELECT
[EmployeeID]
      ,[FirstName]
      ,[MiddleInitial]
      ,[LastName]
      ,[BirthDate]
      ,[Gender]
      ,[CityID]
      ,[HireDate]
      ,[load_date]
  FROM [RetailDW].[raw].[employees]

  /*
  --改用dim_geography
  --6. dim_city
  DROP TABLE IF EXISTS dw.dim_city;
  CREATE TABLE dw.dim_city (
        City_key INT IDENTITY(1,1) PRIMARY KEY,
      [CityID]INT UNIQUE,   -- business key 
      [CityName]NVARCHAR(100), 
      [Zipcode] INT ,
      [CountryID] INT,
      [load_date] DATE
  
  )

  INSERT INTO dw.dim_city(
        [CityID],
        [CityName],
        [Zipcode],
        [CountryID],
        [load_date]
  )SELECT
        [CityID],
        [CityName],
        [Zipcode],
        [CountryID],
        [load_date]
        FROM [RetailDW].[raw].[city]


--7.dim_country
DROP TABLE IF EXISTS dw.dim_country;
CREATE TABLE dw.dim_country(
    [Country_key] INT IDENTITY(1,1) PRIMARY KEY,
    [CountryID] INT UNIQUE,   -- business key ,
    [CountryName]NVARCHAR(100), 
    [CountryCode]NVARCHAR(10) ,
    [load_date] DATE
);
INSERT INTO dw.dim_country(
       [CountryID]
      ,[CountryName]
      ,[CountryCode]
      ,[load_date])
SELECT
[CountryID]
      ,[CountryName]
      ,[CountryCode]
      ,[load_date]
      FROM [RetailDW].[raw].[country]

     */