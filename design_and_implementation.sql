-- Database Creation
CREATE DATABASE bookstore_management;
USE bookstore_management;


--Table Schema Design and Creation

--Book Language Table
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_code VARCHAR(8) NOT NULL,
    language_name VARCHAR(50) NOT NULL,
    CONSTRAINT uk_language_code UNIQUE (language_code)
);

--Publisher Table
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    publisher_name VARCHAR(100) NOT NULL,
    CONSTRAINT uk_publisher_name UNIQUE (publisher_name)
);

--Author Table
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    biography TEXT
);

--Book Table

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_date DATE,
    num_pages INT,
    language_id INT NOT NULL,
    publisher_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    description TEXT,
    CONSTRAINT fk_book_language FOREIGN KEY (language_id) 
        REFERENCES book_language(language_id),
    CONSTRAINT fk_book_publisher FOREIGN KEY (publisher_id) 
        REFERENCES publisher(publisher_id),
    CONSTRAINT chk_price CHECK (price > 0),
    CONSTRAINT chk_pages CHECK (num_pages > 0)
);

--Book-Author Relationship Table
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_date DATE,
    num_pages INT,
    language_id INT NOT NULL,
    publisher_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    description TEXT,
    CONSTRAINT fk_book_language FOREIGN KEY (language_id) 
        REFERENCES book_language(language_id),
    CONSTRAINT fk_book_publisher FOREIGN KEY (publisher_id) 
        REFERENCES publisher(publisher_id),
    CONSTRAINT chk_price CHECK (price > 0),
    CONSTRAINT chk_pages CHECK (num_pages > 0)
);


--Country Table
CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(50) NOT NULL,
    CONSTRAINT uk_country_name UNIQUE (country_name)
);
--Address Table
CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street_number VARCHAR(10) NOT NULL,
    street_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state_province VARCHAR(50),
    postal_code VARCHAR(20) NOT NULL,
    country_id INT NOT NULL,
    CONSTRAINT fk_address_country FOREIGN KEY (country_id) 
        REFERENCES country(country_id)
);

--Address Status Table
CREATE TABLE address_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_value VARCHAR(20) NOT NULL,
    CONSTRAINT uk_status_value UNIQUE (status_value)
);

--customer 
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    password_hash VARCHAR(255) NOT NULL,
    CONSTRAINT chk_email CHECK (email LIKE '%@%.%')
);

--Customer Address Table

CREATE TABLE customer_address (
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    status_id INT NOT NULL,
    PRIMARY KEY (customer_id, address_id),
    CONSTRAINT fk_ca_customer FOREIGN KEY (customer_id) 
        REFERENCES customer(customer_id) ON DELETE CASCADE,
    CONSTRAINT fk_ca_address FOREIGN KEY (address_id) 
        REFERENCES address(address_id) ON DELETE CASCADE,
    CONSTRAINT fk_ca_status FOREIGN KEY (status_id) 
        REFERENCES address_status(status_id)
);

--Shipping Method Table
CREATE TABLE shipping_method (
    method_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(50) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    CONSTRAINT uk_method_name UNIQUE (method_name),
    CONSTRAINT chk_shipping_cost CHECK (cost >= 0)
);

--Order Status Table

CREATE TABLE order_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_value VARCHAR(20) NOT NULL,
    CONSTRAINT uk_order_status_value UNIQUE (status_value)
);

-- Customer Order Table
CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    customer_id INT NOT NULL,
    shipping_address_id INT NOT NULL,
    shipping_method_id INT NOT NULL,
    order_total DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) 
        REFERENCES customer(customer_id),
    CONSTRAINT fk_order_address FOREIGN KEY (shipping_address_id) 
        REFERENCES address(address_id),
    CONSTRAINT fk_order_method FOREIGN KEY (shipping_method_id) 
        REFERENCES shipping_method(method_id),
    CONSTRAINT chk_order_total CHECK (order_total >= 0)
);

--Order Line Table
CREATE TABLE order_line (
    line_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_ol_order FOREIGN KEY (order_id) 
        REFERENCES cust_order(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_ol_book FOREIGN KEY (book_id) 
        REFERENCES book(book_id),
    CONSTRAINT chk_quantity CHECK (quantity > 0),
    CONSTRAINT chk_line_price CHECK (price >= 0)
);


-- order  history 
CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    status_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    CONSTRAINT fk_oh_order FOREIGN KEY (order_id) 
        REFERENCES cust_order(order_id) ON DELETE CASCADE,
    CONSTRAINT fk_oh_status FOREIGN KEY (status_id) 
        REFERENCES order_status(status_id)
);

