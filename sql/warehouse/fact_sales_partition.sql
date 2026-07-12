Use RetailDW;
go

DROP TABLE IF EXISTS dw.fact_sales;

CREATE TABLE dw.fact_sales (
    sales_key BIGINT IDENTITY(1,1),

    date_key INT NOT NULL,
    product_key INT NOT NULL,
    customer_key INT NOT NULL,
    salesperson_key INT NOT NULL,

    quantity INT,
    discount DECIMAL(10,2),
    total_price DECIMAL(18,2),

    transaction_number NVARCHAR(50), 
    load_date DATE
)
ON ps_sales_date(date_key);  --  Partition(依年月)


CREATE CLUSTERED COLUMNSTORE INDEX CCI_fact_sales
ON dw.fact_sales;
INSERT INTO dw.fact_sales
               (date_key, product_key, customer_key, salesperson_key
               , quantity, total_price, discount, transaction_number, load_date )
/*WHERE s.is_valid = 1;*/
SELECT  ISNULL( convert(int,convert(varchar(8),s.date_key,112)), 19000101)  
        , ISNULL(dp.product_key, 0)  
        , ISNULL(dc.customer_key, 0)  
        , ISNULL(dsp.salesperson_key, 0)  
        , s.quantity
        , s.total_price
        , s.discount
        , s.transaction_number
        , GETDATE()  
FROM     stage.sales_clean AS s LEFT OUTER JOIN
               dw.dim_products AS dp ON s.product_id = dp.product_id LEFT OUTER JOIN
               dw.dim_customer AS dc ON s.customer_id = dc.CustomerID LEFT OUTER JOIN
               dw.dim_salesperson AS dsp ON s.salesperson_id = dsp.EmployeeID