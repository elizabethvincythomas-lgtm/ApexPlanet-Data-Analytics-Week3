# Build the Week 3 Interactive Dashboard

## Step 1 - Import data

1. Open Power BI Desktop.
2. Select **Get data** > **Text/CSV**.
3. Choose `data/processed/cleaned_sales_dataset_sql.csv`.
4. Select **Load**.
5. In the Fields panel, right-click the table and rename it to `Sales`.

## Step 2 - Create the five KPI measures

Select the `Sales` table. Choose **New measure** and create these one at a time:

```
Total Revenue = SUM(Sales[Total_Sales])
Transactions = COUNTROWS(Sales)
Unique Customers = DISTINCTCOUNT(Sales[Customer_ID])
Average Order Value = DIVIDE([Total Revenue], [Transactions])
Units Sold = SUM(Sales[Quantity])
```

## Step 3 - Create the customer segment column

Choose **New column** and create these separately:

```
Customer Revenue = CALCULATE(SUM(Sales[Total_Sales]), ALLEXCEPT(Sales, Sales[Customer_ID]))
```

Then choose **New column** again and paste:

```
Customer Segment =
SWITCH(TRUE(),
    Sales[Customer Revenue] >= 250000, "High Value",
    Sales[Customer Revenue] >= 100000, "Medium Value",
    "Low Value")
```

## Step 4 - Build Page 1: Executive Overview

Add five **Card** visuals using: Total Revenue, Transactions, Unique Customers, Average Order Value, and Units Sold.

Add these visuals:

| Visual | Field placement |
|---|---|
| Line chart | X-axis: `Order_Month_Name`; Y-axis: Total Revenue |
| Clustered bar chart | Y-axis: `Category`; X-axis: Total Revenue |
| Clustered bar chart | Y-axis: `City`; X-axis: Total Revenue |
| Slicers | `City`, `Category`, `Age_Group`, `Order_Month_Name` |

Sort `Order_Month_Name` by `Order_Month` before using it in the line chart.

## Step 5 - Build Page 2: Customer Segmentation

Add these visuals:

| Visual | Field placement |
|---|---|
| Donut chart | Legend: `Customer Segment`; Values: Total Revenue |
| Clustered column chart | X-axis: `Customer Segment`; Y-axis: Unique Customers |
| Bar chart | Y-axis: `City`; X-axis: Total Revenue; Legend: `Customer Segment` |
| Bar chart | Y-axis: `Age_Group`; X-axis: Total Revenue; Legend: `Customer Segment` |
| Table | `Customer_ID`, `Customer_Name`, `City`, `Customer Segment`, Total Revenue |
| Slicers | `City`, `Category`, `Age_Group`, `Customer Segment` |

## Step 6 - Final output

1. Save the report as `Elizabeth_Vincy_Thomas_Week3_Customer_Segmentation.pbix` inside the `reports` folder.
2. Take screenshots of both report pages and save them under `reports/screenshots`.
3. Add the `.pbix` file, screenshots, SQL file, report, and README to GitHub.
4. Record a 5-7 minute LinkedIn video demonstrating filters and key findings.
