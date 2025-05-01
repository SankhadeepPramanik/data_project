select
    sequence_number,
    flow_published_at as order_updated_timestamp,
    id as order_id,
    invoice_id,
    ts,
    coalesce(status, 'invoiced'::varchar) as status,
    source,
    country
from
    {{ ref('order_json_flattening') }}
where
    partition_key = 'sales_v1_order_invoiced'
