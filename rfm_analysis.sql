/* For this case, I have decided to only include customers that have placed orders in the past, and to exclude customers with no orders. This ensures the RFM analysis is based on actual purchasing behavior and allows for a more sensitive RFM score distribution. Therefore, the customers with no orders are just treated as leads/prospects and not actual customers. The use of inner join was therefore chosen just on personal preference as there is no data that will be excluded since I am joining from ORDERS to CUSTOMERS. */

with customer_details as (
    select
        o.o_custkey,
        c.c_name as customer_name,
        n_name as nation,
        max(o.o_orderdate) as last_order_date,
        sum(o.o_totalprice) as total_revenue_per_cust,
        count(o.o_orderkey) as total_nr_of_orders,
        round(avg(o_totalprice), 2) as avg_order_value_per_cust
    from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS as o
    inner join SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.CUSTOMER as c
        on o.o_custkey = c.c_custkey -- Only include customers with orders.
    inner join SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.NATION as n
        on c.c_nationkey = n.n_nationkey
    group by o.o_custkey, c.c_name, c.c_nationkey, n.n_name
    order by o.o_custkey
),

max_date as ( -- Used to define the current date for recency calculation.
 select
 max(o_orderdate) as max_order_date
 from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS
),

 recency_value as (
     select 
        *,
        datediff(day, last_order_date, '1998-08-02') as recency -- find days since last order.
    from customer_details
),

days_between_orders as (
    select
        o_custkey,
        o_orderdate,
        datediff(day, lag(o_orderdate) over(partition by o_custkey order by o_orderdate), o_orderdate) as days_between_orders -- Average time between orders used for frequency.
    from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS
    order by o_custkey
),

frequency_value as (
    select
        o_custkey,
        round(avg(days_between_orders), 0) as frequency -- find how often a customer orders on average.
    from days_between_orders
    group by o_custkey
    order by o_custkey
),

monetary_value as (
    select
        o_custkey,
        sum(o_totalprice) as monetary -- find the total monetary value of a customer.
    from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.ORDERS
    group by o_custkey
    order by o_custkey
),

rfm_values as (
    select
        rv.*,
        fv.frequency,
        mv.monetary
    from recency_value as rv
    inner join frequency_value as fv
        on rv.o_custkey = fv.o_custkey
    inner join monetary_value as mv
        on fv.o_custkey = mv.o_custkey
),

rfm_percent as ( -- Percentile ranking used to normalize scores across customers.
    select 
        *,
       percent_rank() over(order by recency desc) AS recency_score, -- inverting the order by in recency so the ranking ranks customers with lower day values higher up instead.
       percent_rank() over(order by frequency desc) AS frequency_score, -- inverting the order by in frequency so the ranking ranks customers with lower day values higher up instead.
       percent_rank() over(order by monetary) AS monetary_score
    from rfm_values
),

rfm_score as (
    select 
        *,
       (0.2 * recency_score) + (0.4 * frequency_score) + (0.4 * monetary_score) AS rfm_weights,
       percent_rank() over(order by (0.2 * recency_score) + (0.4 * frequency_score) + (0.4 * monetary_score)) AS rfm_score
    from rfm_percent
),

/* based these weights on business goals "RFM segmentation helps businesses target loyal, high-spending customers, identify at-risk customers, and prioritize engagement strategies." Therefore prioritized loyalty and high-spending instead of recency. */

final as (
    select
        *,
        case
            when rfm_score >= 0.90 then 'Champions' -- Recent, frequent, high spend
            when rfm_score >= 0.70 then 'Loyal' -- Frequent, moderate spend
            when rfm_score >= 0.50 then 'Potential' -- New or occasional buyers
            when rfm_score >= 0.30 then 'At-Risk' -- Infrequent, declining activity
            else 'Dormant' end as rfm_segment -- Not much activity
    from rfm_score
    order by rfm_score desc
)

select
    *
from final
order by rfm_score desc
limit 10
;
