{{ config(
        materialized='incremental',
        twin_strategy="allow",
        on_schema_change='append_new_columns',
        table_type='iceberg',
        unique_key='dbt_scd_id',
        incremental_strategy='merge',
        post_hook=['INSERT INTO {{ source("order_log","audit_log_order")}} (updated_ts, max_timestamp, record_count, status, table_name) SELECT current_timestamp, max(latest_timestamp), count(*), \'success\', \'{{this}}\' FROM {{ this }}',
        'update  {{ source("order_silver","order_cntl_tbl") }} set "latest_max_ts" = (select max(latest_timestamp) from {{this}} ) where "table_name" = \'order_payment\''],
        tags=["order_header_table","order_table","order_scd2_table","order_header_scd2_table"]
    ) }}