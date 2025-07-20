SELECT * FROM superstore
LIMIT 10;

-- Fundamental Analysis-- 

-- 1. What is the total sales amount?
SELECT ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore;

-- 2. What region has the highest sales?
SELECT Region, ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore
GROUP BY Region
ORDER BY Total_Sales DESC
LIMIT 1;

-- 3. Who is the 5 top customer by total sales?
SELECT CustomerName, ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore
GROUP BY CustomerName
ORDER BY Total_Sales DESC
LIMIT 5;

-- 4. What are the top 5 most profitable products?
SELECT ProductName, ROUND(SUM(Profit), 2) AS Total_Profit
FROM Superstore
GROUP BY ProductName
ORDER BY Total_Profit DESC
LIMIT 5;

-- 5. What is the overall profit margin of the Superstore?
SELECT 
    SUM(Profit) AS Total_Profit, 
    SUM(Sales) AS Total_Sales, 
    (SUM(Profit) / SUM(Sales)) * 100 AS Profit_Margin_Percentage
FROM Superstore;

-- 6. Which category and sub-category combination generates the most sales?
SELECT Category, SubCategory, ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore
GROUP BY Category, SubCategory
ORDER BY Total_Sales DESC
LIMIT 1;

-- 7. What are the most common shipping modes used?
SELECT ShipMode, COUNT(*) AS Count
FROM Superstore
GROUP BY ShipMode
ORDER BY Count DESC;

-- 8. Which region experiences the highest discounts on average?
SELECT Region, ROUND(AVG(Discount), 3) AS Average_Discount
FROM Superstore
GROUP BY Region
ORDER BY Average_Discount DESC
LIMIT 1;

-- 9. What is the average delivery time for orders?
SELECT 
    AVG(DATEDIFF(ShipDate, OrderDate)) AS Average_Delivery_Time
FROM Superstore;

-- 10. How many orders were placed in each year?
SELECT YEAR(OrderDate) AS Order_Year, COUNT(*) AS Number_Of_Orders
FROM Superstore
GROUP BY Order_Year
ORDER BY Order_Year;

-- 11. What region generates the highest sales and profits?
SELECT region, ROUND(SUM(sales), 2) as Total_Sales, ROUND(SUM(profit), 2) as Total_Profit
FROM superstore
Group by region
Order by Total_Profit desc;

-- 12. What are total sales and total profits of each year?
select year(OrderDate) as year, round(sum(sales), 2) as Total_sales, ROUND(sum(sales),2) AS Total_Profits 
from superstore
group by year
order by year asc;

-- 13. What are the total profits and total sales per quarter?

select YEAR(OrderDate) as year,
CASE
	when month(OrderDate) IN (1,2,3) then 'Q1'
    when month(OrderDate) IN (4,5,6) then 'Q2'
    when month(OrderDate) IN (7,8,9) then 'Q3'
    else 'Q4'
END AS quarter,
round(sum(sales), 2) as Total_Sales,
round(sum(profit), 2) as Total_Profit
from superstore
group by year, quarter
order by year, quarter;    

-- 14. Let’s observe each regions profit margins for further analysis with the following code:

select region, round((sum(profit) / sum(sales)) * 100, 2) as profit_margin
from superstore
group by region
order by profit_margin desc; 

-- 15. What state and city brings in the highest sales and profits?
-- A. Let’s discover what states are the top 10 highest and lowest sales.

select state, round(sum(sales), 2) as total_sales, round(sum(profit), 2) as total_profit, 
round(sum(profit) / sum(sales) *100, 2) as profit_margin
from superstore 
group by state 
order by total_profit desc
limit 10;

-- Let’s observe our bottom 10 States:

SELECT State, ROUND(SUM(Sales), 2) as Total_Sales, ROUND(SUM(Profit), 2) as Total_Profit
FROM superstore
GROUP BY State
ORDER BY Total_Profit ASC
LIMIT 10;

-- B. city are the top 10 highest and lowest sales.

select city, round(sum(sales), 2) as total_sales, round(sum(profit), 2) as total_profit, 
round(sum(profit) / sum(sales) *100, 2) as profit_margin
from superstore 
group by city 
order by total_profit desc
limit 10;

-- The bottom 10 cities are:
SELECT City, ROUND(SUM(Sales), 2) as Total_Sales, ROUND(SUM(Profit), 2) as Total_Profit
FROM superstore
GROUP BY City
ORDER BY Total_Profit ASC
LIMIT 10;

-- 16. The relationship between discount and sales, and the total discount per category
-- A. The relationship between discount and sales
SELECT Discount, ROUND(AVG(Sales), 2) AS Avg_Sales
FROM superstore
GROUP BY Discount
ORDER BY Discount;

-- B. Let’s observe the total discount per product category:
SELECT  Category, round(SUM(Discount), 2) AS Total_Discount
FROM superstore
GROUP BY Category
ORDER BY Total_Discount desc;

-- C. Let’s zoom in the category section to see exactly what type of products are the most discounted.

select category, subcategory, round(sum(discount), 2) as Total_discount
from superstore
group by category, subcategory
order by Total_discount desc;

-- 18. What category generates the highest sales and profits in each region and state?
-- A. First, let’s observe the total sales and total profits of each category with their profit margins:
SELECT category, ROUND(SUM(sales), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin
FROM superstore
GROUP BY category
ORDER BY total_profit DESC;

-- B.  Let’s observe the highest total sales and total profits per Category in each region:
SELECT region, category, ROUND(SUM(sales), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY region, category
ORDER BY total_profit DESC;

-- C. Now let’s see the highest total sales and total profits per Category in each state:
SELECT state, category, ROUND(SUM(sales), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY state, category
ORDER BY total_profit DESC;

-- D. . Let’s check the least profitable ones by just changing our ‘ORDER BY’ clause too ascending (ASC):
SELECT state, category, ROUND(SUM(sales), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY state, category
ORDER BY total_profit ASC;

-- 19. What subcategory generates the highest sales and profits in each region and state?
-- A. Let’s observe the total sales and total profits of each subcategory with their profit margins:
SELECT subcategory, ROUND(SUM(sales), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin
FROM superstore
GROUP BY subcategory
ORDER BY total_profit DESC;

-- B. Now let’s see the highest total sales and total profits per subcategory in each region:
SELECT region, subcategory, ROUND(SUM(sales), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY region, subcategory
ORDER BY total_profit DESC;

-- C. Now let’s see the least performing ones:
SELECT region, subcategory, ROUND(SUM(sales), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY region, subcategory
ORDER BY total_profit ASC;

-- D. Now let’s see the highest total sales and total profits per subcategory in each state:
SELECT state, subcategory, ROUND(SUM(sales), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY state, subcategory
ORDER BY total_profit DESC;

-- E. Let’s see the lowest sales and profits. Still in order for biggest lost in profits.
SELECT state, subcategory, ROUND(SUM(sales), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY state, subcategory
ORDER BY total_profit ASC;

-- 20. What segment makes the most of our profits and sales?
SELECT segment, ROUND(SUM(sales), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY segment
ORDER BY total_profit DESC;

-- 21. How many customers do we have (unique customer IDs) in total and how much per region and state?
SELECT COUNT(DISTINCT customerid) AS total_customers
FROM superstore;

-- A. region
SELECT region, COUNT(DISTINCT customerid) AS total_customers
FROM superstore
GROUP BY region
ORDER BY total_customers DESC;

-- B. Statewise
SELECT state, COUNT(DISTINCT customerid) AS total_customers
FROM superstore
GROUP BY state
ORDER BY total_customers DESC;

-- C. The areas where we have the least that passed by there are:
SELECT state, COUNT(DISTINCT customerid) AS total_customers
FROM superstore
GROUP BY state
ORDER BY total_customers ASC;

-- 22. Customer rewards program
SELECT customerid, ROUND(SUM(sales), 2) AS total_sales, ROUND(SUM(profit), 2) AS total_profit
FROM superstore
GROUP BY customerid
ORDER BY total_sales DESC
LIMIT 15;

-- 23. Average shipping time per class and in total
SELECT ROUND(AVG(shipdate - orderdate), 2) AS avg_shipping_time
FROM superstore;

-- The shipping time in each shipping mode is:
SELECT shipmode,ROUND(AVG(shipdate - orderdate), 2) AS avg_shipping_time
FROM superstore
GROUP BY shipmode
ORDER BY avg_shipping_time;

-- Advanced Analysis--

-- 1. Who are the top 5 customers contributing to the total profit, and what percentage of the total profit do they contribute?

WITH TotalProfit AS (
    SELECT ROUND(SUM(Profit), 2) AS Overall_Profit FROM Superstore
),
CustomerProfit AS (
    SELECT CustomerName, ROUND(SUM(Profit), 2) AS Total_Profit
    FROM Superstore
    GROUP BY CustomerName
)
SELECT 
    CustomerName, 
    Total_Profit,
    ROUND((Total_Profit / (SELECT Overall_Profit FROM TotalProfit)) * 100, 2) AS Profit_Percentage
FROM CustomerProfit
ORDER BY Total_Profit DESC
LIMIT 5;

-- 2. Find the percentage contribution of each region to total sales using a window function

SELECT 
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Sales) / SUM(SUM(Sales)) OVER() * 100, 2) AS Sales_Percentage
FROM Superstore
GROUP BY Region
ORDER BY Total_Sales DESC;

-- 3. Identify the most profitable product in each category using a window function

WITH RankedProducts AS (
    SELECT 
        Category,
        ProductName,
        ROUND(SUM(Profit), 2) AS Total_Profit,
        RANK() OVER (PARTITION BY Category ORDER BY SUM(Profit) DESC) AS Rank_Within_Category
    FROM Superstore
    GROUP BY Category, ProductName
)
SELECT *
FROM RankedProducts
WHERE Rank_Within_Category = 1;

-- 4. Find the top-performing sub-category for each region by profit

WITH SubCategoryProfit AS (
    SELECT 
        Region,
        SubCategory,
        ROUND(SUM(Profit), 2) AS Total_Profit,
        RANK() OVER (PARTITION BY Region ORDER BY SUM(Profit) DESC) AS Rank_Within_Region
    FROM Superstore
    GROUP BY Region, SubCategory
)
SELECT *
FROM SubCategoryProfit
WHERE Rank_Within_Region = 1;

-- 5. Compare sales trends between categories by month and year

WITH SalesByCategory AS (
    SELECT 
        Category,
        DATE_FORMAT(OrderDate, '%m-%Y') AS Month_Year,
        ROUND(SUM(Sales), 2) AS Monthly_Sales
    FROM Superstore
    GROUP BY Category, Month_Year
)
SELECT 
    Category,
    Month_Year,
    Monthly_Sales,
    LAG(Monthly_Sales) OVER (PARTITION BY Category ORDER BY Month_Year) AS Previous_Month_Sales,
    ROUND(Monthly_Sales - LAG(Monthly_Sales) OVER (PARTITION BY Category ORDER BY Month_Year), 2) AS Sales_Difference
FROM SalesByCategory
ORDER BY Category, Month_Year;

-- 6. What is the most common ship mode for high-profit orders (profit > $500)?

SELECT ShipMode, COUNT(*) AS High_Profit_Order_Count
FROM Superstore
WHERE Profit > 500
GROUP BY ShipMode
ORDER BY High_Profit_Order_Count DESC;

-- 7. Calculate the cumulative sales for each region over time

WITH RegionalSales AS (
    SELECT 
        Region,
        OrderDate,
        ROUND(SUM(Sales), 2) AS Daily_Sales
    FROM Superstore
    GROUP BY Region, OrderDate
)
SELECT 
    Region,
    OrderDate,
    Daily_Sales,
    ROUND(SUM(Daily_Sales) OVER (PARTITION BY Region ORDER BY OrderDate), 2) AS Cumulative_Sales
FROM RegionalSales
ORDER BY Region, OrderDate;

-- 8. Which city has the highest average sales per order?

SELECT City, ROUND(AVG(Sales), 2) AS Avg_Sales_Per_Order
FROM Superstore
GROUP BY City
ORDER BY Avg_Sales_Per_Order DESC
LIMIT 1;

-- 9. Identify customers who placed orders in all regions

WITH CustomerRegions AS (
    SELECT DISTINCT CustomerName, Region
    FROM Superstore
)
SELECT CustomerName
FROM CustomerRegions
GROUP BY CustomerName
HAVING COUNT(DISTINCT Region) = (SELECT COUNT(DISTINCT Region) FROM Superstore);

-- 10. Analyze discount impact on profit by category

SELECT Category, ROUND(AVG(Discount), 2) AS Avg_Discount, ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin_Percentage
FROM Superstore
GROUP BY Category
ORDER BY Avg_Discount DESC;

-- 11. Which month has the highest total sales?

SELECT MONTHNAME(OrderDate) AS Month, ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore
GROUP BY Month
ORDER BY Total_Sales DESC
LIMIT 1;

-- 12. Which product category has the highest discount on average?

SELECT Category, ROUND(AVG(Discount), 2) AS Avg_Discount
FROM Superstore
GROUP BY Category
ORDER BY Avg_Discount DESC
LIMIT 1;

-- 13. Identify the product that has been sold the most by quantity

SELECT ProductName, SUM(Quantity) AS Total_Quantity
FROM Superstore
GROUP BY ProductName
ORDER BY Total_Quantity DESC
LIMIT 1;

-- 14. Which customer has placed the largest number of orders?

SELECT CustomerName, COUNT(OrderID) AS Number_Of_Orders
FROM Superstore
GROUP BY CustomerName
ORDER BY Number_Of_Orders DESC
LIMIT 1;

-- 15. Identify the state with the highest profit-to-sales ratio

SELECT State, ROUND(SUM(Profit) / SUM(Sales), 2) AS Profit_Sales_Ratio
FROM Superstore
GROUP BY State
ORDER BY Profit_Sales_Ratio DESC
LIMIT 1;

-- 16. Calculate the average order value (AOV) by region

SELECT Region, ROUND(SUM(Sales) / COUNT(DISTINCT OrderID), 2) AS Avg_Order_Value
FROM Superstore
GROUP BY Region;

-- 17. What are the top 3 cities with the highest cumulative sales?

SELECT City, ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore
GROUP BY City
ORDER BY Total_Sales DESC
LIMIT 3;

-- 18. Find the percentage of orders that received a discount

SELECT 
    ROUND(COUNT(CASE WHEN Discount > 0 THEN 1 END) / COUNT(*) * 100, 2) AS Discounted_Orders_Percentage
FROM Superstore;

-- 19. What is the most expensive product sold by unit price?

SELECT ProductName, MAX(Sales / Quantity) AS Unit_Price
FROM Superstore
WHERE Quantity > 0
GROUP BY ProductName
ORDER BY Unit_Price DESC
LIMIT 1;

-- 20. Find the top 5 states contributing to overall sales

SELECT State, ROUND(SUM(Sales), 2) AS Total_Sales
FROM Superstore
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 5;

-- 21. Analyze customer profitability by region

WITH CustomerProfit AS (
    SELECT 
        Region, 
        CustomerName, 
        ROUND(SUM(Profit), 2) AS Total_Profit
    FROM Superstore
    GROUP BY Region, CustomerName
)
SELECT 
    Region, 
    CustomerName, 
    Total_Profit, 
    RANK() OVER (PARTITION BY Region ORDER BY Total_Profit DESC) AS Profit_Rank
FROM CustomerProfit;

-- 22. What is the reorder rate for products?

WITH ProductOrders AS (
    SELECT 
        ProductName, 
        COUNT(DISTINCT OrderID) AS Order_Count
    FROM Superstore
    GROUP BY ProductName
)
SELECT 
    COUNT(*) AS Reordered_Products, 
    ROUND(COUNT(*) / (SELECT COUNT(*) FROM ProductOrders) * 100, 2) AS Reorder_Rate
FROM ProductOrders
WHERE Order_Count > 1;

-- 23. Which sub-category has the lowest profit margin?

SELECT SubCategory, ROUND(SUM(Profit) / SUM(Sales) * 100, 2) AS Profit_Margin
FROM Superstore
GROUP BY SubCategory
ORDER BY Profit_Margin ASC
LIMIT 1;

-- 24. Identify customers with at least 5 orders in a single year

WITH CustomerOrders AS (
    SELECT 
        CustomerName, 
        YEAR(OrderDate) AS Order_Year, 
        COUNT(OrderID) AS Order_Count
    FROM Superstore
    GROUP BY CustomerName, Order_Year
)
SELECT 
    CustomerName, 
    Order_Year, 
    Order_Count
FROM CustomerOrders
WHERE Order_Count >= 5;

-- 25. Calculate the total profit contribution by customer segment

SELECT 
    Segment, 
    ROUND(SUM(Profit), 2) AS Total_Profit, 
    ROUND(SUM(Profit) / (SELECT SUM(Profit) FROM Superstore) * 100, 2) AS Profit_Percentage
FROM Superstore
GROUP BY Segment;

-- 26. Which product sub-category has the most consistent sales (lowest variance)?

SELECT SubCategory, ROUND(VARIANCE(Sales), 2) AS Sales_Variance
FROM Superstore
GROUP BY SubCategory
ORDER BY Sales_Variance ASC
LIMIT 1;

-- 27. Find the average delivery time (in days) by ship mode

SELECT 
    ShipMode, 
    ROUND(AVG(DATEDIFF(ShipDate, OrderDate)), 2) AS Avg_Delivery_Time
FROM Superstore
GROUP BY ShipMode;

-- 28. Identify regions where at least one product generated a loss

SELECT DISTINCT Region
FROM Superstore
WHERE Profit < 0;

-- 29. Calculate cumulative profit across order dates

SELECT 
    OrderDate, 
    ROUND(SUM(Profit), 2) AS Daily_Profit, 
    ROUND(SUM(SUM(Profit)) OVER (ORDER BY OrderDate), 2) AS Cumulative_Profit
FROM Superstore
GROUP BY OrderDate
ORDER BY OrderDate;

-- 30. Rank categories by total sales and profit simultaneously

SELECT 
    Category, 
    SUM(Sales) AS Total_Sales, 
    SUM(Profit) AS Total_Profit,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank,
    RANK() OVER (ORDER BY SUM(Profit) DESC) AS Profit_Rank
FROM Superstore
GROUP BY Category;

-- 31. What is the average sales per customer in each segment?

SELECT 
    Segment, 
    ROUND(SUM(Sales) / COUNT(DISTINCT CustomerID), 2) AS Avg_Sales_Per_Customer
FROM Superstore
GROUP BY Segment;

-- 32. Determine the peak month for each product category

WITH MonthlySales AS (
    SELECT 
        Category, 
        MONTHNAME(OrderDate) AS Month, 
        SUM(Sales) AS Total_Sales
    FROM Superstore
    GROUP BY Category, MONTHNAME(OrderDate)
),
RankedMonthlySales AS (
    SELECT 
        Category,
        Month,
        Total_Sales,
        RANK() OVER (PARTITION BY Category ORDER BY Total_Sales DESC) AS Ranks
    FROM MonthlySales
)
SELECT 
    Category,
    Month,
    Total_Sales, Ranks
FROM RankedMonthlySales
WHERE Ranks = 1;


-- 33. Calculate total sales of products with zero profit

SELECT SUM(Sales) AS Total_Sales_Zero_Profit
FROM Superstore
WHERE Profit = 0;

-- 34. Find customers who only placed discounted orders

SELECT CustomerName
FROM Superstore
GROUP BY CustomerName
HAVING SUM(CASE WHEN Discount = 0 THEN 1 ELSE 0 END) = 0;


-- Lakshmi Kant --