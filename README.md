# Chocolate Sale Analysis for SQL (Sample Project)

## 📌 專案介紹
這是一個使用 SQL 對巧克力銷售資料進行分析的專案，目標是：

1. 找出銷售最好的產品、地區與銷售人員  
2. 計算每個維度的銷售總額與排名  
3. 產生前 10 名銷售潛力區，用於後續商業決策或視覺化呈現  

> 本專案的主要目的：展示 SQL 聚合、窗口函數、CTE、JOIN 與欄位計算能力。  

---

---

## 🛠️ 環境與依賴
- MySQL 8.0 或以上  
- Python 3.x  
  - pandas  
  - mysql-connector-python  
- （可選）Tableau / Power BI 連線 MySQL  

---
## 📂 專案結構
chocolate_sale_analysis_for_sql_real/
│
├─ data/ # 原始 CSV 檔案
│ └─ chocolate_sales.csv
│
├─ sql/ # SQL 查詢檔案
│ ├─ import_data.sql # 匯入 CSV 至 MySQL
│ ├─ top_products.sql # 前 N 名產品銷售分析
│ ├─ top_sales_person.sql # 前 N 名銷售人分析
│ └─ top_country.sql # 各國銷售總覽
│
├─ python/ # Python 用來測試 SQL 串接
│ └─ query_sql.py
│
└─ README.md # 專案說明

