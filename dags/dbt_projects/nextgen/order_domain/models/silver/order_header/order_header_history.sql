with cte as (
    {{
        scd2(
            'order_header_union',
            'order_id',
            'order_updated_timestamp'
        )
    }}

)

select * from cte