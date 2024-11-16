-- Which channel helped to bring more gross sales in the fiscal year 2021
-- and the percentage of contribution? The final output contains these fields,
-- channel
-- gross_sales_mln
-- percentage

WITH CTE1 AS
	(
	SELECT 
		C.channel, 
		ROUND(SUM(sold_quantity*gross_price/1000000), 2) AS gross_sales_mln
	FROM 
		dim_customer AS C JOIN fact_sales_monthly AS S
		ON C.customer_code = S.customer_code
		JOIN fact_gross_price AS G ON S.product_code = G.product_code
	WHERE S.fiscal_year = 2021
	GROUP BY C.channel
	)
SELECT 
	Y.channel, 
    CONCAT(Y.gross_sales_mln, ' M') AS gross_sales_mln, 
    CONCAT(ROUND((Y.gross_sales_mln*100/total), 2), '%') AS percentage
FROM
	(
		(SELECT SUM(gross_sales_mln) AS total FROM CTE1) X,
		(SELECT * FROM CTE1) Y
	)
ORDER BY percentage DESC;