SELECT * FROM sales.customers;

SELECT count(*) FROM sales.transactions;

SELECT * FROM sales.transactions where currency = 'USD';

SELECT SUM(sales.transactions.sales_amount) FROM sales.transactions INNER JOIN sales.date ON sales.transactions.order_date=sales.date.date where sales.date.year='2020' and sales.transactions.market_code = 'Mark001';
