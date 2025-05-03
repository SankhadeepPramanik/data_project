{
    config(
        materialized='incremental',
        unique_key='order_payment_id',
        incremental_strategy='delete+insert',
        on_schema_change='append_new_columns',
    )
}

select 
order_updated_timestamp,
order_id,
return_id,
order_country,
status,
payments_id,
payments_type,
payments_card_type,
payments_value,
order_sequence_number
from {{ ref('order_payments') }}
