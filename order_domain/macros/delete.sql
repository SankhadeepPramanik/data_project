

{% macro delete1(source,target,Primary_key,timestamp_column) %}

DELETE FROM {{ target }} 
where {{ Primary_key }} in ( select distinct {{ Primary_key }} from {{ source }} 
where {{timestamp_column}} > (select max({{timestamp_column}}) from {{target}}) )

{% endmacro %}