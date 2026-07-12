SELECT  [date_key],[product_name]
      ,[CategoryName]
      , [class]
      ,sum([quantity] )AS  銷售量
      ,AVG([price]) AS 平均單品售價
      ,SUM([gross_amount]) AS 銷售額_原價
      ,SUM([sales_amount]) as 銷售額_折扣後
      ,SUM([discount_amount]) as 折扣總額
     ,count(distinct [transaction_number]  ) as 交易次數
      
  FROM [RetailDW].[mart].[vw_sales_detail]
  group by  [product_name],[CategoryName]
      ,[class],[date_key]
