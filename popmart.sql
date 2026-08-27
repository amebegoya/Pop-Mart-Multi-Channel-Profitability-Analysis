-- channel_type spellings
SELECT channel_type, COUNT(*) AS total
FROM channels
GROUP BY channel_type
ORDER BY total DESC;

-- cleaned budgets table 
SELECT channel_type, year, budgeted_revenue, budgeted_profit
FROM budgets;

-- cleaned channels table 
SELECT DISTINCT channel_id, channel_name,
	CASE WHEN LOWER(TRIM(channel_type)) IN ('roboshop', 'robo shop', 'vending', 'vending machine') THEN 'RoboShop'
     WHEN LOWER(TRIM(channel_type)) IN ('store', 'physical store', 'store') THEN 'Store'
     when LOWER(TRIM(channel_type)) = 'online' THEN 'Online'
    END AS clean_channel_type,
  	market_id,
    CASE WHEN LOWER(TRIM(country)) IN ('united kingdom', 'uk', 'u.k.') THEN 'United Kingdom'
    	 WHEN LOWER(TRIM(country)) IN ('fr', 'france') THEN 'France'
         WHEN LOWER(TRIM(country)) IN ('it', 'italy') then 'Italy'
         when LOWER(TRIM(country)) IN ('germany', 'de') then 'Germany'
    END AS clean_country, 
 	CAST(REPLACE(REPLACE(annual_running_cost, '£', ''), ',', '') AS NUMERIC) AS running_cost
FROM channels;

-- cleaned sales table 
SELECT DISTINCT transaction_id, channel_id, product_id, quarter, quantity,
    CAST(REPLACE(REPLACE(amount,'£',''),',','') AS REAL) AS amount
FROM sales
WHERE amount IS NOT NULL
    AND channel_id IN (SELECT channel_id FROM channels);
    
-- cleaned products table
SELECT product_id, product_name, 
		CAST(REPLACE(cost_price, '£', '') AS numeric) AS cost_price,
        CAST(REPLACE(sell_price, '£', '') AS numeric) AS sell_price
FROM products;

-- markets table 
SELECT market_id, country, region_code
FROM markets;