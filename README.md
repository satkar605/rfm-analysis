# RFM Analysis – AdventureWorks Customer Segmentation (France Focus)

## Project Overview
This project performs RFM (Recency, Frequency, Monetary) analysis using transactional data from the AdventureWorks2022 SQL Server database. The focus is on customers based in France, with the objective of identifying high-value customers to support customer relationship management (CRM) initiatives.

## Objective
To create a data-driven customer segmentation framework that allows for targeted marketing strategies based on historical purchasing behavior. The analysis identifies which customers are most engaged, most recent, and most profitable to the business.

## Tools Used
- **SQL Server Management Studio (SSMS)** – Used to extract, clean, and aggregate customer and sales data.
- **T-SQL** – Performed complex joins and grouped queries to calculate the raw RFM metrics.
- **Microsoft Excel** – Used for transforming continuous RFM values into scores (1–5) using `PERCENTRANK.EXC`, final scoring, and basic visualization.

## Methodology
1. **Data Extraction**
   - Joined `Customer`, `Person`, `Address`, `SalesOrderHeader`, and related location tables.
   - Filtered customers located in France.
2. **Metric Calculation**
   - **Recency**: Last order date per customer (`MAX(OrderDate)`)
   - **Frequency**: Number of orders placed (`COUNT(SalesOrderID)`)
   - **Monetary**: Total billed amount (`SUM(TotalDue)`)
3. **Export & Scoring**
   - Exported aggregated data to Excel.
   - Assigned RFM scores using equal-frequency binning via `PERCENTRANK.EXC()`.
   - Concatenated scores to generate a final three-digit RFM Score (e.g., 555).
4. **Segmentation**
   - Sorted customers by RFM score.
   - Identified the top-tier customers and potential re-engagement opportunities.

## Key Insights
- Customers with an RFM score of **555** are the most engaged and highest spenders — ideal candidates for loyalty and retention programs.
- Recency scoring helped reveal lapsed customers who might benefit from reactivation campaigns.
- This methodology can be replicated and scaled across different countries or regions within the AdventureWorks dataset.

## Files Included
- `rfm_analysis_france.sql` – Full SQL script used to extract and prepare data.
- `rfm_analysis_output.xlsx` – Excel file containing final RFM scores, sorted list, and raw metrics.

## Potential Extensions
- Add clustering (e.g., K-Means) to group customers into personas based on RFM vectors.
- Build interactive visual dashboards using Power BI or Tableau.
- Automate RFM scoring pipeline using Python (Pandas + SQL connector).

## Author
**Satkar Karki**  
MS in Business Analytics  
GitHub: [your username] | LinkedIn: [your link] | Portfolio: [your site]
