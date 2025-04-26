{% macro flatten_case_when (flatten_column, flatten_values, columns) %}
    {% set column_names = columns.keys() %}
    {% set column_count = columns | length %}

    {% for row in flatten_values %}
        {% for key, column in columns.items() %}
            MAX(CASE WHEN {{ flatten_column }} = '{{ row }}' THEN {{ column }}  END) as {{ row }}_{{ column }}
            {% if not loop.last  %},{% endif %}
        {% endfor %}
        {% if not loop.last %},{% endif %}
    {% endfor %}
{% endmacro %}


{% macro flatten_case_when_sum(flatten_column, flatten_values, columns) %}
    {% set column_names = columns.keys() %}
    {% set column_count = columns | length %}
    
    {% for row in flatten_values %}
        {% for key, column in columns.items() %}
            SUM(
                CAST(
                    TRIM(
                        CASE 
                            WHEN {{ flatten_column }} = '{{ row }}' 
                            THEN {{ column }} 
                            ELSE '0.00' 
                        END
                    ) AS DECIMAL(18, 2)
                )
            ) AS {{ row }}_{{ column }}
            {% if not loop.last %},{% endif %}
        {% endfor %}
        {% if not loop.last %},{% endif %}
    {% endfor %}
{% endmacro %}






{% macro flatten_case_when_mixed (flatten_column, flatten_values,aggregation) %}

    {% for row in flatten_values %}
        {% for agg,columns in aggregation.items() %}
            {% for key, column in columns.items() %}
                {{agg}}(CASE WHEN {{ flatten_column }} = '{{ row }}' THEN {{ column }}  END) as {{ row }}_{{ column }}
                {% if not loop.last  %},{% endif %}
            {% endfor %}
            {% if not loop.last  %},{% endif %}
        {% endfor %}
        {% if not loop.last %},{% endif %}
    {% endfor %}
{% endmacro %}

{% macro flatten_case_when_mixed_typecast(flatten_column, flatten_values, aggregation) %}

    {% for row in flatten_values %}
        {% for agg, columns in aggregation.items() %}
            {% for key, column in columns.items() %}
                {% if column is number %}
                    {{ agg }}(CASE WHEN {{ flatten_column }} = '{{ row }}' THEN {{ column }}::decimal(18, 2) END) AS {{ row }}_{{ key }}
                {% else %}
                    {{ agg }}(CASE WHEN {{ flatten_column }} = '{{ row }}' THEN {{ column }} END) AS {{ row }}_{{ key }}
                {% endif %}
                {% if not loop.last %},{% endif %}
            {% endfor %}
            {% if not loop.last %},{% endif %}
        {% endfor %}
        {% if not loop.last %},{% endif %}
    {% endfor %}
{% endmacro %}