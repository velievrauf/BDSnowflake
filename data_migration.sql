WITH all_locations AS (
    SELECT DISTINCT c_country as country, NULL as city, NULL as state, c_zip as zip FROM staging_raw_data
    UNION
    SELECT DISTINCT shop_country, shop_city, shop_state, NULL FROM staging_raw_data
    UNION
    SELECT DISTINCT vendor_country, vendor_city, NULL, NULL FROM staging_raw_data
)
INSERT INTO dim_locations (country, city, state, zip_code)
SELECT country, city, state, zip FROM all_locations;

INSERT INTO dim_prod_types (category_name, pet_kind)
SELECT DISTINCT p_category, animal_category FROM staging_raw_data;

INSERT INTO dim_suppliers (company_name, contact_name, email, phone, loc_id)
SELECT DISTINCT ON (vendor_name) 
    vendor_name, vendor_contact, vendor_email, vendor_phone, l.loc_id
FROM staging_raw_data r
JOIN dim_locations l ON r.vendor_country = l.country AND r.vendor_city IS NOT DISTINCT FROM l.city;

INSERT INTO dim_stores (store_title, contact_phone, contact_email, loc_id)
SELECT DISTINCT ON (shop_name) 
    shop_name, shop_phone, shop_email, l.loc_id
FROM staging_raw_data r
JOIN dim_locations l ON r.shop_country = l.country AND r.shop_city IS NOT DISTINCT FROM l.city;

INSERT INTO dim_customers (full_name_first, full_name_last, email, age, pet_name, pet_type, loc_id)
SELECT DISTINCT ON (c_email) 
    c_first_name, c_last_name, c_email, c_age, c_pet_name, c_pet_type, l.loc_id
FROM staging_raw_data r
JOIN dim_locations l ON r.c_country = l.country AND r.c_zip IS NOT DISTINCT FROM l.zip_code;

INSERT INTO dim_products (title, brand, type_id, sup_id, unit_price, net_weight, color, material)
SELECT DISTINCT ON (p_name, p_brand) 
    p_name, p_brand, t.type_id, s.sup_id, p_price, p_weight, p_color, p_material
FROM staging_raw_data r
JOIN dim_prod_types t ON r.p_category = t.category_name AND r.animal_category = t.pet_kind
JOIN dim_suppliers s ON r.vendor_name = s.company_name;

INSERT INTO sales_records (transaction_date, product_id, customer_id, store_id, qty_sold, revenue_total)
SELECT 
    r.order_date, 
    p.prod_id, 
    c.cust_id, 
    st.store_id, 
    r.order_qty, 
    r.order_total_price
FROM staging_raw_data r
JOIN dim_products p ON r.p_name = p.title AND r.p_brand = p.brand
JOIN dim_customers c ON r.c_email = c.email
JOIN dim_stores st ON r.shop_name = st.store_title;