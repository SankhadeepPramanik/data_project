with deduplicated_cte as (
    {{
        deduplicate(
            relation=ref('stg_header_created_with_duplicate'),
            partition_by='order_id',
            order_by='order_updated_timestamp desc, sequence_number desc',
        )
    }}
)

select * from deduplicated_cte
