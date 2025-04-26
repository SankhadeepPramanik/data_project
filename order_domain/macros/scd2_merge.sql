{% macro scd_type2(source_table,target_table,pk_columns,timestamp_column,is_incremental) %}

{% set pk_condition=[] %}
{% for col in pk_columns %}
    {% do pk_condition.append('source.' ~ col ~ ' = ' ~ 'target.' ~ col) %}
{% endfor %}

{% set scd_columns=[] %}
{% for col in pk_columns %}
    {% do scd_columns.append(col) %}
{% endfor %}

{% set scd_Pkcolumns=','.join(scd_columns) %}
{% set scd_columns=' || '.join(scd_columns) %}

{% set pk_columns=','.join(pk_columns) %}

{% set pk_condition=' and '.join(pk_condition) %}

select {{ get_column_names( source_table) }},

    to_hex(md5(
        coalesce(cast({{scd_columns}} AS VARCHAR), '') || '|' || 
        coalesce(cast(current_timestamp AS VARCHAR), '') || '|' || 
        cast(row_number() OVER (PARTITION BY {{scd_Pkcolumns}} ORDER BY {{timestamp_column}}) AS VARCHAR)
    )) AS dbt_scd_id,


        record_status, valid_from, valid_to
from {{ref(source_table)}}
{% if is_incremental %}
where {{timestamp_column}} > (select max({{ timestamp_column }}) from {{target_table}})

Union all
select {{ get_column_names(source_table,'target') }}, dbt_scd_id, 'expired' as record_status, valid_from,
source.{{ timestamp_column }} as valid_to
from  {{target_table}}  target
join (select {{pk_columns}},min({{ timestamp_column }}) as {{ timestamp_column }}  from {{ref(source_table)}}
{% if is_incremental %}
where {{timestamp_column}} > (select max({{ timestamp_column }}) from {{target_table}}) 
{% endif %}
group by {{pk_columns}} ) source 
on {{pk_condition}}
where target.valid_to is null and target.{{ timestamp_column }} < source.{{ timestamp_column }}
{% endif %}

{% endmacro %}
