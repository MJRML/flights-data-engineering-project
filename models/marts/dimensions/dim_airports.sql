with origin_airports as (

    select
        origin_airport_code as airport_code,
        origin_airport_name as airport_name,
        origin_city_name as city_name,
        origin_state as state,
        origin_state_name as state_name

    from {{ ref('int_flights_enriched') }}

),

destination_airports as (

    select
        destination_airport_code as airport_code,
        destination_airport_name as airport_name,
        destination_city_name as city_name,
        destination_state as state,
        destination_state_name as state_name

    from {{ ref('int_flights_enriched') }}

),

airports as (

    select * from origin_airports

    union

    select * from destination_airports

)

select

    {{ dbt_utils.generate_surrogate_key(['airport_code']) }} as airport_key,

    airport_code,
    airport_name,
    city_name,
    state,
    state_name

from airports