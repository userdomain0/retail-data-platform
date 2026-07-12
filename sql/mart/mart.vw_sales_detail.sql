DROP VIEW IF EXISTS mart.vw_sales_detail;
GO 

create view mart.vw_sales_detail
as 
SELECT  S.transaction_number, S.product_key, P.product_name, S.quantity, S.discount, P.price, P.price * S.quantity AS gross_amount, (P.price * S.quantity) 
               * (1 - S.discount) AS sales_amount, P.price * S.quantity * S.discount AS discount_amount, dw.dim_category.CategoryName, P.class, S.date_key
FROM     dw.dim_category RIGHT OUTER JOIN
               dw.dim_products AS P ON dw.dim_category.CategoryID = P.category_id RIGHT OUTER JOIN
               dw.fact_sales AS S ON P.product_key = S.product_key