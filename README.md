# ApexPlanet Data Analytics - Week 3

## Deep-Dive Analysis & Interactive Dashboarding

**Prepared by:** Elizabeth Vincy Thomas

This project conducts a SQL-based customer-segmentation deep dive and builds an interactive Power BI dashboard for sales performance analysis.

## Contents

- `data/processed/cleaned_sales_dataset_sql.csv` - cleaned transaction data
- `sql/week3_customer_segmentation.sql` - T-SQL KPI and segmentation analysis
- `powerbi/dax_measures.txt` - DAX measures for the dashboard
- `reports/week3_deep_dive_report.md` - findings and recommendations
- `reports/` - add dashboard screenshots after creating the Power BI report

## Project outcome

The dashboard answers these questions:

1. Which customer segment contributes the most revenue?
2. Which cities, categories, and age groups contain the most valuable customers?
3. Which customers should receive retention, upgrade, or scalable promotional campaigns?

## Customer segmentation rules

- High Value: revenue of 250,000 or more
- Medium Value: revenue from 100,000 to below 250,000
- Low Value: revenue below 100,000

## Tools

- Microsoft SQL Server Express
- SQL Server Management Studio
- Power BI Desktop
- T-SQL and DAX
