CREATE OR ALTER VIEW gold.v_dim_customers AS
SELECT
	customer_key,
	customer_id,
	customer_number,
	firstname,
	lastname,
	gender,
	birthdate,
	country,
	marital_status,
	create_date	
FROM gold.dim_customers;
GO

CREATE OR ALTER VIEW gold.v_dim_products AS
SELECT
	product_key,
	product_id,
	product_number,
	product_name,
	category_id,
	category,
	subcategory,
	maintenance,
	product_line,
	product_cost,
	start_date
FROM gold.dim_products;
GO

CREATE OR ALTER VIEW gold.v_fact_sales AS
SELECT
	order_number,
	product_key,
	customer_key,
	order_date,
	shipping_date,
	due_date,
	sales_amount,
	quantity,
	price
FROM gold.fact_sales;
GO