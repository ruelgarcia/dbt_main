{{
    config(materialized = 'view')
}}

WITH cte_src_hosts AS (
    SELECT 
    host_id
    ,NVL(host_name,'Anonymous') AS host_name
    ,is_superhost
    ,created_at
    ,updated_at
    FROM {{ref('src_hosts')}}
)
SELECT
*
FROM cte_src_hosts
