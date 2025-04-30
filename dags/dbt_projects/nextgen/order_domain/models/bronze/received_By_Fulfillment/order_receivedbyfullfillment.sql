select
    sequence_number,
    flow_published_at,
    id,
    ts,
    coalesce(status, 'received_By_Fulfillment'::varchar) as status,
    source,
    country,
    order_details_fulfillment_shipping_address_address_address_line1 as shipping_address_line1,
    order_details_fulfillment_shipping_address_address_address_line2 as shipping_address_line2,    
    order_details_fulfillment_shipping_address_address_address_line3 as shipping_address_line3,
    order_details_fulfillment_shipping_address_address_city as shipping_city,
    order_details_fulfillment_shipping_address_address_district as shipping_district,
    order_details_fulfillment_shipping_address_address_postal_code as shipping_postal_code,
    order_details_fulfillment_shipping_address_address_country as shipping_country,
    order_details_fulfillment_shipping_address_address_region as shipping_region,
    order_details_fulfillment_shipping_address_name_family as shipping_family_name
from
    {{ ref('order_json_flattening') }}
where
    partition_key = 'sales_v1_order_receivedByFulfillment' or meta_partition_key = 'receivedByFulfillment'
