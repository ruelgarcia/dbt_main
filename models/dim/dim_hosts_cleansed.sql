{{ config(materialized="view") }}

with
    cte_src_hosts as (
        select
            host_id,
            nvl(host_name, 'Anonymous') as host_name,
            is_superhost,
            created_at,
            updated_at
        from {{ ref("src_hosts") }}
    )
select *
from cte_src_hosts
