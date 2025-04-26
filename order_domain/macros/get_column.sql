{% macro get_column_names(table_name,alias=none) %}

{% set all_cloumns = adapter.get_columns_in_relation(ref( table_name )) %}

{% set column_list=[] %}

{% if alias is none %}
    {% for col in all_cloumns %}
        {% if col.name not in ['record_status','valid_from','valid_to'] %}
            {% do column_list.append(col.name) %}
        {% endif %}
    {% endfor %}
{% else %}
    {% for col in all_cloumns %}
        {% if col.name not in ['record_status','valid_from','valid_to'] %}
            {% do column_list.append(alias ~'.'~ col.name) %}
        {% endif %}
    {% endfor %}
{% endif %}

{% do return(','.join(column_list)) %}

{% endmacro %}