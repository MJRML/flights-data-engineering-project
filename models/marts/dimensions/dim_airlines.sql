with airlines as (
    
    select distinct
        airline_code,
        airline_name

    from {{ ref('int_flights_enriched') }}
)

select

    {{ dbt_utils.generate_surrogate_key(['airline_code']) }} as airline_key,
    airline_code,
    airline_name

from airlines