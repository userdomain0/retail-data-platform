Use RetailDW;
go

DROP TABLE IF EXISTS dw.fact_sales;

CREATE TABLE dw.fact_sales (
    sales_key BIGINT IDENTITY(1,1),

    date_key DATE NOT NULL,
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

INSERT INTO dw.fact_sales (
    date_key,
    product_key,

    customer_key,
    salesperson_key,
    quantity,
    total_price,
    discount,
    transaction_number,  
    load_date
)
SELECT
    ISNULL(s.date_key, '1900-01-01'),

    ISNULL(dp.product_key, 0),
    ISNULL(dc.customer_key, 0),
    ISNULL(dsp.salesperson_key, 0),

    s.quantity,
    s.total_price,
    s.discount,
    s.transaction_number, 
    GETDATE()

FROM staging.sales_clean s

LEFT JOIN dw.dim_products dp
    ON s.product_id = dp.product_id 

LEFT JOIN dw.dim_customer dc
    ON s.customer_id = dc.CustomerID

LEFT JOIN dw.dim_salesperson dsp
    ON s.salesperson_id = dsp.EmployeeID

--WHERE s.is_valid = 1;