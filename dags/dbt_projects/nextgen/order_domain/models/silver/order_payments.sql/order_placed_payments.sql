select  
order_id,
NuLL as return_id,
order_sequence_number,
order_country,
status,
order_updated_timestamp,
payments_id,
payments_type,
payments_card_type,
payments_value
from {{ ref('stg_created_payments') }}
union all 
select  
order_id,
NuLL as return_id,
order_sequence_number,
order_country,
status,
order_updated_timestamp,
payments_id,
payments_type,
payments_card_type,
payments_value
from {{ ref('stg_submitted_for_payments') }}
union all 
select  
order_id,
NuLL as return_id,
order_sequence_number,
order_country,
status,
order_updated_timestamp,
payments_id,
payments_type,
payments_card_type,
payments_value
from {{ ref('stg_received_by_payments') }}
