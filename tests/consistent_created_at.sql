WITH cte_fct_reviews AS(

    SELECT * FROM {{source('airbnb_dev','fct_reviews')}}
)

SELECT * FROM {{ ref('dim_listings_cleansed') }} l
INNER JOIN cte_fct_reviews r
    ON l.listing_id = r.listing_id
WHERE l.created_at >= r.review_date