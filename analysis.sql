-- Сверка количества строк. Должно быть ровно 10 000 в обеих таблицах
SELECT 
    (SELECT count(*) FROM staging_raw_data) as rows_in_raw,
    (SELECT count(*) FROM sales_records) as rows_in_fact;

-- Проверка на наличие "сирот" -- все результаты должны быть 0. Это значит, что каждый факт привязан к справочнику
SELECT 
    count(*) FILTER (WHERE product_id IS NULL) as facts_without_product,
    count(*) FILTER (WHERE customer_id IS NULL) as facts_without_customer,
    count(*) FILTER (WHERE store_id IS NULL) as facts_without_store
FROM sales_records;

-- Проверка связей -- если этот запрос возвращает данные, значит все цепочки foreign keys работают корректно
SELECT 
    s.record_id,
    -- Цепочка: sales_records -> dim_customers -> dim_locations
    c.full_name_first || ' ' || c.full_name_last as customer,
    l_cust.country as customer_country,
    
    -- Цепочка: sales_records -> dim_products -> dim_prod_types
    p.title as product_name,
    t.category_name as category,
    
    -- Цепочка: sales_records -> dim_stores -> dim_locations
    st.store_title as shop,
    l_store.city as shop_city
FROM sales_records s
JOIN dim_customers c ON s.customer_id = c.cust_id
JOIN dim_locations l_cust ON c.loc_id = l_cust.loc_id
JOIN dim_products p ON s.product_id = p.prod_id
JOIN dim_prod_types t ON p.type_id = t.type_id
JOIN dim_stores st ON s.store_id = st.store_id
JOIN dim_locations l_store ON st.loc_id = l_store.loc_id
LIMIT 5;

-- Статистика наполненности таблиц модели
SELECT 'dim_locations' as table_name, count(*) as record_count FROM dim_locations
UNION ALL
SELECT 'dim_prod_types', count(*) FROM dim_prod_types
UNION ALL
SELECT 'dim_customers', count(*) FROM dim_customers
UNION ALL
SELECT 'dim_products', count(*) FROM dim_products
UNION ALL
SELECT 'dim_suppliers', count(*) FROM dim_suppliers
UNION ALL
SELECT 'dim_stores', count(*) FROM dim_stores;

-- Топ 5 стран по выручке 
SELECT 
    l.country, 
    count(s.record_id) as total_sales,
    round(sum(s.revenue_total), 2) as revenue
FROM sales_records s
JOIN dim_stores st ON s.store_id = st.store_id
JOIN dim_locations l ON st.loc_id = l.loc_id
GROUP BY l.country
ORDER BY revenue DESC
LIMIT 5;