CREATE OR ALTER PROCEDURE gold.load_gold AS
BEGIN
	TRUNCATE TABLE gold.fact_sales;
	
	DELETE FROM gold.dim_customers;
	DBCC CHECKIDENT ('gold.dim_customers', RESEED, 0);
	INSERT INTO gold.dim_customers(
		customer_id,
		customer_number,
		firstname,
		lastname,
		gender,
		birthdate,
		country,
		marital_status,
		create_date	
	)
	SELECT
		ci.cst_id,
		ci.cst_key,
		ci.cst_firstname,
		ci.cst_lastname,
		CASE 
			WHEN ci.cst_gndr != 'N/A' THEN ci.cst_gndr
			ELSE ISNULL(ca.gen, 'N/A')
		END									AS gender,
		ca.bdate,
		lo.cntry,
		ci.cst_marital_status,
		ci.cst_create_date
	FROM silver.crm_cust_info ci
	LEFT JOIN silver.erp_cust_az12 ca
		ON ci.cst_key = ca.cid
	LEFT JOIN silver.erp_loc_a101 lo
		ON ci.cst_key = lo.cid;

	DELETE FROM gold.dim_products;
	DBCC CHECKIDENT ('gold.dim_products', RESEED, 0);
	INSERT INTO gold.dim_products(
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
	)
	SELECT
		pn.prd_id			AS product_id,
		pn.prd_key			AS product_number,
		pn.prd_nm			AS product_name,
		pn.cat_id			AS category_id,
		px.cat				AS category,
		px.subcat			AS subcategory,
		px.maintenance		AS maintenance,
		pn.prd_line			AS product_line,
		pn.prd_cost			AS product_cost,
		pn.prd_start_dt		AS start_date
	FROM silver.crm_prd_info pn
	LEFT JOIN silver.erp_px_cat_g1v2 px
		ON pn.cat_id = px.id
	WHERE pn.prd_end_dt IS NULL; -- Filter out all historical data

	INSERT INTO gold.fact_sales(
		order_number,
		product_key,
		customer_key,
		order_date,
		shipping_date,
		due_date,
		sales_amount,
		quantity,
		price
	)
	SELECT
		sd.sls_ord_num,
		pr.product_key,
		cu.customer_key,
		sd.sls_order_dt,
		sd.sls_ship_dt,
		sd.sls_due_dt,
		sd.sls_sales,
		sd.sls_quantity,
		sd.sls_price
	FROM silver.crm_sales_details sd
	LEFT JOIN gold.dim_customers cu
		ON sd.sls_cust_id = cu.customer_id
	LEFT JOIN gold.dim_products pr
		ON sd.sls_prd_key = pr.product_number;
END