DROP TABLE IF EXISTS gold.dim_customers;
GO

CREATE TABLE gold.dim_customers(
	customer_key	INT IDENTITY(1,1) NOT NULL,
	customer_id		INT NOT NULL,
	customer_number	NVARCHAR(50),
	firstname		NVARCHAR(50),
	lastname		NVARCHAR(50),
	gender			NVARCHAR(50),
	birthdate		DATE,
	country			NVARCHAR(50),
	marital_status	NVARCHAR(50),
	create_date		DATE,
	CONSTRAINT PK_gold_dim_customers PRIMARY KEY(customer_key)
);

DROP TABLE IF EXISTS gold.dim_products;
GO

CREATE TABLE gold.dim_products(
	product_key		INT IDENTITY(1,1) NOT NULL,
	product_id		INT NOT NULL,
	product_number	NVARCHAR(50) NOT NULL,
	product_name	NVARCHAR(50),
	category_id		NVARCHAR(50),
	category		NVARCHAR(50),
	subcategory		NVARCHAR(50),
	maintenance		NVARCHAR(50),
	product_line	NVARCHAR(50),
	product_cost	INT,
	start_date		DATE,
	CONSTRAINT PK_gold_dim_products PRIMARY KEY(product_key)
);

DROP TABLE IF EXISTS gold.fact_sales;
GO

CREATE TABLE gold.fact_sales(
	order_number	NVARCHAR(50) NOT NULL,
	product_key		INT NOT NULL,
	customer_key	INT NOT NULL,
	order_date		DATE,
	shipping_date	DATE,
	due_date		DATE,
	sales_amount	INT,
	quantity		INT,
	price			INT,
	CONSTRAINT FK_fact_sales_products FOREIGN KEY(product_key)
		REFERENCES gold.dim_products(product_key),
	CONSTRAINT FK_fact_sales_customers FOREIGN KEY(customer_key)
		REFERENCES gold.dim_customers(customer_key)
);
GO