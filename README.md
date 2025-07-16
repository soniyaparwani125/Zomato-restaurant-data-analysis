# Zomato-restaurant-data-analysis
A complete restaurant market analysis project using SQL and Power BI, showcasing data cleaning, advanced querying and dashboard storytelling for business decision-making.

## Project Overview:
This project is an end-to-end business data analysis of Zomato restaurant data, focusing on key market insights such as:

1. Restaurant distribution by city and cuisine
2. Customer rating trends
3. Pricing vs rating correlations
4. Service availability (online delivery & table booking)
5. Value-for-money hotspots and hidden gems

### Tools Used:
1. SQL Server (SSMS)
2. Power BI
3. Microsoft Office Excel
4. DAX
5. Data Cleaning in Power Query

### Dataset Link 
https://www.kaggle.com/datasets/shrutimehta/zomato-restaurants-data

### SQL Queries Link


#### Process Breakdown
1. Data Cleaning
Cleaned raw Zomato Kaggle Dataset from JSON → Power BI → SQL.

Removed duplicates, nulls, and irrelevant columns.

Standardized key fields: ratings, cost, services, cuisines, cities.

2. Data Analysis (SQL Highlights)
Explored average ratings by city, value-for-money scoring, price vs rating patterns.

Built advanced queries: joins with external city population data, rating consistency checks, service availability comparisons.

3. Dashboard Development (Power BI Highlights)
Attractive single-page dashboard layout

KPI cards: Total Restaurants, Avg Rating, Avg Cost, % Online Delivery, % Table Booking

Visuals: City breakdowns, Cuisine popularity, Rating spreads, Cost vs Rating trends

Service Insights: Delivery and Table Booking coverage

Hidden Gems table: High-rating, low-cost restaurants

### Final Dashboard Preview
<img width="1105" height="638" alt="Screenshot 2025-07-15 084446" src="https://github.com/user-attachments/assets/b7b35084-cc04-4d1b-9c1c-0159fbff454e" />


### Key Business Insights
1. North Indian and Chinese cuisines dominate, but cost-effectiveness varies city-wise.
2. Higher-priced restaurants show better average ratings but with diminishing returns beyond certain price points.
3. Some cities offer superior ratings at lower average costs (high value-for-money).
4. Online delivery is more prominent in metros, while table booking is concentrated in premium dining zones.
5. Identified 'hidden gems': affordable restaurants with elite ratings (4.5+).

### Future Improvements
1. Adding more time-series trends if date-wise data is available.
2. Expanding city-level analysis with external demographic datasets.
3. Experimenting with RLS (Row-Level Security) in Power BI for filtered dashboard views.





  


