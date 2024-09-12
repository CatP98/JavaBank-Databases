INSERT INTO customers (first_name, last_name, city, country, email_address, phone_number)
VALUES
('João', 'Townsend', 'Lisbon', 'Portugal', 'joao.townsend@example.com', '1234567890'),
('Sara', 'Lopes', 'Porto', 'Portugal', 'sara.lopes@example.com', '0987654321'),
('João', 'Oliveira', 'Guimarães', 'Portugal', 'joao_oliveira_da_serra@outlook.com', '915472876'),
('Miguel', 'Oliveira', 'Guimarães', 'Portugal', 'miguel_oliveira_da_serra@outlook.com', '917652876');

INSERT INTO customer_addresses (customer_id, customer_address, city, zip, country)
VALUES
(1, '123 Elm St', 'Lisbon', '12345', 'Portugal'),   -- João Townsend
(2, '456 Oak St', 'Porto', '67890', 'Portugal'),    -- Sara Lopes
(3, 'R. de Pombal', 'Guimarães', '2354-987', 'Portugal'),  -- João Oliveira
(4, 'R. do Rato', 'Guimarães', '2354-987', 'Portugal');  -- Miguel Oliveira

INSERT INTO accounts (customer_id, account_type, account_balance)
VALUES
(1, 'checking', 1500.00),
(1, 'savings', 3000.00),
(2, 'checking', 2000.00),
(2, 'pension', 5000.00),
(1, 'pension', 5000.00),
(4,'checking', 1500.00),
(4,'pension', 100.00);

INSERT INTO establishments (name_establishment, location_establishment)
VALUES
('Pingo Doce', 'Lisbon, Portugal'),
('Continente', 'Porto, Portugal'),
('Starbucks', 'London, UK');
('Worten', 'Lisbon', 'Portugal')


INSERT INTO recipients (customer_id, account_id, recipient_first_name, recipient_last_name, recipient_account_number, regular_payment_date)
VALUES
(1, NULL, 'Sara', 'Lopes', '123456789', '07/15'),
(2, NULL, 'João', 'Townsend', '987654321', '07/16')
(3, 4, 'Miguel', 'Oliveira');
(3, 1, 'João', 'Townsend', '987654321', '07/16')


INSERT INTO purchases (establishment_id, transaction_id, amount)
VALUES
(1, NULL, 50.00),
(2, NULL, 75.00),
(1, 1, 50.00), -- Linked to transaction_id = 1
(2, 4, 75.00); -- Linked to transaction_id = 4


INSERT INTO transactions (customer_id, account_id, transaction_type, amount, balance_after_transaction, recipient_id, purchase_id, transaction_time, transaction_date)
VALUES
(1, 1, 'deposit', 500.00, 2500.00, NULL, NULL, '2023-07-15 09:30:00', '2023-07-15'),
(1, 1, 'withdrawal', 1000.00, 1500.00, NULL, NULL, '2023-07-15 12:45:00', '2023-07-15'),
(1, NULL, 'purchase', 50.00, 1450.00, NULL, 1, '2023-07-15 15:00:00', '2023-07-15'),
(2, 3, 'transfer', 200.00, 1500.00, 1, NULL, '2023-07-15 10:00:00', '2023-07-15'),
(2, NULL, 'purchase', 75.00, 1450.00, NULL, 2, '2023-07-15 14:30:00', '2023-07-15'),
(3, 4, 'deposit', 1000.00, 1200.00, NULL, NULL, '2023-07-16 11:00:00', '2023-07-16'),
(3, NULL, 'purchase', 120.00, 1080.00, NULL, 3, '2023-07-16 13:00:00', '2023-07-16'),
(3, 1, 'transfer', 100.00, 1000.00, 2, NULL, '2023-07-16 15:30:00', '2023-07-16'),
(3, NULL, 'purchase', 35.00, 965.00, NULL, 4, '2023-07-16 17:45:00', '2023-07-16');




