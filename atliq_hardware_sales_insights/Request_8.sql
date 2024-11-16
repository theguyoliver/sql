-- In which quarter of 2020, got the maximum total_sold_quantity? The final
-- output contains these fields sorted by the total_sold_quantity,
-- Quarter
-- total_sold_quantity

SELECT 
	CASE 
		WHEN MONTH(date) IN (1,2,3) THEN 'First'
		WHEN MONTH(date) IN (4,5,6) THEN 'Second'
        WHEN MONTH(date) IN (7,8,9) THEN 'Third'
        ELSE 'Fourth'
	END AS Quarter,
    SUM(sold_quantity) AS total_sold_quantity
FROM
	fact_sales_monthly
WHERE fiscal_year = 2020
GROUP BY Quarter
ORDER BY total_sold_quantity DESC
LIMIT 1;