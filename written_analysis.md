# Written Insights: RFM Segmentation


## Scoring Logic and Segmentation Strategy:

The RFM scoring I used was based on the case’s focus: helping the company identify and target loyal, high-spending customers. To reflect that goal, I assigned unequal weights to the three metrics, 20% to recency, 40% to frequency (which captures loyalty), and 40% to monetary value (which reflects spending). I used percent_rank() to score each customer from 0 to 1 based on how they compare to others in each category. For recency and frequency, I reversed the sort order so that more recent and frequent customers received higher scores. Then I calculated a weighted RFM score and ranked customers again to normalize the results. Finally, I grouped customers into segments like “Champions” and “Dormant” using five thresholds to make it easier to prioritize engagement and retention strategies.

## Key Driver of Customer Value:

I performed an additional analysis to see how these customer segments were distributed according to their RFM scores. Based on my analysis, it appears that the monetary value was the most significant factor in explaining customer behavior. When I reviewed the score distribution, I saw that high-value segments like “Champions” and “Loyal” consistently had high monetary scores, while “Dormant” and “At-Risk” customers were at the lower end. This clear separation suggests that spending behavior is a strong indicator of customer value. It also supports the distribution of weights for scoring used earlier at 40%, equal to frequency and higher than recency. While frequency reflects loyalty, monetary value more reliably distinguished top spenders from low-value customers, making it the most consistent predictor across segments.

## Segment Distribution and Customer Base Insights:

The distribution of customers across RFM segments shows that the company has a large number of low-engagement customers and a smaller group of high-value ones. The Dormant segment is the largest, indicating that most customers have low recency, frequency, and monetary scores. In contrast, the Loyal and Potential segments contribute the most revenue, suggesting that some customers make large purchases even if they are less active. Champions have the highest average order value and monetary scores, showing strong individual spending. At-Risk customers also display solid spending behavior despite declining engagement. Overall, the customer base is broad but uneven in value, with business impact concentrated in a few key segments.

## Strategic Recommendations for Marketing and Retention:

The company has many customers who are inactive. Most of them fall into the “Dormant” segment, which means they do not buy often, recently, or spend much. However, the “Loyal” and “Potential” segments bring in the most total revenue. This is because they include more customers who make large purchases, even if they do not buy frequently or recently. The “Champions” segment has the highest average order value and the highest monetary scores, showing that these customers spend the most per purchase. This means that while a small group of customers spends a lot individually, the company earns most of its revenue from larger segments with solid spending. This means that the company should focus on retaining high-spenders like the ‘Champions’ and re-engaging less active customers like ‘Loyal’ and ‘At-Risk’ customers. They may not be the most engaged right now, but they’ve shown strong spending behavior as seen in the previous analyses and are more likely to respond to targeted campaigns.

## Opportunities for Further Analysis:

It would be valuable and interesting to analyze which products or product categories are most popular within each RFM segment. This would help the company to tailor its marketing messages better, to tailor its product recommendations, and promotion strategies to match the interests of each segment. For example, if ‘Champions’ consistently purchase premium items, targeted campaigns can emphasize exclusivity and quality. If Dormant customers tend to buy entry-level products, reactivation efforts could focus on discounts or introductory bundles. This analysis could also be paired with the re-activation recommendations mentioned above.
