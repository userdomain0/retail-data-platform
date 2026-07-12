USE [RetailDW]
GO

ALTER TABLE dw.dim_category
ADD CategorynName_C NVARCHAR(50);

UPDATE [dw].[dim_category] 
SET CategorynName_C = 
  CASE CategoryName
    WHEN 'Shell fish' THEN N'貝類'
    WHEN 'Poultry' THEN N'家禽肉'
    WHEN 'Snails' THEN N'食品雜貨'      -- 或依你的需求改成「食品雜貨」
    WHEN 'Beverages' THEN N'飲料'
    WHEN 'Produce' THEN N'蔬果'
    WHEN 'Dairy' THEN N'乳製品'
    WHEN 'Seafood' THEN N'海鮮'
    WHEN 'Meat' THEN N'肉品'
    WHEN 'Cereals' THEN N'早餐穀片'
    WHEN 'Confections' THEN N'糖果點心'
    WHEN 'Grain' THEN N'米麥雜糧'
    ELSE N'未分類'
END;
GO

