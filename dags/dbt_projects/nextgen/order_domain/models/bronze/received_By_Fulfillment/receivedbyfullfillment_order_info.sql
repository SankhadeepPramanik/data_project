
select 
    sequence_number,
    id,
    order_info_account_classification,
    order_info_country,
    order_info_category,
    order_info_channel,
    order_info_created_by,
    order_info_created_time,
    order_info_effective_order_date,
    order_info_gift_receipt,
    order_info_location_id,
    order_info_location_name,
    order_info_market,
    order_info_order_comments,
    order_info_order_date,
    order_info_created_time,
    order_info_order_type,
    order_info_price_date,
    order_info_subscription_id,
    reason_code,
    reason_message

from
{{ref('order_json_flattening')}}
where
    partition_key = 'sales_v1_order_receivedByFulfillment'  or meta_partition_key = 'receivedByFulfillment'
