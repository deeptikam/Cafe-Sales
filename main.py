import sqlite3
import clean_cafe_sales
import data_insert

#function so that I am able to run the sql file 
def schema():
    connection = sqlite3.connect("cafe_sales.db")
    cursor = connection.cursor()
    with open("schema.sql", "r") as f:
        sql_script = f.read()
    cursor.executescript(sql_script)
    connection.commit()
    connection.close()

#calling the functions in order to make my database
clean_cafe_sales.cleaning()
schema()
data_insert.data_insert()
