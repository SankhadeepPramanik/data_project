{% macro scd2(table_name, unique_columns, timestamp_column) %}
    {# Check if 'unique_columns' is a list. If not, wrap it in a list. #}
    {%- set is_list = unique_columns is iterable and unique_columns is not string -%}
    {%- set unique_columns = unique_columns if is_list else [unique_columns] -%}
    {%- set partition_by_key = unique_columns | join(', ') -%}

    {% set column_names = adapter.get_columns_in_relation(ref(table_name)) %}

    with ranked as (
        select *,
            dense_rank() over (partition by {{ partition_by_key }} order by {{ timestamp_column }} desc) as rnk,
            lead({{ timestamp_column }}) over (partition by {{ partition_by_key }} order by {{ timestamp_column }}) as next_valid_from
        from {{ ref(table_name) }}
    ),
    records as (
        select *,
            case 
                when rnk = 1 then 'current'
                else 'expired'
            end as record_status,
            {{ timestamp_column }} as valid_from,
            case
                when rnk = 1 then NULL
                else next_valid_from - INTERVAL '1 SECOND'
            end as valid_to
        from ranked
    ),
    final as (
        select
            *,
            -- Ensure consistency for records with the same valid_from
            max(valid_to) over (partition by {{ partition_by_key }}, valid_from) as consistent_valid_to
        from records
    )

    select
        {% for column in column_names %}
            {{ column.name }}
            {% if not loop.last %},{% endif %}
        {% endfor %},
        record_status,
        valid_from,
        consistent_valid_to as valid_to
    from final
    order by {{ timestamp_column }}
{% endmacro %}
