{{ config(materialized='table') }}

with flights as (

    select *
    from {{ ref('fact_flights') }}

),

airports as (

    select *
    from {{ ref('dim_airports') }}

),

dates as (

    select *
    from {{ ref('dim_dates') }}

),

airport_performance as (

    select

        airports.airport_key,
        airports.airport_code,
        airports.airport_name,
        airports.city_name,
        airports.state,

        dates.year,
        dates.month,
        dates.month_name,

        count(*) as total_departures,

        round(avg(flights.departure_delay_minutes), 0)
            as average_departure_delay_minutes,

        count_if(flights.cancelled)
            as cancelled_departures,

        sum(flights.distance_miles)
            as total_distance_miles

    from flights

    inner join airports
        on flights.origin_airport_key = airports.airport_key

    inner join dates
        on flights.date_key = dates.date_key

    group by

        airports.airport_key,
        airports.airport_code,
        airports.airport_name,
        airports.city_name,
        airports.state,

        dates.year,
        dates.month,
        dates.month_name

)

select *
from airport_performance