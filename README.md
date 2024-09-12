# JavaBank-Databases
# JavaBank Database

## Overview

The JavaBank Database is a PostgreSQL implementation for managing bank operations and customer data. It supports functionalities for handling customers, accounts, transactions, and purchases. The database schema is designed to meet the requirements for a typical banking system, including customer management, account management, and transaction tracking.

## Features

- **Customer Management:** Store and manage customer information, including personal details and addresses.
- **Account Management:** Handle multiple account types (checking, savings, pension) for each customer.
- **Transaction Management:** Record and track various types of transactions including deposits, withdrawals, transfers, and purchases.
- **Recipient Management:** Maintain a list of common recipients for transactions.
- **Purchase Tracking:** Log details of purchases made at various establishments.

## Tools 

- PostgreSQL - Relational Database Management System (RDBMS)

## Database Schema

### Tables

- **Customers:** Stores customer information.
- **Customer Addresses:** Manages multiple addresses for customers.
- **Accounts:** Details accounts associated with customers.
- **Establishments:** Information about businesses where purchases are made.
- **Purchases:** Records purchases made at establishments.
- **Recipients:** Manages common recipients for transactions.
- **Transactions:** Logs all transactions including deposits, withdrawals, and transfers.

## Getting Started

### Prerequisites

- PostgreSQL 12 or higher

### Installation

1. **Clone the Repository:**

    ```bash
    git clone https://github.com/yourusername/javabank-database.git
    cd javabank-database
    ```

2. **Setup the Database:**

    - Create a new database in PostgreSQL.

    ```sql
    CREATE DATABASE javabank;
    ```

3. **Run SQL Scripts:**

    - Create tables and schema:

    ```bash
    psql -d javabank -f javabank_tables.sql
    ```

    - Populate tables with dummy data:

    ```bash
    psql -d javabank -f javabank_seeds.sql
    ```

4. **Run Queries:**

    - Execute queries to test the database and retrieve information:

    ```bash
    psql -d javabank -f javabank_queries.sql
    ```

## SQL Files

- **`javabank_tables.sql`**: Contains SQL statements to create the database schema (tables, constraints, etc.).
- **`javabank_seeds.sql`**: Populates the database with dummy data for testing.
- **`javabank_queries.sql`**: Includes SQL queries to perform common bank activities and retrieve specific information.

## Example Queries

- **Find Customer's Phone Number:**

    ```sql
    SELECT phone_number FROM customers WHERE last_name = 'Lopes';
    ```

- **Update Customer Address:**

    ```sql
    UPDATE customers_addresses SET customer_address = 'Rua do Rato, 103, Lisboa, 1000-004'
    WHERE customer_id = (SELECT customer_id FROM customers WHERE last_name = 'Oliveira' AND first_name = 'João');
    ```

- **Delete Customer and Accounts:**

    ```sql
    DELETE FROM accounts WHERE customer_id = (SELECT customer_id FROM customers WHERE last_name = 'Oliveira' AND first_name = 'Miguel');
    DELETE FROM customers WHERE last_name = 'Oliveira' AND first_name = 'Miguel';
    ```

## Contributing

If you would like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Create a new Pull Request.

## Contact

For any questions or feedback, please reach out to catarinampestana at ua.pt.
