
# 這一系列的示範程式檔，是為展示操作python、sql、tableau語法操作結合示範。
# 第一部分: Kaggle 下載的csv檔匯入Mysql database裡
# 第二部分: 資料清洗



# first step
import pandas as pd
import pymysql
from sqlalchemy import create_engine

def insert_into_Mysql(file, table_name):
    df = pd.read_csv(file)

    df["Date"] = pd.to_datetime(
        df["Date"],
        format= "%d/%m/%Y",
        errors= "raise"
    )

    # testing
    print(df["Date"].dtype)

    engine = create_engine("mysql+pymysql://#$%^:&^TYUHJK@localhost:3306/practice_1?charset=utf8mb4")

    # testing
    #print(df.columns)
    #print(df.head())

    # watchout: table名要連續不可空白
    df.to_sql(
        name= table_name,     # MySQL 裡的 table 名稱
        con=engine,
        if_exists="append",        # replace / append
        index=False
    )

    # testing : success!! \^O^/
    print("匯入完成！")



insert_into_Mysql("Chocolate Sales.csv", "Chocolate_sales")