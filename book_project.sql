create database onlinebookstore_db;
use onlinebookstore_db;

show tables;
select * from books;
select * from customers;
select * from orders;

select b.Title , c.name from books b 
join customers c on b.Book_ID = c.Customer_ID;

-- 1. Retrieve all books in the “Fiction” genre. 
select * from books where Genre = 'Fiction';
select title ,count(Book_Id) from books where Genre = 'Fiction'group by title;

-- 2. Find books published after the year 1950. 
select * from books where Published_Year > 1950;

-- 3. List all customers from Canada. 
select * from customers where Country = 'Canada'; 

-- 4. Show orders placed in November 2023. 
select * from orders where Order_Date Between '2023-11-01' and '2023-11-30';

-- 5. Retrieve the total stock of books available. 
select sum(stock) as total_stocks from books;

-- 6. Find the details of the most expensive book. 
select * from books order by price desc limit 1;

-- 7. Show all customers who ordered more than 1 quantity of a book. 
select c.Name ,c.City, o.Quantity from Customers c join Orders o on c.Customer_ID = o.Order_ID where Quantity > 1;

-- 8. Retrieve all orders where the total amount exceeds $20. 
select Order_ID from Orders where Total_Amount > 20;
-- 8. Retrieve all orders where the total amount exceeds $20
SELECT o.order_id, SUM(oi.quantity * b.price) AS total_amount
FROM Orders o
JOIN Orders oi ON o.order_id = oi.order_id
JOIN Books b ON oi.book_id = b.book_id
GROUP BY o.order_id
HAVING SUM(oi.quantity * b.price) > 20;

-- 9. List all distinct genres in the bookstore. 
select distinct genre from books;

-- 10. Find the book with the lowest stock available. 
select * from books order by stock asc limit 1;

-- 11. Calculate the total revenue from all orders. 
select sum(o.quantity * b.price) as total_reveue from orders o join books b on o.book_ID = b.book_ID;

-- 12. Retrieve the total number of books sold for each genre.
select b.genre ,sum(o.Quantity) as total_books_sold FROM books b join orders o on b.book_id = o.book_id
group by b.genre;

-- 13. Find the average price of books in the “Fantasy” genre. 
select avg(price) from books where genre = 'Fantasy'; 

-- 14. List customers who have placed at least 2 orders. 
select c.customer_id ,c.name,count(o.order_id) as total_orders 
from customers c join orders o 
on c.customer_id = o.customer_id 
group by c.customer_id,c.name having  COUNT(o.order_id) >= 2;  

-- 15. Find the most frequently ordered book.
SELECT b.book_id, b.title, SUM(o.quantity) AS total_sold
FROM Books b
JOIN Orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title
ORDER BY total_sold DESC
LIMIT 1;

SELECT b.book_id, b.title, SUM(o.order_id) AS total_sold
FROM Books b
JOIN Orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title
ORDER BY total_sold DESC
LIMIT 1;

-- 16. Show the top 3 most expensive books of the “Fantasy” genre.

select title,price from books where genre = 'Fantasy' order by price Desc limit 3; 

-- 17. Retrieve the total quantity of books sold by each author.
select b.author,sum(o.Quantity) as total_Sold
from books b
join orders o on b.book_id = o.book_id group by b.author;

-- 18. List the cities of customers who spent over $30.
SELECT c.city, SUM(o.quantity * b.price) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Books b ON o.book_id = b.book_id
GROUP BY c.city
HAVING SUM(o.quantity * b.price) > 30;

-- 19. Find the customer who spent the most on orders. 
select c.customer_id , c.name, sum(o.quantity * b.price) as total_spent
from customers c 
join orders o on c.customer_id = o.customer_id
join books b on o.book_id = b.book_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC
LIMIT 1;

-- 20. Calculate the stock remaining after fulfilling all orders. 
 SELECT b.book_id, 
       b.title, 
       b.stock - IFNULL(SUM(o.quantity), 0) AS remaining_stock
FROM Books b
LEFT JOIN Orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.title, b.stock;


