{% macro exclude_column(table_name, exclude_columns) %}
    {% set column_name = adapter.get_columns_in_relation(ref(table_name)) %}
    
    {% if exclude_columns is string %}
        {% set exclude_columns = [exclude_columns] %}
    {% endif %}
    
    {% set exclude_column_set = set(exclude_columns) %}
    
    
    {% for column in column_name %}
        {% if column.name not in exclude_column_set %}
            {{ column.name }}
            {% if not loop.last and (column_name[loop.index].name not in exclude_column_set)  %},{% endif %}
        {% endif %}
    {% endfor %}
{% endmacro %}