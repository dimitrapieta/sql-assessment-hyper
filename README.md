# Customer Segmentation with RFM Analysis

## 📍 Overview
This project was developed as part of Hyper Island’s SQL course. It applies advanced SQL techniques to perform **RFM (Recency, Frequency, Monetary)** analysis on retail transaction data using Snowflake’s TPCH sample dataset. The goal is to segment customers based on purchasing behavior and generate actionable insights for marketing and retention strategies.

## 🎯 Objectives
- Identify high-value customers based on order recency, frequency, and spend
- Understand customer ordering patterns across nations and segments
- Support marketing decisions with data-driven segmentation and recommendations

## 🛠️ Tools & Techniques
- **Database:** `SNOWFLAKE_SAMPLE_DATA.TPCH_SF1`
- **SQL Features Used:**
  - Common Table Expressions (CTEs)
  - Window functions (`percent_rank`, `lag`)
  - Aggregate functions (`sum`, `avg`, `count`)
  - Conditional logic (`CASE`)
- **Scoring Logic:**
  - Recency: Days since last order
  - Frequency: Average days between orders
  - Monetary: Total spend
  - Weighted RFM Score: `0.2 * Recency + 0.4 * Frequency + 0.4 * Monetary`

## 📊 Segmentation Strategy
Customers were grouped into five segments based on their RFM score:
- **Champions:** Recent, frequent, high spenders
- **Loyal:** Frequent buyers with solid spend
- **Potential:** Occasional buyers with moderate value
- **At-Risk:** Declining engagement but decent spend
- **Dormant:** Low activity and low spend

## 📈 Key Insights
- **Dormant** segment is the largest, with 29,999 customers
- **Loyal** segment generates the most total revenue
- **Champions** have the highest average order value
- **China** has the highest number of Champions

## 📂 Repository Structure
│
├── README.md # Project overview and insights
├── sql/
│ ├── rfm_analysis.sql # Full RFM pipeline and segmentation logic
│ ├── segment_exploration.sql # Queries for segment counts, revenue, top customers, nations
│
├── insights/
│ └── written_analysis.md # Business reflections and strategic recommendations
│
├── assets/
│ └── top_customers.png # Screenshot of top 10 customers by RFM score


## 🚀 How to Run
1. Open Snowflake and connect to the TPCH sample data.
2. Run `sql/rfm_analysis.sql` to generate the full customer segmentation.
3. Replace the final `SELECT * FROM final` with queries from `segment_exploration.sql` to explore specific insights.

## 🧠 Learning Outcomes
- Built complex SQL queries using CTEs and window functions
- Normalized customer scores using percentile ranking
- Connected technical outputs to business strategy and marketing actions
