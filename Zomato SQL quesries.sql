USE zomato;
SELECT * FROM dbo.Zomato_data;

/*
1. What are the **top-rated restaurants** in each city?
2. What’s the **average rating by city** or locality?
3. Which **rating labels** (like "Excellent", "Good") are most common?
4. Are **restaurants with online delivery** rated higher on average?

---

### Cost & Pricing Strategy

5. What’s the **average cost for two** in each city?
6. Which cities have the most **expensive vs. affordable** restaurants?
7. Do **higher-priced restaurants** get better ratings?

---

### Location-Based Insights

8. How many restaurants are listed **per city** or **locality**?
9. Which cities have the **highest concentration** of restaurants?
10. Which localities have the most highly rated restaurants?

---

### Delivery & Table Booking Trends

11. How many restaurants offer online delivery in each city?
12. How many offer table booking, and where?
13. What’s the rating difference between restaurants **with** and **without**:

    * Online delivery
    * Table booking

---

### Cuisine & Menu Insights

14. What are the **most common cuisines** offered in each city?
15. Which cuisines are associated with the **highest average ratings**?
16. Is there a trend between **cuisine type** and **price range**?

---

### Bonus: Custom Metrics & Drilldowns

17. Value for money score = `rating / cost`

    Which cities or cuisines offer the best value?
18. Create **price buckets** (e.g., low, medium, high) and analyze:

    * How ratings differ by price bucket
    * Whether delivery is more common in low/mid/high-priced restaurants

---
 1. Is there a threshold beyond which higher price stops increasing rating?
"Is there a point of diminishing returns on price vs. rating?"

Idea: Divide prices into buckets (e.g., ₹0–300, ₹301–600, ₹601–900, ₹901+), then check avg rating per bucket.

Query uses: CASE + GROUP BY

 2. Do expensive restaurants have more consistent ratings than cheap ones?
"Is rating variance lower at high-end restaurants?"

More stable ratings = more predictability.

 3. What’s the correlation between cost and rating?
"Is there a statistical correlation (positive/negative/none)?"


 4. Which city has the best value-for-money restaurants?
"Where are high ratings available at low cost?"


 5. Are certain cuisines consistently overpriced or underpriced?

 6. Do restaurants that charge more offer better delivery experience?
"Is there a link between pricing and delivery availability?"


 7. Are expensive restaurants more likely to offer table booking or delivery?
"Does premium pricing come with premium services?"


*/


-- Questions related to the database.
-- 1. What are the top rated restaurants in each city?

SELECT 
    Location_city,
    Restaurant_name,
    Restaurants_aggregate_rating
FROM dbo.Zomato_data
WHERE Restaurants_aggregate_rating = 5
ORDER BY Location_city;

-- 2. What’s the average rating by city?

SELECT
Location_city,
AVG(CAST(Restaurants_aggregate_rating AS FLOAT)) AS Avg_rating
FROM  dbo.Zomato_data
GROUP BY Location_city
ORDER BY 
Avg_rating DESC;

-- 3. Are restaurants with online delivery rated higher on average?

SELECT 
    Online_delivery_available,
    COUNT(*) AS Total_Restaurants,
    AVG(CAST(Restaurants_aggregate_rating AS FLOAT)) AS Average_Rating
FROM 
    dbo.Zomato_data
WHERE 
    Restaurants_aggregate_rating > 0
GROUP BY 
    Online_delivery_available
ORDER BY 
    Average_Rating DESC;


-- 4. What’s the average cost for two in each city?

SELECT 
    Location_city,
    AVG(CAST(Average_cost_for_two AS FLOAT)) AS Avg_cost
FROM 
    dbo.Zomato_data
WHERE 
    Average_cost_for_two > 0
GROUP BY
    Location_city
ORDER BY
    Avg_cost DESC;


-- 5.Which cities have the most expensive vs. affordable restaurants?

-- In terms of Restaurant_price_range rating
SELECT 
Location_city,
AVG(CAST (Restaurant_price_range AS FLOAT)) AS Affordability
FROM 
dbo.Zomato_data
WHERE Restaurant_price_range > 0
GROUP BY
Location_city
ORDER BY Affordability DESC;

-- In terms of average_cost_for_two

SELECT 
    Location_city,
    COUNT (*) AS Total_Restaurants,
    AVG(CAST(Average_cost_for_two AS FLOAT)) AS Avg_cost
FROM 
    dbo.Zomato_data
WHERE 
    Average_cost_for_two > 0
GROUP BY
    Location_city
ORDER BY
    Avg_cost DESC;

-- 6.Do higher-priced restaurants get better ratings?

SELECT 
    Restaurant_price_range,
    COUNT(*) AS Total_Restaurants,
    AVG(CAST(Restaurants_aggregate_rating AS FLOAT)) AS Average_Rating,
    AVG(CAST(Average_cost_for_two AS FLOAT)) AS Average_Cost
FROM 
    dbo.Zomato_data
WHERE 
    Restaurants_aggregate_rating > 0
GROUP BY 
    Restaurant_price_range
ORDER BY 
    Restaurant_price_range ASC;

-- 7.How many restaurants are listed per city or locality?
  
  -- Restaurants per city
SELECT
    Location_city,
    COUNT (*) AS Total_restaurants
FROM
    dbo.Zomato_data
GROUP BY 
    Location_city
ORDER BY 
    Total_Restaurants DESC;

   -- Restaurants per locality

-- 8.Which cities have the highest concentration of restaurants?
SELECT 
    Location_city,
    COUNT(*) AS Total_Restaurants
FROM 
    dbo.Zomato_data
GROUP BY 
    Location_city
ORDER BY 
    Total_Restaurants DESC;

-- 9.Which localities have the most highly rated restaurants?
SELECT 
    Location_city,
    Restaurant_locality,
    COUNT(*) AS Total_Restaurants,
    AVG(CAST(Restaurants_aggregate_rating AS FLOAT)) AS Avg_Rating
FROM 
    dbo.Zomato_data
WHERE 
    Restaurants_aggregate_rating > 0
GROUP BY 
    Location_city, Restaurant_locality
HAVING 
    COUNT(*) >= 5  -- filters out low-data localities
ORDER BY 
    Avg_Rating DESC;

-- Localities with highest average rating overall
SELECT 
    Restaurant_locality,
    COUNT(*) AS Total_Restaurants,
    AVG(CAST(Restaurants_aggregate_rating AS FLOAT)) AS Avg_Rating
FROM 
    dbo.Zomato_data
WHERE 
    Restaurants_aggregate_rating > 0
GROUP BY 
    Restaurant_locality
HAVING 
    COUNT(*) >= 5   -- Optional: filter out localities with very few restaurants
ORDER BY 
    Avg_Rating DESC;


-- 10.How many restaurants offer online delivery in each city?
SELECT 
    Location_city,
    COUNT(*) AS Delivery_Restaurants
FROM 
    dbo.Zomato_data
WHERE 
    Online_delivery_available = 'Yes'
GROUP BY 
    Location_city
ORDER BY 
    Delivery_Restaurants DESC;


-- 11.How many offer table booking, and where?

SELECT 
    Location_city,
    COUNT(*) AS Table_Booking_Restaurants
FROM 
    dbo.Zomato_data
WHERE 
    Table_booking = 1
GROUP BY 
    Location_city
ORDER BY 
    Table_Booking_Restaurants DESC;

-- 12. What’s the rating difference between restaurants with and without online delivery?

SELECT 
    Online_delivery_available,
    COUNT(*) AS Total_Restaurants,
    AVG(CAST(Restaurants_aggregate_rating AS FLOAT)) AS Average_Rating
FROM 
    dbo.Zomato_data
WHERE 
    Restaurants_aggregate_rating > 0
GROUP BY 
    Online_delivery_available
ORDER BY 
    Average_Rating DESC;

-- 13. What’s the rating difference between restaurants with and without table booking?

SELECT 
    Table_booking,
    COUNT(*) AS Total_Restaurants,
    AVG(CAST(Restaurants_aggregate_rating AS FLOAT)) AS Average_Rating
FROM 
    dbo.Zomato_data
WHERE 
    Restaurants_aggregate_rating > 0
GROUP BY 
    Table_booking
ORDER BY 
    Average_Rating DESC;

-- 14.Which cuisines are associated with the **highest average ratings**?

SELECT 
    Cuisines,
    COUNT(*) AS Total_Restaurants,
    AVG(CAST(Restaurants_aggregate_rating AS FLOAT)) AS Average_Rating
FROM 
    dbo.Zomato_data
WHERE 
    Restaurants_aggregate_rating > 0 AND Cuisines IS NOT NULL
GROUP BY 
    Cuisines
HAVING 
    COUNT(*) >= 5  -- optional: avoid outliers with very few entries
ORDER BY 
    Average_Rating DESC;

-- 15. What are the most common cuisines offered in each city?

SELECT 
    Location_city,
    Cuisines,
    COUNT(*) AS Restaurant_Count
FROM 
    dbo.Zomato_data
WHERE 
    Cuisines IS NOT NULL
GROUP BY 
    Location_city, Cuisines
ORDER BY 
    Location_city, Restaurant_Count DESC;

-- 16.Is there a trend between cuisine type and price range?

SELECT 
    LTRIM(RTRIM(value)) AS Cuisine,
    AVG(CAST(Restaurant_price_range AS FLOAT)) AS Avg_Price_Range,
    COUNT(*) AS Restaurant_Count
FROM 
    dbo.Zomato_data
CROSS APPLY 
    STRING_SPLIT(Cuisines, ',')
WHERE 
    Restaurant_price_range IS NOT NULL
GROUP BY 
    LTRIM(RTRIM(value))
HAVING 
    COUNT(*) >= 10  -- only keep popular cuisines
ORDER BY 
    Avg_Price_Range DESC;

-- 17. Value for money score = `rating / cost`

SELECT 
    Restaurant_name,
    Location_city,
    Cuisines,
    Restaurants_aggregate_rating,
    Average_cost_for_two,
    CAST(Restaurants_aggregate_rating AS FLOAT) / NULLIF(Average_cost_for_two, 0) AS Value_For_Money_Score
FROM 
    dbo.Zomato_data
WHERE 
    Restaurants_aggregate_rating > 0 AND Average_cost_for_two > 0
ORDER BY 
    Value_For_Money_Score DESC;

-- Which cities or cuisines offer the best value?

SELECT 
    Location_city,
    COUNT(*) AS Total_Restaurants,
    AVG(CAST(Restaurants_aggregate_rating AS FLOAT) / NULLIF(Average_cost_for_two, 0)) AS Avg_Value_For_Money
FROM 
    dbo.Zomato_data
WHERE 
    Restaurants_aggregate_rating > 0 AND Average_cost_for_two > 0
GROUP BY 
    Location_city
HAVING 
    COUNT(*) >= 10  -- Optional: filter out small cities
ORDER BY 
    Avg_Value_For_Money DESC;

--18. Create **price buckets** (e.g., low, medium, high) and analyze:

SELECT 
    CASE 
        WHEN Average_cost_for_two BETWEEN 0 AND 300 THEN '₹0–300'
        WHEN Average_cost_for_two BETWEEN 301 AND 600 THEN '₹301–600'
        WHEN Average_cost_for_two BETWEEN 601 AND 900 THEN '₹601–900'
        WHEN Average_cost_for_two BETWEEN 901 AND 1200 THEN '₹901–1200'
        WHEN Average_cost_for_two > 1200 THEN '₹1200+'
        ELSE 'Unknown'
    END AS Price_Band,
    COUNT(*) AS Restaurant_Count,
    AVG(CAST(Restaurants_aggregate_rating AS FLOAT)) AS Avg_Rating
FROM 
    dbo.Zomato_data
WHERE 
    Average_cost_for_two > 0 AND Restaurants_aggregate_rating > 0
GROUP BY 
    CASE 
        WHEN Average_cost_for_two BETWEEN 0 AND 300 THEN '₹0–300'
        WHEN Average_cost_for_two BETWEEN 301 AND 600 THEN '₹301–600'
        WHEN Average_cost_for_two BETWEEN 601 AND 900 THEN '₹601–900'
        WHEN Average_cost_for_two BETWEEN 901 AND 1200 THEN '₹901–1200'
        WHEN Average_cost_for_two > 1200 THEN '₹1200+'
        ELSE 'Unknown'
    END
ORDER BY 
    Avg_Rating DESC;

-- Is rating variance lower at high-end restaurants?

SELECT 
    Restaurant_price_range,
    COUNT(*) AS Total_Restaurants,
    AVG(CAST(Restaurants_aggregate_rating AS FLOAT)) AS Average_Rating,
    STDEV(CAST(Restaurants_aggregate_rating AS FLOAT)) AS Rating_Std_Deviation
FROM 
    dbo.Zomato_data
WHERE 
    Restaurants_aggregate_rating > 0 AND Average_cost_for_two > 0
GROUP BY 
    Restaurant_price_range
ORDER BY 
    Restaurant_price_range ASC;

--What’s the correlation between cost and rating?

SELECT 
    CAST(Restaurants_aggregate_rating AS FLOAT) AS Rating,
    CAST(Average_cost_for_two AS FLOAT) AS Cost
FROM dbo.Zomato_data
WHERE 
    Restaurants_aggregate_rating > 0 AND Average_cost_for_two > 0;




    




















