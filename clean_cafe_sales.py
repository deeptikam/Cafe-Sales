import pandas as pd

def cleaning():

    df = pd.read_csv("dirty_cafe_sales.csv", na_values=["", " ", "UNKNOWN", "ERROR"])

    #here I am getting rid of any duplicates
    df = df.drop_duplicates()

    #here I am setting the correct data types, since right now they are all just object
    df["Quantity"] = pd.to_numeric(df["Quantity"], errors="coerce")
    df["Price Per Unit"] = pd.to_numeric(df["Price Per Unit"], errors="coerce")
    df["Total Spent"] = pd.to_numeric(df["Total Spent"], errors="coerce")
    df["Transaction Date"] = pd.to_datetime(df["Transaction Date"], errors="coerce").dt.date

    #for if total spent is unknown but information needed to calculate total is provided
    df["Total Spent"] = df["Total Spent"].fillna(df["Quantity"] * df["Price Per Unit"])

    #here I am cleaning columns and ensuring NaN usage
    df["Item"] = df["Item"].str.strip(" ._/").str.title()
    df["Item"] = df["Item"].where(df["Item"].notna(), None)
    df["Payment Method"] = df["Payment Method"].where(df["Payment Method"].notna(), None)
    df["Location"] = df["Location"].where(df["Location"].notna(), None)
    df["Transaction Date"] = df["Transaction Date"].where(df["Transaction Date"].notna(), None)

    #here I am getting rid of rows without Id
    df = df.dropna(subset=["Transaction ID"])

    #creating new csv
    df.to_csv("clean_cafe_sales.csv", index=False)


if __name__ == "__main__":
    cleaning()

