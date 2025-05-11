{{ config(
        materialized='incremental',
        on_schema_change='append_new_columns',
        unique_key='order_id',
        incremental_strategy='merge',
        post_hook=['INSERT INTO {{ source("order_log","audit_log_order")}} (updated_ts, max_timestamp, record_count, status, table_name) SELECT current_timestamp, max(order_updated_timestamp), count(*), \'success\', \'{{this}}\' FROM {{ this }}'],
        tags=["order_header_table","order_table","order_scd2_table","order_header_scd2_table"]
    ) }}



select 
*

 from  (
{{ scd_type2('order_header_history'
    ,target_table=this
    ,pk_columns=["order_id"]
    ,timestamp_column='order_updated_timestamp'
    ,is_incremental=is_incremental()
    )
}}
 )