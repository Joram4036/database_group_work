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
