with cte as 
(    
    SELECT 
        LEFT(r.dateScanned, 7) as scanned_month,
        sb.brandcode as brandcode,
        count(receipts_items_key) as scanned_times
    FROM {{ ref('stg_receipts_items') }} ri
    LEFT JOIN {{ ref('stg_receipts') }} r
        on ri.receipt_id = r.id
    JOIN {{ ref('stg_brands') }} sb
        on ri.brandcode = sb.brandcode
    GROUP BY LEFT(r.dateScanned, 7),sb.brandcode
    order by scanned_month asc,scanned_times desc
    ),
 
cte_rank as 
(
    SELECT *,
    dense_rank() over (partition by scanned_month order by scanned_times desc) as rnk
 FROM cte
)

SELECT  
scanned_month, brandcode,scanned_times
FROM cte_rank
where rnk <=5