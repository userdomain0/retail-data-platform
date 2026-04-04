-- DIM_GEOGRAPHY 完整地理維度
-- dim_geography 

USE RetailDW;
DROP TABLE IF EXISTS dw.dim_country_continent;
CREATE TABLE dw.dim_country_continent(
country_name VARCHAR(100), continent VARCHAR(100)
);


INSERT INTO dw.dim_country_continent (country_name, continent)
VALUES
-- Asia
('Taiwan', 'Asia'),
('Japan', 'Asia'),
('South Korea', 'Asia'),
('China', 'Asia'),
('Singapore', 'Asia'),
('Thailand', 'Asia'),

-- Europe
('United Kingdom', 'Europe'),
('France', 'Europe'),
('Germany', 'Europe'),
('Italy', 'Europe'),
('Spain', 'Europe'),

-- North America
('United States', 'North America'),
('Canada', 'North America'),
('Mexico', 'North America'),

-- South America
('Brazil', 'South America'),
('Argentina', 'South America'),

-- Oceania
('Australia', 'Oceania'),
('New Zealand', 'Oceania'),

-- Africa
('South Africa', 'Africa'),
('Egypt', 'Africa');



DROP TABLE IF EXISTS dw.dim_geography ;
CREATE TABLE dw.dim_geography (
	geography_key INT IDENTITY(1,1) PRIMARY KEY,

    city_id INT,
    city_name NVARCHAR(100),
    --region_id INT,
    --region_name NVARCHAR(100),
    country_id INT,
    country_name NVARCHAR(100), 
    continent NVARCHAR(50),
    load_date DATETIME
);

INSERT INTO dw.dim_geography
SELECT   raw.city.CityID, raw.city.CityName, 
raw.country.CountryID, raw.country.CountryName,  dw.dim_country_continent.continent ,GETDATE()
FROM      raw.city left OUTER JOIN
                   raw.country ON raw.city.CountryID = raw.country.CountryID left OUTER JOIN
                   dw.dim_country_continent ON raw.country.CountryName = dw.dim_country_continent.country_name


SELECT * FROM dw.dim_geography