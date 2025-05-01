with scd2 as
(
    {{
        scd2(
            'order_placed_payments',
            ['order_id'],
            'order_updated_timestamp',
        )
    }}
)
select * from scd2