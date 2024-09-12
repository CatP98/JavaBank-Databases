-- Create Customers table, where each customer has a unique customer_id and stores personal information 
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    city VARCHAR(30) NOT NULL,
    country VARCHAR(30) NOT NULL,
    email_address VARCHAR(200),
    phone_number VARCHAR(20)
);

CREATE TABLE customers_addresses (
    address_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    customer_address VARCHAR(300) NOT NULL,
    city VARCHAR(30) NOT NULL,
    zip VARCHAR(25) NOT NULL,
    country VARCHAR(30) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


--Create table for the customer's accounts info, each account has a unique account_id and is linked to a customer via customer_id
CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(10) NOT NULL CHECK (account_type IN ('checking', 'savings', 'pension')),
    account_balance DECIMAL(10,2) NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

--Each establishment has a unique establishment_id and stores information about it. A establishment is
-- independent from any purchase or customer, so it contains no FK.
CREATE TABLE establishments (
    establishment_id SERIAL PRIMARY KEY,
    name_establishment VARCHAR(100) NOT NULL,
    location_establishment VARCHAR(100) -- just for city, country  
);

-- Each purchase has a unique purchase_id and is linked to an establishment via establishment_id.
-- It stores details of the purchase 
CREATE TABLE purchases (
    purchase_id SERIAL PRIMARY KEY,
    establishment_id INT,
    transaction_id INT,
    amount DECIMAL(10,2) CHECK (amount >= 0) NOT NULL,
    FOREIGN KEY(establishment_id) REFERENCES establishments(establishment_id) ON DELETE CASCADE
);

-- Create table for the Recipients
-- Each recipient has a unique recipient_id and is linked to a customer via customer_id. 
-- It stores recipient's personal information 
CREATE TABLE recipients (
    recipient_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    account_id INT, --nullable because not all recipients belong to the bank system, so may not have an account id
    recipient_first_name VARCHAR(50) DEFAULT 'Unknown', -- DEFAULT to 'Unknown' 
    recipient_last_name VARCHAR(100) DEFAULT 'Unknown',
    recipient_account_number VARCHAR(100) NOT NULL, -- char instead of INT, because the number may contain characters
    regular_payment_date VARCHAR(5) CHECK (regular_payment_date IS NULL OR regular_payment_date ~ '^(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[0-1])$'), --check because we want MM/DD format
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);


-- Each transaction has a unique transaction_id and is linked to a customer via customer_id. 
-- It stores details of the transaction 
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INT,
    account_id INT,
    transaction_type VARCHAR(15) NOT NULL CHECK (transaction_type IN ('withdrawal', 'deposit', 'transfer', 'purchase', 'loan payment')), --can be withdrawl, deposit, transfer,
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    balance_after_transaction DECIMAL(10,2) NOT NULL,
    recipient_id INT, -- nullable because not all transactions are transfers to recipients
    purchase_id INT, -- nullable beacuse not all transactions are purchases, so the field may be a null 
    transaction_time TIMESTAMP NOT NULL,
    transaction_date DATE NOT NULL,
    FOREIGN KEY(recipient_id) REFERENCES recipients(recipient_id) ON DELETE CASCADE,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY(account_id) REFERENCES accounts(account_id) ON DELETE CASCADE,
    FOREIGN KEY(purchase_id) REFERENCES purchases(purchase_id) ON DELETE SET NULL
);


