select 
    sequence_number,
    id,
    p.VALUE:"type"::string as parties_type,
    p.value:"id":: string as parties_id

from {{ref('order_json_flattening')}} oc,
lateral flatten(input => oc.return_details_parties ) p
where
    partition_key = 'sales_v1_order_returnSubmitted' 