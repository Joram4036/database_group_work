-- creating the database
CREATE DATABASE BookStoreDB;
USE BookStoreDB;

-- table author
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    bio TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- book_language table
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(50) NOT NULL UNIQUE
);

-- publisher table
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(255),
    contact_info VARCHAR(100)
);

-- book table
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_year YEAR,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    language_id INT,
    publisher_id INT,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- book_author table
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- country table
CREATE TABLE country (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL UNIQUE
);

-- address_status table
CREATE TABLE address_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

-- address table
CREATE TABLE address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    street_address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state_province VARCHAR(100),
    postal_code VARCHAR(20) NOT NULL,
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- customer table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- customer_address table
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- shipping_method table
CREATE TABLE shipping_method (
    shipping_id INT PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(50) NOT NULL UNIQUE,
    cost DECIMAL(10, 2) NOT NULL
);

-- order_status table
CREATE TABLE order_status (
    status_id INT PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

-- cust_order table
CREATE TABLE cust_order (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    shipping_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_id) REFERENCES shipping_method(shipping_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- order_line table
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- order_history table
CREATE TABLE order_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    status_id INT NOT NULL,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- Insert sample authors
INSERT INTO author (first_name, last_name, bio)
VALUES ('J.K.', 'Rowling', 'British author known for Harry Potter series');

-- Insert sample languages
INSERT INTO book_language (language_name)
VALUES ('English'), ('Spanish'), ('French');

-- Insert sample publishers
INSERT INTO publisher (name, address, contact_info)
VALUES ('Penguin Random House', 'New York, USA', 'contact@penguin.com');

-- Insert sample books
INSERT INTO Author (Author_ID, Author_Name, Nationality) VALUES
(1, 'Robert Kiyosaki', 'American'),
(2, 'J.K. Rowling', 'British'),
(3, 'George Orwell', 'British'),
(4, 'Malcolm Gladwell', 'Canadian'),
(5, 'Agatha Christie', 'British');

 -- Insert sample languages
INSERT INTO Book_Language (Language_ID, Language_Name) VALUES
(1, 'English'),
(2, 'Spanish'),
(3, 'French'),
(4, 'German'),
(5, 'Italian');

-- Insert sample publishers
INSERT INTO Publisher (Publisher_ID, Publisher_Name, Country) VALUES
(1, 'HarperCollins', 'USA'),
(2, 'Bloomsbury', 'UK'),
(3, 'Penguin Random House', 'USA'),
(4, 'Macmillan', 'USA'),
(5, 'Hachette', 'France');

-- Insert sample books
INSERT INTO Book (Book_ID, Title, Author_ID, Publisher_ID, Language_ID) VALUES
(1, 'Rich Dad Poor Dad', 1, 1, 1),
(2, 'Harry Potter and the Sorcerer''s Stone', 2, 2, 1),
(3, '1984', 3, 3, 1),
(4, 'Outliers', 4, 4, 1),
(5, 'Murder on the Orient Express', 5, 5, 1);

--  Insert sample book authors
INSERT INTO Book_Author (Book_Author_ID, Book_ID, Author_ID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

--  Insert sample country
INSERT INTO Country (Country_ID, Country_Name) VALUES
(1, 'USA'),
(2, 'UK'),
(3, 'Spain'),
(4, 'France'),
(5, 'Italy');

--  Insert sample adress_Statis_ID
INSERT INTO Address_Statis (Address_Statis_ID, Status) VALUES
(1, 'Residential'),
(2, 'Business'),
(3, 'Shipping'),
(4, 'Billing'),
(5, 'Temporary');

--  Insert sample address
INSERT INTO Address (Address_ID, Customer_ID, Address_Statis_ID, Street_Address, City, Country_ID, Postal_Code) VALUES
(1, 1, 1, '123 Main St.', 'New York', 1, '10001'),
(2, 2, 3, '456 Elm St.', 'London', 2, '12345'),
(3, 3, 1, '789 Pine St.', 'Paris', 4, '98765'),
(4, 4, 2, '101 Maple St.', 'Rome', 5, '54321'),
(5, 5, 4, '202 Oak St.', 'Berlin', 3, '67890');

--  Insert sample customer
INSERT INTO Customer (Customer_ID, First_Name, Last_Name, Email, Phone) VALUES
(1, 'John', 'Doe', 'johndoe@email.com', '555-1234'),
(2, 'Jane', 'Smith', 'janesmith@email.com', '555-5678'),
(3, 'Alice', 'Johnson', 'alicejohnson@email.com', '555-8765'),
(4, 'Bob', 'Brown', 'bobbrown@email.com', '555-4321'),
(5, 'Eve', 'Davis', 'evedavis@email.com', '555-6789');

--  Insert sample customer_address
INSERT INTO Customer_Address (Customer_Address_ID, Customer_ID, Address_ID) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

--  Insert sample shipping_method
INSERT INTO Shipping_Method (Shipping_Method_ID, Shipping_Method_Name, Cost, Estimated_Delivery_Time) VALUES
(1, 'Standard Shipping', 5.99, '5-7 days'),
(2, 'Expedited Shipping', 12.99, '2-3 days'),
(3, 'Next Day Delivery', 19.99, '1 day'),
(4, 'Free Shipping', 0.00, '7-10 days'),
(5, 'International Shipping', 15.99, '7-14 days');

--  Insert sample order status
INSERT INTO Order_Status (Status_ID, Status_Name) VALUES
(1, 'Pending'),
(2, 'Shipped'),
(3, 'Delivered'),
(4, 'Canceled'),
(5, 'Returned');

--  Insert sample cust_order
INSERT INTO Cust_Order (Order_ID, Customer_ID, Order_Date, Shipping_Method_ID, Order_Status_ID) VALUES
(1, 1, '2025-04-10', 1, 2),
(2, 2, '2025-04-11', 2, 3),
(3, 3, '2025-04-12', 3, 1),
(4, 4, '2025-04-13', 4, 4),
(5, 5, '2025-04-14', 5, 5);

--  Insert sample order_line
INSERT INTO Orderline (Orderline_ID, Order_ID, Book_ID, Quantity, Price) VALUES
(1, 1, 1, 1, 15.99),
(2, 2, 2, 2, 25.99),
(3, 3, 3, 1, 12.99),
(4, 4, 4, 3, 18.50),
(5, 5, 5, 1, 9.99);

--  Insert sample order_history
INSERT INTO Order_History (History_ID, Order_ID, Status_ID, Date, Remarks) VALUES
(1, 1, 2, '2025-04-10', 'Order shipped'),
(2, 2, 3, '2025-04-12', 'Order delivered'),
(3, 3, 1, '2025-04-13', 'Order pending'),
(4, 4, 4, '2025-04-14', 'Order canceled'),
(5, 5, 5, '2025-04-15', 'Order returned');

-- Create an admin user
CREATE USER 'admin1'@'localhost' IDENTIFIED BY 'admin1';
GRANT ALL PRIVILEGES ON BookStoreDB.* TO 'admin1'@'localhost';

-- Create a read-only user
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'user1';
GRANT SELECT ON BookStoreDB.* TO 'user1'@'localhost';

FLUSH PRIVILEGES;


-- Example query: List all books with their authors
SELECT b.title, a.first_name, a.last_name
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id;

-- Example query: Total sales by customer
SELECT c.first_name, c.last_name, SUM(ol.quantity * ol.price_at_purchase) AS total_spent
FROM customer c
JOIN cust_order co ON c.customer_id = co.customer_id
JOIN order_line ol ON co.order_id = ol.order_id
GROUP BY c.customer_id;

SELECT 
    bl.language_name,
    p.name as publisher_name,
    COUNT(DISTINCT b.book_id) as number_of_books,
    SUM(ol.quantity) as total_copies_sold,
    SUM(ol.quantity * ol.price_at_purchase) as total_revenue
FROM book b
JOIN book_language bl ON b.language_id = bl.language_id
JOIN publisher p ON b.publisher_id = p.publisher_id
LEFT JOIN order_line ol ON b.book_id = ol.book_id
GROUP BY bl.language_id, bl.language_name, p.publisher_id, p.name
ORDER BY total_revenue DESC;

-- Example complex query: Customer address analysis with status
SELECT 
    c.first_name,
    c.last_name,
    COUNT(ca.address_id) as total_addresses,
    GROUP_CONCAT(DISTINCT ast.status_name) as address_types,
    GROUP_CONCAT(DISTINCT cnt.country_name) as countries
FROM customer c
JOIN customer_address ca ON c.customer_id = ca.customer_id
JOIN address a ON ca.address_id = a.address_id
JOIN address_status ast ON ca.status_id = ast.status_id
JOIN country cnt ON a.country_id = cnt.country_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING total_addresses > 1;

-- Example complex query: Order fulfillment analysis
SELECT 
    YEAR(co.order_date) as order_year,
    MONTH(co.order_date) as order_month,
    COUNT(co.order_id) as total_orders,
    AVG(DATEDIFF(
        (SELECT MIN(update_time) 
         FROM order_history oh2 
         WHERE oh2.order_id = co.order_id 
         AND oh2.status_id = (SELECT status_id FROM order_status WHERE status_name = 'Delivered')),
        co.order_date
    )) as avg_delivery_days
FROM cust_order co
GROUP BY order_year, order_month
ORDER BY order_year, order_month;

-- Example query for author table: Get all authors with their book count
SELECT a.first_name, a.last_name, COUNT(ba.book_id) as number_of_books
FROM author a
LEFT JOIN book_author ba ON a.author_id = ba.author_id
GROUP BY a.author_id, a.first_name, a.last_name;

-- Example query for book_language table: Show number of books in each language
SELECT bl.language_name, COUNT(b.book_id) as books_count
FROM book_language bl
LEFT JOIN book b ON bl.language_id = b.language_id
GROUP BY bl.language_id, bl.language_name;

-- Example query for publisher table: List publishers and their published books count
SELECT p.name, p.contact_info, COUNT(b.book_id) as published_books
FROM publisher p
LEFT JOIN book b ON p.publisher_id = b.publisher_id
GROUP BY p.publisher_id, p.name, p.contact_info;

-- Example query for book table: Get books with price higher than average
SELECT b.title, b.isbn, b.price
FROM book b
WHERE b.price > (SELECT AVG(price) FROM book)
ORDER BY b.price DESC;

-- Example query for country table: Show number of customers per country
SELECT c.country_name, COUNT(DISTINCT ca.customer_id) as number_of_customers
FROM country c
LEFT JOIN address a ON c.country_id = a.country_id
LEFT JOIN customer_address ca ON a.address_id = ca.address_id
GROUP BY c.country_id, c.country_name;

-- Example query for address table: Find customers with multiple addresses
SELECT c.first_name, c.last_name, COUNT(ca.address_id) as number_of_addresses
FROM customer c
JOIN customer_address ca ON c.customer_id = ca.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(ca.address_id) > 1;

-- Example query for shipping_method table: Show most popular shipping methods
SELECT sm.method_name, COUNT(co.order_id) as times_used
FROM shipping_method sm
LEFT JOIN cust_order co ON sm.shipping_id = co.shipping_id
GROUP BY sm.shipping_id, sm.method_name
ORDER BY times_used DESC;

-- Example query for order_status table: Show order distribution by status
SELECT os.status_name, COUNT(co.order_id) as number_of_orders
FROM order_status os
LEFT JOIN cust_order co ON os.status_id = co.status_id
GROUP BY os.status_id, os.status_name;

-- Example query for cust_order table: Get orders with their total items and amount
SELECT co.order_id, 
       c.first_name, 
       c.last_name, 
       SUM(ol.quantity) as total_items,
       co.total_amount
FROM cust_order co
JOIN customer c ON co.customer_id = c.customer_id
JOIN order_line ol ON co.order_id = ol.order_id
GROUP BY co.order_id, c.first_name, c.last_name, co.total_amount;

-- Example query for order_line table: Find best-selling books
SELECT b.title, 
       SUM(ol.quantity) as total_sold,
       SUM(ol.quantity * ol.price_at_purchase) as total_revenue
FROM order_line ol
JOIN book b ON ol.book_id = b.book_id
GROUP BY b.book_id, b.title
ORDER BY total_sold DESC;

-- Example query for order_history table: Track order status changes
SELECT co.order_id, 
       c.first_name, 
       c.last_name,
       os.status_name,
       oh.update_time,
       oh.notes
FROM order_history oh
JOIN cust_order co ON oh.order_id = co.order_id
JOIN customer c ON co.customer_id = c.customer_id
JOIN order_status os ON oh.status_id = os.status_id
ORDER BY co.order_id, oh.update_time;

-- Example complex query: Customer purchase analysis
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT co.order_id) as total_orders,
    SUM(ol.quantity) as total_items_purchased,
    SUM(ol.quantity * ol.price_at_purchase) as total_spent,
    MAX(co.order_date) as last_order_date
FROM customer c
LEFT JOIN cust_order co ON c.customer_id = co.customer_id
LEFT JOIN order_line ol ON co.order_id = ol.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;

-- Example complex query: Book sales performance by language and publisher
SELECT 
    bl.language_name,
    p.name as publisher_name,
    COUNT(DISTINCT b.book_id) as number_of_books,
    SUM(ol.quantity) as total_copies_sold,
    SUM(ol.quantity * ol.price_at_purchase) as total_revenue
FROM book b
JOIN book_language bl ON b.language_id = bl.language_id
JOIN publisher p ON b.publisher_id = p.publisher_id
LEFT JOIN order_line ol ON b.book_id = ol.book_id
GROUP BY bl.language_id, bl.language_name, p.publisher_id, p.name
ORDER BY total_revenue DESC;
