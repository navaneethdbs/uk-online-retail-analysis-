# UK Online Retail Analysis

## Project Overview
An end-to-end data analysis project on a UK-based online retail dataset covering 2010-2011 transactions. The project involves Python data cleaning, MySQL RFM customer segmentation, and an interactive Power BI dashboard.

## Architecture
## Tools & Technologies
- **Python** — data cleaning and transformation (Pandas)
- **MySQL** — RFM segmentation and customer analysis queries
- **Power BI** — interactive sales and customer intelligence dashboard

## Dataset
- Source: UCI Machine Learning Repository
- Period: 2010–2011
- Size: 500,000+ transactions
- Coverage: 38 countries

## Key Findings
1. **UK dominates revenue** at 83% of total — significant geographic concentration risk
2. **Champions segment** — top customers buy frequently, recently, and spend the most
3. **At Risk customers** — previously loyal customers showing declining engagement
4. **Seasonal revenue spike** in October–November driven by Christmas wholesale buying
5. **Strong customer diversification** — no single customer exceeds 3% of total revenue

## Dashboard Pages
- **Page 1** — Sales Overview (revenue, orders, top products)
- **Page 2** — Customer Segmentation (RFM analysis, segment distribution)
- **Page 3** — Geographic Analysis (revenue by country, UK concentration)

## RFM Segmentation
| Segment | Description |
|---|---|
| Champion | Bought recently, buy often, spend the most |
| Loyal Customer | Buy regularly with good frequency |
| Potential Loyalist | Recent buyers with average frequency |
| At Risk | High past value but not buying recently |
| Lost | Lowest scores — inactive customers |

## Files
- `Uk online reatil project.ipynb` — Python data cleaning notebook
- `online_retail_clean.csv` — cleaned and processed dataset
- `RFM_results.csv` — RFM scores and customer segments
- `online_retail_dashboard.pbix` — Power BI dashboard file
- `rfm_analysis.sql` — MySQL RFM segmentation queries

## Author
Navaneeth Aravindakshan — Data Analyst
