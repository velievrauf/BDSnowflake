CREATE TABLE raw_data_import (
    id TEXT, customer_first_name TEXT, customer_last_name TEXT, customer_age TEXT,
    customer_email TEXT, customer_country TEXT, customer_postal_code TEXT,
    customer_pet_type TEXT, customer_pet_name TEXT, customer_pet_breed TEXT,
    seller_first_name TEXT, seller_last_name TEXT, seller_email TEXT,
    seller_country TEXT, seller_postal_code TEXT,
    product_name TEXT, product_category TEXT, product_price TEXT, product_quantity TEXT,
    sale_date TEXT, sale_customer_id TEXT, sale_seller_id TEXT, sale_product_id TEXT,
    sale_quantity TEXT, sale_total_price TEXT,
    store_name TEXT, store_location TEXT, store_city TEXT, store_state TEXT,
    store_country TEXT, store_phone TEXT, store_email TEXT,
    pet_category TEXT, product_weight TEXT, product_color TEXT, product_size TEXT,
    product_brand TEXT, product_material TEXT, product_description TEXT,
    product_rating TEXT, product_reviews TEXT, product_release_date TEXT, product_expiry_date TEXT,
    supplier_name TEXT, supplier_contact TEXT, supplier_email TEXT,
    supplier_phone TEXT, supplier_address TEXT, supplier_city TEXT, supplier_country TEXT
);




CREATE TABLE dim_customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100), last_name VARCHAR(100), age INT, 
    email VARCHAR(150), country VARCHAR(100), pet_type VARCHAR(50)
);

CREATE TABLE dim_sellers (
    seller_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100), last_name VARCHAR(100), 
    email VARCHAR(150), country VARCHAR(100)
);

CREATE TABLE dim_stores (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR(150), city VARCHAR(100), 
    country VARCHAR(100), email VARCHAR(150)
);

CREATE TABLE dim_suppliers (
    supplier_id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(150), supplier_email VARCHAR(150), supplier_country VARCHAR(100)
);

CREATE TABLE dim_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255), category VARCHAR(100), brand VARCHAR(100), 
    price DECIMAL(10,2),
    supplier_id INT REFERENCES dim_suppliers(supplier_id) 
);

CREATE TABLE fact_sales (
    sale_id SERIAL PRIMARY KEY,
    sale_date DATE,
    customer_id INT REFERENCES dim_customers(customer_id),
    seller_id INT REFERENCES dim_sellers(seller_id),
    store_id INT REFERENCES dim_stores(store_id),
    product_id INT REFERENCES dim_products(product_id),
    quantity INT,
    total_price DECIMAL(12,2)
);