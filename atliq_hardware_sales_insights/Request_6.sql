-- Generate a report which contains the top 5 customers who received an
-- average high pre_invoice_discount_pct for the fiscal year 2021 and in the
-- Indian market. The final output contains these fields,
-- customer_code
-- customer
-- average_discount_percentage

WITH TB1 AS
	(
    SELECT customer_code AS A, AVG(fact_pre_invoice_deductions.pre_invoice_discount_pct) AS B
	FROM fact_pre_invoice_deductions
	WHERE fiscal_year = 2021
	GROUP BY customer_code
    ),
    TB2 AS
    (
    SELECT customer_code AS C, customer AS D
    FROM dim_customer
    WHERE market = 'India'
    )
SELECT 
	TB1.A AS customer_code, 
    TB2.D AS customer, 
    ROUND(TB1.B, 2) AS average_discount_percentage
FROM 
	TB1 INNER JOIN TB2
	ON TB1.A = TB2.C
ORDER BY average_discount_percentage DESC
LIMIT 5;