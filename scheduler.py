import schedule
import time
import pandas as pd
from sqlalchemy import create_engine, text

def run_pipeline():
    print("Pipeline started...")

    # Extract
    df = pd.read_csv("sales.csv")

    # Transform
    df = df.dropna(subset=["customer_name"])
    df["quantity"] = df["quantity"].fillna(1)
    df["order_date"] = pd.to_datetime(df["order_date"], errors="coerce")
    df = df.dropna(subset=["order_date"])
    df["revenue"] = df["quantity"] * df["unit_price"]
    df["order_month"] = df["order_date"].dt.to_period("M").astype(str)
    df["region"] = df["region"].str.strip().str.title()
    df["product"] = df["product"].str.strip().str.title()

    # Load
    engine = create_engine("mysql+pymysql://root:@localhost:3306/sales_db")
    df.to_sql(name="sales", con=engine, if_exists="replace", index=False)
    print("Pipeline completed successfully!")

# Schedule daily at 7AM
schedule.every().day.at("07:00").do(run_pipeline)

print("Scheduler running...")
while True:
    schedule.run_pending()
    time.sleep(60)