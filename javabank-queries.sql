
-- 1st Query: What is the phone number of the customer with the last name Lopes?
SELECT DISTINCT phone_number
FROM customers
WHERE last_name LIKE 'Lopes'; 


-- 2nd Query: João Oliveira has moved to "Rua do Rato, 103, Lisboa, 1000-004" and has requested that we change his current address in the database.
SELECT c.customer_id, c.first_name, c.last_name, ad.city, ca.zip, ad.country
FROM customers AS c
JOIN customer_addresses AS a 
    ON c.customer_id = ad.customer_id
WHERE c.first_name = 'João' AND c.last_name = 'Oliveira';

UPDATE customers
SET city = 'Lisboa',
    country = 'Portugal',
WHERE first_name = 'João' AND last_name = 'Oliveira';

UPDATE customer_addresses
SET customer_address = 'Rua do Rato, 103',
    city = 'Lisboa',
    zip = '1000-004',
    country = 'Portugal'
WHERE customer_id = (SELECT customer_id FROM customers WHERE first_name = 'João' AND last_name = 'Oliveira');


-- 3rd Query: Miguel Oliveira is no longer a customer. He had two accounts, but has closed all of them. Update the database accordingly.
SELECT *
FROM customers
WHERE first_name LIKE 'Miguel' AND last_name LIKE 'Oliveira';

DELETE FROM customers
WHERE first_name LIKE "Miguel" AND last_name LIKE "Oliveira";


-- 4th Query: How many frequent recipients does João Oliveira have on his list?
SELECT COUNT(recipient_id) AS total_recipients
FROM recipients as r
JOIN customers as c
    ON r.customer_id = c.customer_id
WHERE first_name LIKE 'João' AND  last_name LIKE 'Oliveira'
GROUP BY total_recipients;


-- 5th Query: How much money does João Townsend have in his various accounts (checking and savings)?
SELECT SUM(account_balance) AS total_balance_from_all_accounts
FROM customers AS c
JOIN accounts AS a
    ON c.customer_id = a.customer_id
WHERE first_name = 'João' AND last_name = 'Townsend' AND account_type= 'checking' OR account_type='savings';


-- 6th Query: Show all the transfer transactions from João Oliveira to João Townsend (his frequent recipient).
SELECT recipient_first_name, recipient_last_name, recipient_account_number, transaction_type, amount, transaction_time, transaction_date
FROM transactions AS t
JOIN customers AS c1 ON t.customer_id = c1.customer_id
JOIN recipients AS r ON r.customer_id = c1.customer_id
JOIN customers AS c2 ON t.customer_id = c2.customer_id;;
WHERE c1.first_name LIKE 'João' AND c1.last_name LIKE 'Oliveira' 
    AND recipient_first_name LIKE 'João' AND recipient_last_name LIKE 'Townsend'
    AND transaction_type = 'transfer';


-- 7th query: Show all the purchases made at Pingo Doce by Sara Lopes.
--To see all the individual purchases at Pingo Doce
SELECT e.name_establishment, p.amount
FROM customers AS c 
JOIN transactions AS t
    ON c.customer_id = t.customer_id
JOIN purchases AS p
    ON p.purchase_id = t.purchase_id
Join establishments AS e
    ON p.establishment_id = e.establishment_id
WHERE c.first_name = 'Sara' AND c.last_name = 'Lopes' 
AND t.transaction_type = 'purchase' AND e.name_establishment LIKE 'pingo doce';

--To see the otal amount spent at Pingo Doce
SELECT SUM(p.amount) AS total_purchases_spent
FROM customers AS c 
JOIN transactions AS t
    ON c.customer_id = t.customer_id
JOIN purchases AS p
    ON p.purchase_id = t.purchase_id
JOIN establishments AS e
    ON p.establishment_id = e.establishment_id
WHERE c.first_name = 'Sara' AND c.last_name = 'Lopes' 
AND t.transaction_type = 'purchase' AND e.name_establishment LIKE 'Pingo Doce';


-- 8th Query: Which customers made purchases at Worten and how much did they spend on average there?

SELECT  c.customer_id, c.first_name, c.last_name, e.name_establishment, AVG(p.amount) AS average_amount_spent
FROM customers AS c
JOIN transactions AS t 
    ON c.customer_id = t.customer_id
JOIN purchases AS p 
    ON p.purchase_id = t.purchase_id
JOIN establishments AS e 
    ON p.establishment_id = e.establishment_id
WHERE e.name_establishment = 'Worten' 
    AND t.transaction_type = 'purchase'
GROUP BY c.customer_id, c.first_name, c.last_name, e.name_establishment;


-- 9th Query: What is the total balance of each account type (checking and savings) for each customer, ordered from the biggest to lowest balance?
SELECT c.customer_id, a.account_type, SUM(a.account_balance)  AS total_balance
FROM customers AS c
JOIN accounts AS a
    ON c.customer_id = a.customer_id
WHERE account_type IN ('checking', 'savings') 
GROUP BY c.customer_id, a.account_type
ORDER BY total_balance DESC;
