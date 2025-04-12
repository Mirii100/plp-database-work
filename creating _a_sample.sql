-- Insert sample data into book_language
INSERT INTO book_language (language_code, language_name) VALUES 
('en', 'English'),
('es', 'Spanish'),
('fr', 'French'),
('de', 'German'),
('ja', 'Japanese');

-- Insert sample publishers
INSERT INTO publisher (publisher_name) VALUES 
('Penguin Random House'),
('HarperCollins'),
('Simon & Schuster'),
('Macmillan'),
('Hachette');

-- Insert sample authors
INSERT INTO author (author_name, birth_date) VALUES 
('J.K. Rowling', '1965-07-31'),
('George R.R. Martin', '1948-09-20'),
('Stephen King', '1947-09-21'),
('Agatha Christie', '1890-09-15'),
('J.R.R. Tolkien', '1892-01-03');

-- Insert sample books
INSERT INTO book (title, isbn, publication_date, num_pages, language_id, publisher_id, price, stock_quantity) VALUES 
('Harry Potter and the Philosopher''s Stone', '9780747532743', '1997-06-26', 223, 1, 1, 12.99, 50),
('A Game of Thrones', '9780553103540', '1996-08-01', 694, 1, 2, 15.99, 30),
('The Shining', '9780385121675', '1977-01-28', 447, 1, 3, 9.99, 25),
('Murder on the Orient Express', '9780007119318', '1934-01-01', 256, 1, 4, 8.99, 40),
('The Hobbit', '9780547928227', '1937-09-21', 310, 1, 5, 11.99, 35);

-- Link books to authors
INSERT INTO book_author (book_id, author_id) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Insert sample countries
INSERT INTO country (country_name) VALUES 
('United States'),
('United Kingdom'),
('Canada'),
('Australia'),
('Germany');

-- Insert address statuses
INSERT INTO address_status (status_value) VALUES 
('Current'),
('Previous'),
('Billing'),
('Shipping');

-- Insert sample addresses
INSERT INTO address (street_number, street_name, city, state_province, postal_code, country_id) VALUES 
('123', 'Main St', 'New York', 'NY', '10001', 1),
('456', 'Oak Ave', 'London', NULL, 'SW1A 1AA', 2),
('789', 'Maple Rd', 'Toronto', 'ON', 'M5V 2H1', 3),
('10', 'Elm St', 'Sydney', 'NSW', '2000', 4),
('55', 'Pine Blvd', 'Berlin', NULL, '10115', 5);

-- Insert sample customers
INSERT INTO customer (first_name, last_name, email, phone, password_hash) VALUES 
('John', 'Doe', 'john.doe@example.com', '555-123-4567', SHA2('CustomerPass1!', 256)),
('Jane', 'Smith', 'jane.smith@example.com', '555-987-6543', SHA2('CustomerPass2!', 256)),
('Robert', 'Johnson', 'robert.j@example.com', '555-456-7890', SHA2('CustomerPass3!', 256));

-- Link customers to addresses
INSERT INTO customer_address (customer_id, address_id, status_id) VALUES 
(1, 1, 1),
(1, 2, 3),
(2, 3, 1),
(3, 4, 1),
(3, 5, 2);

-- Insert shipping methods
INSERT INTO shipping_method (method_name, cost) VALUES 
('Standard Shipping', 4.99),
('Express Shipping', 9.99),
('Overnight Shipping', 19.99);

-- Insert order statuses
INSERT INTO order_status (status_value) VALUES 
('Pending'),
('Processing'),
('Shipped'),
('Delivered'),
('Cancelled');

-- Insert sample orders
INSERT INTO cust_order (customer_id, shipping_address_id, shipping_method_id, order_total) VALUES 
(1, 1, 1, 25.97),
(2, 3, 2, 35.97),
(3, 4, 3, 31.97);

-- Insert order lines
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES 
(1, 1, 2, 12.99),
(2, 2, 1, 15.99),
(2, 3, 2, 9.99),
(3, 4, 1, 8.99),
(3, 5, 2, 11.99);

-- Insert order history
INSERT INTO order_history (order_id, status_id, notes) VALUES 
(1, 1, 'Order received'),
(1, 2, 'Payment processed'),
(2, 1, 'Order received'),
(3, 1, 'Order received'),
(3, 2, 'Payment processed'),
(3, 3, 'Shipped via overnight');