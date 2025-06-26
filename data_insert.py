import sqlite3
import pandas as pd

#Inserting data from csv into tables made in schema.sql
def data_insert():
    #Creating new smaller dataframs for items, payments, and locations
    #Removing unknown values and duplicates to ensure uniqueness
    df = pd.read_csv("clean_cafe_sales.csv")

    valid_items = df.dropna(subset=["Item", "Price Per Unit"])
    items = valid_items[["Item", "Price Per Unit"]].drop_duplicates().reset_index(drop=True)
    items["item_id"] = items.index + 1

    valid_payments = df.dropna(subset=["Payment Method"])
    payments = valid_payments[["Payment Method"]].drop_duplicates().reset_index(drop=True)
    payments["payment_id"] = payments.index + 1

    valid_locations = df.dropna(subset=["Location"])
    locations = valid_locations[["Location"]].drop_duplicates().reset_index(drop=True)
    locations["location_id"] = locations.index + 1

    #Merging smaller dataframes into the original dataframe to allow lookup (foreign keys)
    df = df.merge(items, how="left", on=["Item", "Price Per Unit"])
    df = df.merge(payments, how="left", on="Payment Method")
    df = df.merge(locations, how="left", on="Location")

    #Create final transactions dataframe (have to make here because I needed merged items, payments, and location
    #since they are foreign keys for transactions)
    transactions = df[["Transaction ID", "item_id", "payment_id", "location_id",
                       "Transaction Date", "Total Spent", "Quantity"]]
    
    #Inserting the data
    connection = sqlite3.connect("cafe_sales.db")
    cursor = connection.cursor()
    cursor.executemany(
        "INSERT OR IGNORE INTO Items (item_id, item_name, price_per_unit) VALUES (?, ?, ?)", 
        items[["item_id", "Item", "Price Per Unit"]].values.tolist()
    )
    cursor.executemany(
        "INSERT OR IGNORE INTO Payment (payment_id, payment_method) VALUES (?, ?)", 
        payments[["payment_id", "Payment Method"]].values.tolist()
    )
    cursor.executemany(
        "INSERT OR IGNORE INTO Location (location_id, location_type) VALUES (?, ?)", 
        locations[["location_id", "Location"]].values.tolist()
    )
    cursor.executemany(
        "INSERT OR IGNORE INTO Transactions (transaction_id, item_id, payment_id, location_id, transaction_date, total_spent, quantity) VALUES (?, ?, ?, ?, ?, ?, ?)", 
        transactions.values.tolist()
    )
    connection.commit()
    connection.close()

if __name__ == "__main__":
    data_insert()