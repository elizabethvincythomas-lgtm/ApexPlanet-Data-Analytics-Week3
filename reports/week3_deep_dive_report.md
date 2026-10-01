# Week 3 - Customer Segmentation & Interactive Dashboarding

**Prepared by:** Elizabeth Vincy Thomas  
**Tools:** SQL Server Management Studio, T-SQL, Power BI Desktop

## Business question

Which customer segments contribute the most value, and how can city, age group, and product performance guide sales actions?

## Segmentation rule

Customers are grouped using their total revenue across all recorded transactions.

| Segment | Rule |
|---|---|
| High Value | Customer revenue is 250,000 or more |
| Medium Value | Customer revenue is 100,000 to below 250,000 |
| Low Value | Customer revenue is below 100,000 |

## Core KPIs

| KPI | Definition |
|---|---|
| Total Revenue | Sum of `Total_Sales` |
| Transactions | Number of transaction rows |
| Unique Customers | Distinct `Customer_ID` values |
| Average Order Value | Total Revenue divided by Transactions |
| Units Sold | Sum of `Quantity` |

## Segmentation findings

| Segment | Customers | Revenue | Revenue share | Average customer value |
|---|---:|---:|---:|---:|
| High Value | 176 | 62,917,632.16 | 45.13% | 357,486.55 |
| Medium Value | 346 | 56,734,723.96 | 40.70% | 163,973.19 |
| Low Value | 425 | 19,747,083.53 | 14.17% | 46,463.73 |

## Insights

1. High Value customers are only 18.6% of customers, but generate 45.13% of total revenue. Retention and loyalty actions should prioritize this group.
2. Medium Value customers generate 40.70% of revenue and represent the strongest upgrade opportunity. Product bundles and personalized recommendations can move them into the High Value group.
3. Low Value customers are the largest group by count but contribute only 14.17% of revenue. Use cost-effective digital campaigns rather than expensive one-to-one outreach.
4. The Power BI dashboard should allow users to filter the above segments by city, product category, age group, and month.

## Recommended dashboard pages

1. **Executive Overview:** KPI cards, monthly revenue trend, category revenue, city revenue.
2. **Customer Segmentation:** revenue by segment, customer count by segment, top high-value customers, segment breakdown by city and age group.

## Recommendation

Allocate retention effort to High Value customers, create upgrade campaigns for Medium Value customers, and use scalable promotions for Low Value customers. Monitor results with the Power BI dashboard after applying city, category, and age-group filters.
