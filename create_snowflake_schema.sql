DROP TABLE IF EXISTS sales_records;
DROP TABLE IF EXISTS dim_products;
DROP TABLE IF EXISTS dim_stores;
DROP TABLE IF EXISTS dim_customers;
DROP TABLE IF EXISTS dim_suppliers;
DROP TABLE IF EXISTS dim_prod_types;
DROP TABLE IF EXISTS dim_locations;

CREATE TABLE dim_locations (
    loc_id SERIAL PRIMARY KEY,
    city TEXT,
    state TEXT,
    country TEXT,
    zip_code TEXT
);

CREATE TABLE dim_prod_types (
    type_id SERIAL PRIMARY KEY,
    category_name TEXT,
    pet_kind TEXT
);

CREATE TABLE dim_suppliers (
    sup_id SERIAL PRIMARY KEY,
    company_name TEXT,
    contact_name TEXT,
    email TEXT,
    phone TEXT,
    loc_id INT REFERENCES dim_locations(loc_id)
);

CREATE TABLE dim_products (
    prod_id SERIAL PRIMARY KEY,
    title TEXT,
    brand TEXT,
    type_id INT REFERENCES dim_prod_types(type_id),
    sup_id INT REFERENCES dim_suppliers(sup_id),
    unit_price DECIMAL,
    net_weight DECIMAL,
    color TEXT,
    material TEXT
);

CREATE TABLE dim_customers (
    cust_id SERIAL PRIMARY KEY,
    full_name_first TEXT,
    full_name_last TEXT,
    email TEXT,
    age INT,
    pet_name TEXT,
    pet_type TEXT,
    loc_id INT REFERENCES dim_locations(loc_id)
);

CREATE TABLE dim_stores (
    store_id SERIAL PRIMARY KEY,
    store_title TEXT,
    contact_phone TEXT,
    contact_email TEXT,
    loc_id INT REFERENCES dim_locations(loc_id)
);

CREATE TABLE sales_records (
    record_id SERIAL PRIMARY KEY,
    transaction_date DATE,
    product_id INT REFERENCES dim_products(prod_id),
    customer_id INT REFERENCES dim_customers(cust_id),
    store_id INT REFERENCES dim_stores(store_id),
    qty_sold INT,
    revenue_total DECIMAL
);