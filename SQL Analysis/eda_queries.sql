CREATE DATABASE IF NOT EXISTS data_analysis_project;
USE data_analysis_project;
CREATE TABLE coal_data (
  id INT PRIMARY KEY AUTO_INCREMENT,
  Coal_RB_4800_FOB_London_Close_USD FLOAT,
  Coal_RB_5500_FOB_London_Close_USD FLOAT,
  Coal_RB_5700_FOB_London_Close_USD FLOAT,
  Coal_RB_6000_FOB_CurrentWeek_Avg_USD FLOAT,
  Coal_India_5500_CFR_London_Close_USD FLOAT
  -- Add all columns matching your CSV header row
);
select * from coal_data;

SHOW CREATE TABLE coal_data;

-- Enable local_infile on the server (requires admin/root privileges)
SET GLOBAL local_infile = 1;

-- Load data from the CSV file into the coal_data table
LOAD DATA LOCAL INFILE 'C:\\Users\\palni\\Downloads\\cleaned_data.csv'
INTO TABLE coal_data
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(Coal_RB_4800_FOB_London_Close_USD, Coal_RB_5500_FOB_London_Close_USD, Coal_RB_5700_FOB_London_Close_USD, Coal_RB_6000_FOB_CurrentWeek_Avg_USD, Coal_India_5500_CFR_London_Close_USD);


SELECT
  AVG(Coal_RB_4800_FOB_London_Close_USD) AS mean_coal_4800,
  AVG(Coal_RB_5500_FOB_London_Close_USD) AS mean_coal_5500,
  AVG(Coal_RB_5700_FOB_London_Close_USD) AS mean_coal_5700,
  AVG(Coal_RB_6000_FOB_CurrentWeek_Avg_USD) AS mean_coal_6000,
  AVG(Coal_India_5500_CFR_London_Close_USD) AS mean_india_5500,
  
  VARIANCE(Coal_RB_4800_FOB_London_Close_USD) AS var_coal_4800,
  VARIANCE(Coal_RB_5500_FOB_London_Close_USD) AS var_coal_5500,
  VARIANCE(Coal_RB_5700_FOB_London_Close_USD) AS var_coal_5700,
  VARIANCE(Coal_RB_6000_FOB_CurrentWeek_Avg_USD) AS var_coal_6000,
  VARIANCE(Coal_India_5500_CFR_London_Close_USD) AS var_india_5500,
  
  STDDEV(Coal_RB_4800_FOB_London_Close_USD) AS std_coal_4800,
  STDDEV(Coal_RB_5500_FOB_London_Close_USD) AS std_coal_5500,
  STDDEV(Coal_RB_5700_FOB_London_Close_USD) AS std_coal_5700,
  STDDEV(Coal_RB_6000_FOB_CurrentWeek_Avg_USD) AS std_coal_6000,
  STDDEV(Coal_India_5500_CFR_London_Close_USD) AS std_india_5500,
  
  (MAX(Coal_RB_4800_FOB_London_Close_USD) - MIN(Coal_RB_4800_FOB_London_Close_USD)) AS range_coal_4800,
  (MAX(Coal_RB_5500_FOB_London_Close_USD) - MIN(Coal_RB_5500_FOB_London_Close_USD)) AS range_coal_5500,
  (MAX(Coal_RB_5700_FOB_London_Close_USD) - MIN(Coal_RB_5700_FOB_London_Close_USD)) AS range_coal_5700,
  (MAX(Coal_RB_6000_FOB_CurrentWeek_Avg_USD) - MIN(Coal_RB_6000_FOB_CurrentWeek_Avg_USD)) AS range_coal_6000,
  (MAX(Coal_India_5500_CFR_London_Close_USD) - MIN(Coal_India_5500_CFR_London_Close_USD)) AS range_india_5500

FROM coal_data;


-- Median for Coal_RB_4800_FOB_London_Close_USD
SET @rowindex := -1;
SELECT AVG(sub.Col) AS median_Coal_RB_4800_FOB_London_Close_USD
FROM (
    SELECT @rowindex := @rowindex + 1 AS rowindex, Coal_RB_4800_FOB_London_Close_USD AS Col
    FROM coal_data
    WHERE Coal_RB_4800_FOB_London_Close_USD IS NOT NULL
    ORDER BY Coal_RB_4800_FOB_London_Close_USD
) AS sub
WHERE sub.rowindex IN (FLOOR(@rowindex / 2), CEIL(@rowindex / 2));

-- Median for Coal_RB_5500_FOB_London_Close_USD
SET @rowindex := -1;
SELECT AVG(sub.Col) AS median_Coal_RB_5500_FOB_London_Close_USD
FROM (
    SELECT @rowindex := @rowindex + 1 AS rowindex, Coal_RB_5500_FOB_London_Close_USD AS Col
    FROM coal_data
    WHERE Coal_RB_5500_FOB_London_Close_USD IS NOT NULL
    ORDER BY Coal_RB_5500_FOB_London_Close_USD
) AS sub
WHERE sub.rowindex IN (FLOOR(@rowindex / 2), CEIL(@rowindex / 2));

-- Median for Coal_RB_5700_FOB_London_Close_USD
SET @rowindex := -1;
SELECT AVG(sub.Col) AS median_Coal_RB_5700_FOB_London_Close_USD
FROM (
    SELECT @rowindex := @rowindex + 1 AS rowindex, Coal_RB_5700_FOB_London_Close_USD AS Col
    FROM coal_data
    WHERE Coal_RB_5700_FOB_London_Close_USD IS NOT NULL
    ORDER BY Coal_RB_5700_FOB_London_Close_USD
) AS sub
WHERE sub.rowindex IN (FLOOR(@rowindex / 2), CEIL(@rowindex / 2));

-- Median for Coal_RB_6000_FOB_CurrentWeek_Avg_USD
SET @rowindex := -1;
SELECT AVG(sub.Col) AS median_Coal_RB_6000_FOB_CurrentWeek_Avg_USD
FROM (
    SELECT @rowindex := @rowindex + 1 AS rowindex, Coal_RB_6000_FOB_CurrentWeek_Avg_USD AS Col
    FROM coal_data
    WHERE Coal_RB_6000_FOB_CurrentWeek_Avg_USD IS NOT NULL
    ORDER BY Coal_RB_6000_FOB_CurrentWeek_Avg_USD
) AS sub
WHERE sub.rowindex IN (FLOOR(@rowindex / 2), CEIL(@rowindex / 2));

-- Median for Coal_India_5500_CFR_London_Close_USD
SET @rowindex := -1;
SELECT AVG(sub.Col) AS median_Coal_India_5500_CFR_London_Close_USD
FROM (
    SELECT @rowindex := @rowindex + 1 AS rowindex, Coal_India_5500_CFR_London_Close_USD AS Col
    FROM coal_data
    WHERE Coal_India_5500_CFR_London_Close_USD IS NOT NULL
    ORDER BY Coal_India_5500_CFR_London_Close_USD
) AS sub
WHERE sub.rowindex IN (FLOOR(@rowindex / 2), CEIL(@rowindex / 2));
