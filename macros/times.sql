{% macro to_time_hhmm(column_name) %}

case 
    when {{ column_name }} is null then null

    -- Snowflake TIME cannot store 24:00:00
    when {{ column_name }} = 2400 then
        to_time('00:00:00')
    
    else
        to_time(
            lpad(cast({{ column_name }} as varchar),4, '0'),
            'HH24MI'
        )
end

{% endmacro %}

{% macro is_next_day(column_name) %}

case
    when {{ column_name }} = 2400 then true
    else false
end

{% endmacro %}