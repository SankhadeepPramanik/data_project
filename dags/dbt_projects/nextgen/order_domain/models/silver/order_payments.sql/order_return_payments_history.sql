with scd2 as
(
    {{
        scd2(
            'order_return_payments',
            ['order_id','return_id'],
            'order_updated_timestamp',
        )
    }}
)
select * from scd2