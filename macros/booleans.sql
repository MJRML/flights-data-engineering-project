{% macro to_boolean(column_name) %}

case
    when {{ column_name }} is null then null

    when upper(trim(cast({{ column_name }} as varchar)))
        in ('1', 'TRUE', 'T', 'YES', 'Y')
        then true

    when upper(trim(cast({{ column_name }} as varchar)))
        in ('0', 'FALSE', 'F', 'NO', 'N')
        then false
    
    else null

end

{% endmacro %}