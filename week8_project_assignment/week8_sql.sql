-- Inventory Tracking System Database (PostgreSQL)
-- Creates tables for managing products, categories, and suppliers with proper constraints and relationships

-- Drop tables if they exist to avoid conflicts (in reverse order of dependencies)
DROP TABLE IF EXISTS ProductSuppliers CASCADE;
DROP TABLE IF EXISTS Products CASCADE;
DROP TABLE IF EXISTS Suppliers CASCADE;
DROP TABLE IF EXISTS Categories CASCADE;

-- Create Categories table
CREATE TABLE Categories (
    CategoryID SERIAL,
    CategoryName VARCHAR(100) NOT NULL,
    Description TEXT,
    PRIMARY KEY (CategoryID),
    UNIQUE (CategoryName)
);

-- Create Suppliers table
CREATE TABLE Suppliers (
    SupplierID SERIAL,
    SupplierName VARCHAR(100) NOT NULL,
    ContactEmail VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    PRIMARY KEY (SupplierID),
    UNIQUE (ContactEmail)
);

-- Create Products table
CREATE TABLE Products (
    ProductID SERIAL,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL,
    PRIMARY KEY (ProductID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE CASCADE,
    CONSTRAINT chk_price CHECK (Price >= 0),
    CONSTRAINT chk_stock CHECK (StockQuantity >= 0)
);

-- Create ProductSuppliers table (for M-M relationship between Products and Suppliers)
CREATE TABLE ProductSuppliers (
    ProductID INT,
    SupplierID INT,
    SupplyPrice DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ProductID, SupplierID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID) ON DELETE CASCADE,
    CONSTRAINT chk_supply_price CHECK (SupplyPrice >= 0)
);

-- Insert sample data into Categories
INSERT INTO Categories (CategoryName, Description) VALUES
('Electronics', 'Devices and gadgets'),
('Clothing', 'Apparel and accessories'),
('Books', 'Printed and digital books');

-- Insert sample data into Suppliers
INSERT INTO Suppliers (SupplierName, ContactEmail, Phone) VALUES
('TechCorp', 'contact@techcorp.com', '555-0101'),
('FashionHub', 'info@fashionhub.com', '555-0102'),
('BookWorld', 'sales@bookworld.com', '555-0103');

-- Insert sample data into Products
INSERT INTO Products (ProductName, CategoryID, Price, StockQuantity) VALUES
('Smartphone', 1, 599.99, 50),
('Laptop', 1, 999.99, 30),
('T-Shirt', 2, 19.99, 100),
('Novel', 3, 14.99, 200);

-- Insert sample data into ProductSuppliers
INSERT INTO ProductSuppliers (ProductID, SupplierID, SupplyPrice) VALUES
(1, 1, 550.00),
(2, 1, 900.00),
(3, 2, 15.00),
(4, 3, 10.00),
(1, 3, 560.00); -- Smartphone also supplied by BookWorld

