USE [RetailDW]
GO
-- 資料來源
-- Kaggle / Grocery Sales Database

 
-- 1. sales 約675萬筆資料
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[raw].[sales_raw]') AND type in (N'U'))
DROP TABLE [raw].[sales_raw]
GO
 
CREATE TABLE [raw].[sales_raw](
	[SalesID] [int] NULL,
	[SalesPersonID] [int] NULL,
	[CustomerID] [int] NULL,
	[ProductID] [int] NULL,
	[Quantity] [int] NULL,
	[Discount] [float] NULL,
	[TotalPrice] [float] NULL,
	[SalesDate] [datetime] NULL,
	[TransactionNumber] [varchar](50) NULL
) ON [PRIMARY]
GO
 
-- 2. products.csv ���~��ƪ�
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[raw].[products_raw]') AND type in (N'U'))
DROP TABLE [raw].products_raw
GO

CREATE TABLE raw.products_raw (
    ProductID INT,
    ProductName VARCHAR(255),
    Price FLOAT,
    CategoryID INT,
    Class VARCHAR(50),
    ModifyDate DATETIME,
    Resistant VARCHAR(50),
    IsAllergic VARCHAR(50),
    VitalityDays INT
);