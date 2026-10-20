-- ===================
-- crm_cust_info TABLE
-- ===================
SELECT *
FROM bronze.crm_cust_info

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT cst_id, COUNT(*) 
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Check for Unwanted Spaces
-- Expectation: No Result
SELECT cst_firstname 
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

-- Data Standardization & Consistency
SELECT DISTINCT cst_marital_status 
FROM bronze.crm_cust_info

SELECT DISTINCT cst_gndr 
FROM bronze.crm_cust_info


-- ===================
-- crm_prd_info TABLE
-- ===================
SELECT *
FROM bronze.crm_prd_info

SELECT *
FROM bronze.crm_sales_details

SELECT *
FROM bronze.erp_px_cat_g1v2

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Result
SELECT prd_id, COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Check for Unwanted Spaces
-- Expectation: No Result
SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)



-- Check for Nulls or Negative Numbers
-- Expectation: No Result
SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data Standardization & Consistency
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info



-- ===================
-- crm_sales_details TABLE
-- ===================

SELECT * FROM bronze.crm_sales_details
SELECT * FROM bronze.crm_cust_info
SELECT * FROM silver.crm_prd_info

SELECT *
FROM bronze.crm_sales_details bsd, silver.crm_prd_info spi
WHERE bsd.sls_prd_key = spi.prd_key

-- Checking Dates
SELECT sls_order_dt
FROM
bronze.crm_sales_details
WHERE sls_order_dt <= 0
OR LEN(sls_order_dt) != 8

SELECT sls_ship_dt
FROM
bronze.crm_sales_details
WHERE sls_ship_dt <= 0
OR LEN(sls_ship_dt) != 8

SELECT sls_due_dt
FROM
bronze.crm_sales_details
WHERE sls_due_dt <= 0
OR LEN(sls_due_dt) != 8

SELECT sls_sales
FROM
bronze.crm_sales_details
WHERE sls_sales <= 0 OR sls_sales IS NULL

SELECT sls_price
FROM
bronze.crm_sales_details
WHERE sls_price <= 0 OR sls_price IS NULL

SELECT sls_quantity
FROM
bronze.crm_sales_details
WHERE sls_quantity <= 0 OR sls_quantity IS NULL

SELECT sls_sales
FROM
bronze.crm_sales_details
WHERE sls_sales != sls_quantity * ABS(sls_price)



-- ===================
-- erp_cust_az12 TABLE
-- ===================

SELECT * FROM bronze.erp_cust_az12

-- Checking Primary key
SELECT cid 
FROM
bronze.erp_cust_az12
WHERE cid LIKE 'NAS%'

-- Checking Dates
SELECT bdate 
FROM
bronze.erp_cust_az12
WHERE  bdate > GETDATE()

-- Checking Gender
SELECT DISTINCT gen 
FROM
bronze.erp_cust_az12

SELECT gen 
FROM
bronze.erp_cust_az12
WHERE gen = ''


-- ===================
-- erp_loc_a101 TABLE
-- ===================

SELECT * FROM bronze.erp_loc_a101

SELECT
DISTINCT cntry
FROM bronze.erp_loc_a101


-- ===================
-- erp_px_cat_g1v2 TABLE
-- ===================
SELECT * FROM bronze.erp_px_cat_g1v2
WHERE id NOT IN(
SELECT cat_id FROM silver.crm_prd_info)

SELECT * FROM bronze.erp_px_cat_g1v2