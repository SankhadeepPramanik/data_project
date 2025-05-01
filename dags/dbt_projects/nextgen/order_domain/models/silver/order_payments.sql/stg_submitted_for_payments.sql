
with deduplicated_cte as (
    {{
        deduplicate(
            relation=ref('stg_submitted_for_payments_with_duplicate'),
            partition_by='order_id,status,order_country,payments_id,payments_card_type,payments_type,payments_value',
            order_by='order_updated_timestamp desc, order_sequence_number desc',
        )
    }}
)

select * from deduplicated_cte
