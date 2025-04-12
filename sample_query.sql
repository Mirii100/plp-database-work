-- 1. Get all books with their authors
SELECT b.title, GROUP_CONCAT(a.author_name SEPARATOR ', ') AS authors
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
GROUP BY b.title;

-- 2. Get customer orders with details
SELECT 
    c.first_name, c.last_name, 
    o.order_id, o.order_date, 
    os.status_value, 
    COUNT(ol.line_id) AS item_count, 
    o.order_total
FROM cust_order o
JOIN customer c ON o.customer_id = c.customer_id
JOIN order_history oh ON o.order_id = oh.order_id
JOIN order_status os ON oh.status_id = os.status_id
JOIN order_line ol ON o.order_id = ol.order_id
GROUP BY o.order_id
ORDER BY o.order_date DESC;

-- 3. Get inventory report
SELECT 
    b.title, 
    b.stock_quantity, 
    p.publisher_name, 
    bl.language_name,
    b.price
FROM book b
JOIN publisher p ON b.publisher_id = p.publisher_id
JOIN book_language bl ON b.language_id = bl.language_id
ORDER BY b.stock_quantity ASC;

-- 4. Get sales report by author
SELECT 
    a.author_name, 
    SUM(ol.quantity) AS total_books_sold, 
    SUM(ol.quantity * ol.price) AS total_revenue
FROM author a
JOIN book_author ba ON a.author_id = ba.author_id
JOIN order_line ol ON ba.book_id = ol.book_id
GROUP BY a.author_name
ORDER BY total_revenue DESC;

-- 5. Update stock after order
UPDATE book b
JOIN order_line ol ON b.book_id = ol.book_id
JOIN cust_order o ON ol.order_id = o.order_id
SET b.stock_quantity = b.stock_quantity - ol.quantity
WHERE o.order_id = 1;