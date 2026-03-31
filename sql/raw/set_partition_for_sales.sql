
USE [RetailDW]
GO
 

--CREATE PARTITION FUNCTION
--以年月做分區
-- DROP PARTITION FUNCTION pf_sales_date

CREATE PARTITION FUNCTION pf_sales_date (DATE)
AS RANGE RIGHT FOR VALUES 
(
    '2018-01-01',
    '2018-02-01',
    '2018-03-01',
    '2018-04-01',
    '2018-05-01',
    '2018-06-01',
    '2018-07-01',
    '2018-08-01',
    '2018-09-01',
    '2018-10-01',
    '2018-11-01',
    '2018-12-01',
    '2019-01-01'
);


CREATE PARTITION SCHEME ps_sales_date
AS PARTITION pf_sales_date
ALL TO ([PRIMARY]);

