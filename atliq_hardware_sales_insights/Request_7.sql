-- Get the complete report of the Gross sales amount for the customer “Atliq
-- Exclusive” for each month. This analysis helps to get an idea of low and
-- high-performing months and take strategic decisions.
-- The final report contains these columns:
-- Month
-- Year
-- Gross sales Amount

SELECT 
	MONTH(S.date) AS Month, 
    S.fiscal_year AS Year, 
    ROUND(SUM(S.sold_quantity*G.gross_price)/1000000,2) AS "Gross_sales_amount(Million)"
FROM 
	fact_sales_monthly AS S 
    JOIN fact_gross_price AS G
	ON S.product_code = G.product_code
	JOIN dim_customer AS C 
    ON S.customer_code = C.customer_code
WHERE C.customer = 'Atliq Exclusive'
GROUP BY Month, Year
ORDER BY Year, Month;