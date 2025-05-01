select
    sequence_number,
    flow_published_at as order_updated_timestamp,
    id as order_id,
    ts,
    coalesce(status, 'shipped'::varchar) as status,
    source,
    country,
    fulfillment_shipping_address_address_address_line1 as shipping_address,
    fulfillment_shipping_address_address_address_line2 as shipping_address2,
    fulfillment_shipping_address_address_city as shipping_city,
    fulfillment_shipping_address_address_region as shipping_region,
    fulfillment_shipping_address_address_postal_code as shipping_postal_code,
    fulfillment_shipping_address_address_country as shipping_country,
    fulfillment_shipping_address_name_family as shipping_family_name
from
    {{ ref('order_json_flattening') }}
where
    partition_key = 'sales_v1_order_shipped'
