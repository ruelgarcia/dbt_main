{{ config(materialized='incremental', on_schema_change='fail') }}

with cte_src_reviews as (select * from {{ ref('src_reviews') }})

select
    {{
        dbt_utils.surrogate_key(
            ['listing_id', 'review_date', 'reviewer_name', 'review_text']
        )
    }} as review_id
    , *
from cte_src_reviews
where
    review_text is not null
    {% if is_incremental() %}
    and review_date > (select max(review_date) from {{ this }})
    {% endif %}
