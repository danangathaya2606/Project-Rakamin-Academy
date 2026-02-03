SELECT
  -- Primary transaction details from kf_final_transaction
  ft.transaction_id, 
  ft.date,   
  ft.branch_id,   

  -- Branch location and performance details from kf_kantor_cabang
  kc.branch_name,   
  kc.kota,   
  kc.provinsi,   
  kc.rating AS rating_cabang,   

  -- Product and customer information
  ft.customer_name,   
  ft.product_id,   
  p.product_name,   
  p.price AS actual_price,   
  ft.discount_percentage,
  ft.rating AS rating_transaksi,   

  -- Logic to determine Gross Profit Percentage based on price tiers
  CASE   
    WHEN p.price <= 50000 THEN 0.10   
    WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15   
    WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20   
    WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25   
    WHEN p.price > 500000 THEN 0.30   
  END AS persentase_gross_laba,   

  -- Financial Calculations:
  -- 1. Nett Sales (Price after discount)
  (p.price * (1 - ft.discount_percentage)) AS nett_sales,   

  -- 2. Nett Profit (Applying tiered margin to the original price)
  (p.price * CASE   
      WHEN p.price <= 50000 THEN 0.10   
      WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15   
      WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20   
      WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25   
      WHEN p.price > 500000 THEN 0.30   
    END) AS nett_profit   

-- Merging datasets using JOINs on primary and foreign keys
FROM 
  `rakamin-academy-data-analytic.kimia_farma.kf_final_transaction` AS ft
JOIN 
  `rakamin-academy-data-analytic.kimia_farma.kf_kantor_cabang` AS kc
    ON ft.branch_id = kc.branch_id  
JOIN 
  `rakamin-academy-data-analytic.kimia_farma.kf_product` AS p
    ON ft.product_id = p.product_id;
