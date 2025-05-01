with cte as (
    select order_id,sequence_number,country,source,order_updated_timestamp,status from {{ref('stg_header_created')}}
    union all
    select order_id,sequence_number,country,source,order_updated_timestamp,status from {{ref('stg_header_submitted_for')}}
    union all
    select order_id,sequence_number,country,source,order_updated_timestamp,status from {{ref('stg_header_received_by')}}
    union all
    select order_id,sequence_number,country,source,order_updated_timestamp,status from {{ref('stg_header_shipped')}}
    union all
    select order_id,sequence_number,country,source,order_updated_timestamp,status from {{ref('stg_header_invoiced')}}
    union all
    select order_id,sequence_number,country,source,order_updated_timestamp,status from {{ref('stg_header_manifested')}}
    union all       
    select order_id,sequence_number,country,source,order_updated_timestamp,status from {{ref('stg_header_cancelled')}}

)

select * from cte
