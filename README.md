# database_group_work

This repository contains a SQL database implementation for a bookstore management system. The `answers.sql` file includes:

## Database Structure
- Complete SQL schema for a BookStoreDB database
- 15 interconnected tables including:
  - Core tables: `book`, `author`, `publisher`, `customer`
  - Supporting tables: `book_language`, `book_author`, `country`
  - Order-related tables: `cust_order`, `order_line`, `order_history`
  - Address management: `address`, `address_status`, `customer_address`

## Contents
1. Database and table creation scripts
2. Sample data insertion for all tables
3. User management (admin and read-only user creation)
4. Example queries demonstrating:
   - Basic data retrieval
   - Sales analysis
   - Customer purchase patterns
   - Book performance metrics
   - Order fulfillment analysis
   - Multi-table joins and complex aggregations

The database is designed to handle all aspects of a bookstore's operations, from inventory management to customer orders and shipping logistics.