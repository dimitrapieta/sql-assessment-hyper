-- Task 1: Count of customers per segment
select 
  rfm_segment, 
  count(*) as customer_count
from final
group by rfm_segment
order by customer_count desc
;

-- Task 2: Total revenue per segment
select 
  rfm_segment, 
  sum(total_revenue_per_cust) as total_revenue
from final
group by rfm_segment
order by total_revenue desc
;

-- Task 3: Top 5 customers by RFM score
select 
  o_custkey, 
  customer_name, 
  rfm_score, 
  rfm_segment
from final
order by rfm_score desc
limit 5
;

-- Task 4: Nations with most Champions
select 
  nation, 
  count(*) as customer_count
from final
where rfm_segment = 'Champions'
group by nation
order by customer_count desc
;
