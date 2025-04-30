select
    sequence_number,
    flow_published_at,
    id,
    ts,
    status,
    source,
    country
from
    {{ ref('order_json_flattening') }}
where
    partition_key = 'sales_v1_order_returned'
