DROP TABLE IF EXISTS staging_raw_data;

CREATE TABLE staging_raw_data (
    id INT,
    c_first_name TEXT, c_last_name TEXT, c_age INT, c_email TEXT, c_country TEXT, c_zip TEXT,
    c_pet_type TEXT, c_pet_name TEXT, c_pet_breed TEXT,
    s_first_name TEXT, s_last_name TEXT, s_email TEXT, s_country TEXT, s_zip TEXT,
    p_name TEXT, p_category TEXT, p_price DECIMAL, p_stock_qty INT,
    order_date DATE, order_customer_id INT, order_seller_id INT, order_product_id INT, order_qty INT, order_total_price DECIMAL,
    shop_name TEXT, shop_location TEXT, shop_city TEXT, shop_state TEXT, shop_country TEXT, shop_phone TEXT, shop_email TEXT,
    animal_category TEXT, p_weight DECIMAL, p_color TEXT, p_size TEXT, p_brand TEXT, p_material TEXT,
    p_desc TEXT, p_rating DECIMAL, p_reviews_cnt INT, p_release_dt DATE, p_expiry_dt DATE,
    vendor_name TEXT, vendor_contact TEXT, vendor_email TEXT, vendor_phone TEXT, vendor_address TEXT, vendor_city TEXT, vendor_country TEXT
);

COPY staging_raw_data FROM '/data/mock_data.csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');
COPY staging_raw_data FROM '/data/mock_data (1).csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');
COPY staging_raw_data FROM '/data/mock_data (2).csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');
COPY staging_raw_data FROM '/data/mock_data (3).csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');
COPY staging_raw_data FROM '/data/mock_data (4).csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');
COPY staging_raw_data FROM '/data/mock_data (5).csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');
COPY staging_raw_data FROM '/data/mock_data (6).csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');
COPY staging_raw_data FROM '/data/mock_data (7).csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');
COPY staging_raw_data FROM '/data/mock_data (8).csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');
COPY staging_raw_data FROM '/data/mock_data (9).csv' WITH (FORMAT CSV, HEADER, DELIMITER ',');