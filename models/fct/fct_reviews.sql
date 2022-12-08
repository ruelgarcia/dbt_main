{{
 config( materialized = 'incremental', on_schema_change='fail' )
}}

WITH cte_src_reviews AS (
 SELECT * FROM {{ ref('src_reviews') }}
)

SELECT * FROM cte_src_reviews
WHERE review_text is not null
{% if is_incremental() %}
 AND review_date > (select max(review_date) from {{ this }})
{% endif %}