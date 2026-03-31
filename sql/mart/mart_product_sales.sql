USE RetailDW;
DROP TABLE IF EXISTS mart.product_sales;
go
CREATE TABLE mart.product_sales (
    date_key DATE NOT NULL,
    product_key INT NOT NULL,
    
    product_name NVARCHAR(100),
    class NVARCHAR(50),
    resistant NVARCHAR(50),
    category_name NVARCHAR(100),

    total_qty INT,
    total_sales DECIMAL(18,2),
    transaction_count INT,
    avg_selling_price DECIMAL(18,2),

    load_datetime DATETIME DEFAULT GETDATE()
);

CREATE CLUSTERED COLUMNSTORE INDEX CCI_mart_product_sales
ON mart.product_sales;

TRUNCATE TABLE mart.product_sales;

INSERT INTO mart.product_sales
SELECT  
    fc.date_key, 
    fc.product_key,
    dp.product_name, 
    dp.class, 
    dp.resistant, 
    dc.CategoryName,

    SUM(fc.quantity) AS total_qty,
    SUM(dp.price * fc.quantity * (1 - fc.discount)) AS total_sales,
    count(distinct fc.transaction_number  )   AS transaction_count, 
    AVG(dp.price * (1 - fc.discount)) AS avg_selling_price,

    GETDATE()

FROM dw.fact_sales fc

LEFT JOIN dw.dim_products dp 
    ON fc.product_key = dp.product_key

LEFT JOIN dw.dim_category dc 
    ON dp.category_id = dc.CategoryID

GROUP BY  
    fc.date_key, 
    fc.product_key,
    dp.product_name, 
    dp.class, 
    dp.resistant, 
    dc.CategoryName;