# Project background

Superstore Sales Inc. is a global e-commerce and logistics aggregator. The company manages a vast catalog ranging from Furniture to Technology across four major international regions.

While the 2014–2017 period showed strong top-line sales growth, the company faced a "Profitability Paradox". Aggressive market expansion led to several critical pain points:

**Profitability Leaks**: High-volume transactions frequently resulted in significant negative profit. Management needed to determine if this was caused by excessive discounting.

**Return Friction**: High return rates in specific categories, particularly Furniture, were effectively neutralizing the margins earned in high-performing categories.

**Regional Inconsistency**: Performance varied significantly across regions, requiring a deep dive into regional management effectiveness and discount strategies.

Reporting to the Director of FP&A, the ultimate goal of this project is to provide leadership with a clear roadmap for Profit Recovery, transforming raw transactional data from 2014–2017 into actionable strategies for future fiscal cycles.

-- A SQL file of ETL / EDA to surface insights can be reviewed [here](https://github.com/wadeallen3030-dotcom/Superstore-Sales/blob/main/superstore_sale_sql.sql)

-- A interactive Power BI dashboard can be downloaded [here](https://github.com/wadeallen3030-dotcom/Superstore-Sales/blob/main/Superstore_sales.pbix)

# Executive Summary

<img width="1300" height="621" alt="image" src="https://github.com/user-attachments/assets/49ede83d-3bd9-4c71-9eae-81548a5ad541" />

After taking a look at the data, it seems we reached a total of 5009 orders, %2.48M revenue with $309K profit. Revenue tends to increase after the middle of the year for every year that could have something to with promotion or other events.
Profit does not have significant increase when revenue goes up, indicating the discount strategy could be damaging real profit that it needs to pivot, specifically in Central region where most products are losing profit.. Among all the subcategories, Binders is losing the most proift with $43K, followed by tables with $35K and machines with 32K. If the general discount tier could lower by 15%, we could recover around 120K profit.

# Profit Leaking and Adjustments 

<table style="width: 100%; border-collapse: collapse;">
  <tr>
    <td align="center" width="33%">
      <img src="https://github.com/user-attachments/assets/b2180a98-9efa-4f54-bed8-fc179984faae" width="100%" />
    </td>
    <td align="center" width="33%">
      <img src="https://github.com/user-attachments/assets/6d464a43-94a4-40c3-a50f-f9d80c350dad" width="100%" />
    </td>
    <td align="center" width="33%">
      <img src="https://github.com/user-attachments/assets/d81c5230-19f5-4b89-a223-d28135c1cb4d" width="100%" />
    </td>
  </tr>
</table>

- Products with over 40% discount are losing more profit, among all binders is losing $43K, tables is losing $35K and machines is losing $32K.
- By changing the discount tier, we can start to see profit increasement. If we lower the discount tier to all products that are losing profit by 15%, we can recover around $124K profit.
- Profit margin reached its peak at the begining of 2017 with 21%. This needs to be further looked into of what different strategy was taken in that time.

# Refund Insights

<img width="1301" height="592" alt="image" src="https://github.com/user-attachments/assets/4a5c1a4e-a29f-4b46-be6e-92515d6e0e4b" />

- Overall the company had 296 orders refunded with $361K revenue lost that stands about 14.5% of the revenue.
- While office supplies are being refunded the most in volume (234 orders), it is technology that's losing the most revenue ($145K).
- 64% of the refunds happened in West region while 56% of them are shipped by standard class.
- Orders that take longer than 4 days to ship have a higher chance of being refunded.

# Region Insights

<p align="center">
  <img src="https://github.com/user-attachments/assets/739adc04-48e8-43e9-8926-a41c9dd6c6cf" height="300" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/ad4ee422-373e-4790-94e9-ff95ca40b170" height="300" />
</p>

- Central Region has the second lowest revenue ($510K) and the lowet profit margin (7%) which is performing the worst.
- Most produts in Central region are losing profit with furnishings category losing the most ($4K profit with -25% profit marging).
- San Antonio and Houston are the 2 main cities that are losing the most profit in Central region with $11K and $10K respectively.

# Recommendations

- To counter the profitability leak, it's recommended that the general discount tier should be lowerd by 15% for products that are losing profit, which could recover around $124K profit.
- The shipping process and quality assurance to Central Region with Standard class needs to be investigated as this where the most refunds are taking place, specifically in technology category as it's losing most revenue.
- The general strategy in Central region needs to be revisted since most products are losing profits with low revenue, specifically in San Antorio and Houston city.



