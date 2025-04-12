--User Management and Security
-- Create admin user with full privileges
CREATE USER 'bookstore_admin'@'localhost' IDENTIFIED BY 'StrongAdminPassword123!';
GRANT ALL PRIVILEGES ON bookstore_management.* TO 'bookstore_admin'@'localhost';

-- Create manager user with limited privileges
CREATE USER 'bookstore_manager'@'localhost' IDENTIFIED BY 'ManagerPass456!';
GRANT SELECT, INSERT, UPDATE, DELETE ON bookstore_management.* TO 'bookstore_manager'@'localhost';

-- Create customer service user with restricted privileges
CREATE USER 'customer_service'@'localhost' IDENTIFIED BY 'ServicePass789!';
GRANT SELECT ON bookstore_management.* TO 'customer_service'@'localhost';
GRANT INSERT, UPDATE ON bookstore_management.cust_order TO 'customer_service'@'localhost';
GRANT INSERT, UPDATE ON bookstore_management.order_history TO 'customer_service'@'localhost';
GRANT INSERT, UPDATE ON bookstore_management.customer TO 'customer_service'@'localhost';

-- Create read-only reporting user
CREATE USER 'reporting_user'@'localhost' IDENTIFIED BY 'ReportingPass321!';
GRANT SELECT ON bookstore_management.* TO 'reporting_user'@'localhost';

-- Apply the changes
FLUSH PRIVILEGES;


--