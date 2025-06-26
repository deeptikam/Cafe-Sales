--here I am creating the tables for my database, I am referencing
--both my ERD and Data Dictionary

CREATE TABLE IF NOT EXISTS Items (
    item_id INTEGER PRIMARY KEY,
    item_name TEXT,
    price_per_unit REAL
);

CREATE TABLE IF NOT EXISTS Payment (
    payment_id INTEGER PRIMARY KEY,
    payment_method TEXT
);

CREATE TABLE IF NOT EXISTS Location (
    location_id INTEGER PRIMARY KEY,
    location_type TEXT
);

CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id TEXT PRIMARY KEY,
    item_id INTEGER,
    payment_id INTEGER,
    location_id INTEGER,
    transaction_date TEXT,
    total_spent REAL,
    quantity INTEGER,
    FOREIGN KEY (item_id) REFERENCES Items(item_id),
    FOREIGN KEY (payment_id) REFERENCES Payment(payment_id),
    FOREIGN KEY (location_id) REFERENCES Location(location_id)
);