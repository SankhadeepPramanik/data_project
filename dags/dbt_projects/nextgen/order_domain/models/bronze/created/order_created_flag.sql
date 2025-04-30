select 
    sequence_number,
    id,
    f.VALUE:"type"::string as flag_type,
    f.value:"value":: boolean as flag_value

from {{ref('order_json_flattening')}} oc,
lateral flatten(input => oc.order_details_flags ) f
where
    partition_key = 'sales_v1_order_created'
