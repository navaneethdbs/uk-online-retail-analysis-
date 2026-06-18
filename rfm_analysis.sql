-- ============================================
-- UK Online Retail Analysis
-- RFM Segmentation Queries
-- Data Source: UCI Machine Learning Repository
-- Author: Navaneeth Aravindakshan
-- ============================================

-- QUERY 1: Data Cleaning - Remove nulls and cancelled orders
SELECT *
FROM online_retail
WHERE CustomerID IS NOT NULL
AND Quantity > 0
AND UnitPrice > 0
AND InvoiceNo NOT LIKE 'C%';

-- QUERY 2: RFM Calculation
-- Recency = days since last purchase
-- Frequency = number of purchases
-- Monetary = total spend
SELECT 
    CustomerID,
    DATEDIFF(MAX(InvoiceDate), '2011-12-09') * -1 AS Recency,
    COUNT(DISTINCT InvoiceNo) AS Frequency,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Monetary
FROM online_retail
WHERE CustomerID IS NOT NULL
AND Quantity > 0
AND UnitPrice > 0
AND InvoiceNo NOT LIKE 'C%'
GROUP BY CustomerID;

-- QUERY 3: RFM Scoring (1-4 scale)
WITH rfm AS (
    SELECT 
        CustomerID,
        DATEDIFF(MAX(InvoiceDate), '2011-12-09') * -1 AS Recency,
        COUNT(DISTINCT InvoiceNo) AS Frequency,
        ROUND(SUM(Quantity * UnitPrice), 2) AS Monetary
    FROM online_retail
    WHERE CustomerID IS NOT NULL
    AND Quantity > 0
    AND UnitPrice > 0
    AND InvoiceNo NOT LIKE 'C%'
    GROUP BY CustomerID
)
SELECT *,
    NTILE(4) OVER (ORDER BY Recency DESC) AS R_Score,
    NTILE(4) OVER (ORDER BY Frequency ASC) AS F_Score,
    NTILE(4) OVER (ORDER BY Monetary ASC) AS M_Score
FROM rfm;

-- QUERY 4: Customer Segmentation Labels
-- Champions: bought recently, buy often, spend the most
-- Loyal Customers: buy regularly
-- At Risk: bought often but not recently
-- Lost: lowest scores across all metrics
SELECT 
    CustomerID,
    Recency,
    Frequency,
    Monetary,
    R_Score,
    F_Score,
    M_Score,
    CASE 
        WHEN R_Score = 4 AND F_Score = 4 AND M_Score = 4 THEN 'Champion'
        WHEN R_Score >= 3 AND F_Score >= 3 THEN 'Loyal Customer'
        WHEN R_Score >= 3 AND F_Score <= 2 THEN 'Potential Loyalist'
        WHEN R_Score <= 2 AND F_Score >= 3 THEN 'At Risk'
        WHEN R_Score = 1 AND F_Score = 1 THEN 'Lost'
        ELSE 'Needs Attention'
    END AS Customer_Segment
FROM rfm_scored;

-- QUERY 5: Revenue by Country
-- Finding: UK dominates at 83% of total revenue
SELECT 
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Total_Revenue,
    COUNT(DISTINCT CustomerID) AS Customer_Count,
    ROUND(SUM(Quantity * UnitPrice) / 
        (SELECT SUM(Quantity * UnitPrice) FROM online_retail 
         WHERE Quantity > 0 AND UnitPrice > 0) * 100, 2) AS Revenue_Percentage
FROM online_retail
WHERE Quantity > 0
AND UnitPrice > 0
GROUP BY Country
ORDER BY Total_Revenue DESC;