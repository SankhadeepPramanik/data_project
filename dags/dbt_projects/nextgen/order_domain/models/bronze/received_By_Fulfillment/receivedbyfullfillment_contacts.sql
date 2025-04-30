select 
    sequence_number,
    id,
    c.VALUE:"type"::string as contact_type,
    c.value:"value":: string as contact_value

from {{ref('order_json_flattening')}} oc,
lateral flatten(input => oc.ORDER_DETAILS_FULFILLMENT_SHIPPING_ADDRESS_CONTACT ) c
where
    partition_key = 'sales_v1_order_receivedByFulfillment' or meta_partition_key = 'receivedByFulfillment'
