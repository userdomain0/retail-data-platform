--CREATE SCHEMA staging;
--GO 
use RetailDW;
/* 
資料清理過程
CSV
 ↓
staging.sales
 ↓（clean） 
 staging.sales_clean
 ↓
raw.sales（partition）
*/


 
DROP TABLE IF  EXISTS  [staging].[sales];
CREATE TABLE  [staging].[sales](
    sales_id BIGINT,
    salesperson_id INT,
    customer_id INT,
    product_id INT,
    quantity INT,
    discount DECIMAL(5,2),
    total_price DECIMAL(10,2),
    sales_datetime DATETIME2(3),
    transaction_number VARCHAR(50) 
);


BULK INSERT  [staging].[sales]
FROM 'C:\Users\userdomaiin\MyProject\retail-data-platform\data\raw\sales.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);

/*
SalesDate missing values were preserved as NULL during preprocessing. 
However, this caused aggregation issues (e.g., NULL year/quarter). 
In a production-grade data warehouse
, these should be handled using a default date key (e.g., -1) 
to maintain analytical integrity.

SalesDate中包含遺失值,這會造成進行聚合問題,
例如:年度,季度等,在資料倉儲中,
應該使用預設日期鍵(例如:-1)來避免這些問題,
以維護分析完整性

*/ 

-- Data Quality Rules
-- 建立欄位判斷異常資料
ALTER TABLE [staging].[sales]
ADD is_valid INT NULL, invalid_reason VARCHAR(50) NULL ;
 

UPDATE [staging].[sales]
   SET  is_valid =  
        CASE 
        WHEN total_price < 0 THEN 0
        WHEN quantity <= 0 THEN 0
        WHEN sales_datetime IS NULL  THEN 0
        ELSE 1 END
      ,invalid_reason = CASE 
        WHEN total_price < 0 THEN 'Negative Price'
        WHEN quantity <= 0 THEN 'Invalid Quantity'
        WHEN sales_datetime IS NULL  THEN 'MISSING datetime'
        ELSE NULL END
GO


-- 將清理完成的資料匯入[raw].[sales] 
-- Kimball 經典做法:Unknown date（未知日期）設計
-- 給定一個「預設日期」代表未知 1900-01-01
DROP TABLE IF EXISTS staging.sales_clean
SELECT
    sales_id,
    salesperson_id,
    customer_id,
    product_id,
    quantity,
    discount,
    total_price,
    sales_datetime,
    CAST(
    CASE WHEN sales_datetime IS NULL THEN '1900-01-01' ELSE sales_datetime END AS DATE) as date_key,  -- ⭐ partition key
    transaction_number,
    is_valid,
    invalid_reason

INTO staging.sales_clean
FROM staging.sales


DROP TABLE IF EXISTS raw.sales; 

GO
CREATE TABLE raw.sales ( 
    date_key INT NOT NULL,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    salesperson_id INT,

    quantity INT,
    discount DECIMAL(5,2),
    total_amount DECIMAL(18,2),

    transaction_number VARCHAR(50),

    -- Data Quality Flag 
    is_valid INT,
    invalid_reason VARCHAR(50)
)
ON ps_sales_date(date_key);


-- date_key (partition + join) vs SalesDate (保留原始時間)
-- partition pruning（只掃某幾個月）
-- 避免同一天資料亂序
-- 支援 range scan
CREATE CLUSTERED COLUMNSTORE INDEX CCI_fact_sales
ON raw.sales
ON ps_sales_date(date_key);
 

CREATE NONCLUSTERED INDEX IX_raw_sales_lookup
ON raw.sales (product_id, customer_id);



INSERT INTO raw.sales  ( 
    date_key  ,
    product_id  ,
    customer_id  ,
    salesperson_id  ,

    quantity  ,
    discount  ,
    total_amount  ,

    transaction_number  ,

    -- Data Quality Flag 
    is_valid,
    invalid_reason
)
SELECT  CAST(CONVERT(VARCHAR(8), [date_key], 112) AS INT)
      ,[product_id]
      ,[customer_id]
      ,[salesperson_id]
      ,[quantity]
      ,[discount]
      ,[total_price]
      ,[transaction_number]
      ,[is_valid]
      ,[invalid_reason]
  FROM [RetailDW].[staging].[sales_clean]