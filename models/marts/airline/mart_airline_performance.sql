{{ config(materialized='table') }}

with flights as (

    select *
    from {{ ref('fact_flights') }}

),

airlines as (

    select *
    from {{ ref('dim_airlines') }}

),

dates as (

    select *
    from {{ ref('dim_dates') }}

),

airline_performance as (

    select

        airlines.airline_key,
        airlines.airline_code,
        airlines.airline_name,

        dates.year,
        dates.month,
        dates.month_name,

        count(*) as total_flights,

        count_if(
            not flights.cancelled
            and not flights.diverted
        ) as completed_flights,

        count_if(flights.cancelled) as cancelled_flights,

        count_if(flights.diverted) as diverted_flights,

        round(avg(flights.departure_delay_minutes),0) as average_departure_delay_minutes,

        round(avg(flights.arrival_delay_minutes),0) as average_arrival_delay_minutes,

        round(
            100 * avg(
                case
                    when coalesce(flights.departure_delay_minutes, 0) <= 15
                    then 1
                    else 0
                end
            ),
            2
        ) as on_time_percentage,

        round(
            100 * avg(
                case
                    when flights.cancelled
                    then 1
                    else 0
                end
            ),
            2
        ) as cancellation_rate,

        round(
            100 * avg(
                case
                    when flights.diverted
                    then 1
                    else 0
                end
            ),
            2
        ) as diversion_rate

    from flights

    inner join airlines
        on flights.airline_key = airlines.airline_key

    inner join dates
        on flights.date_key = dates.date_key

    group by

        airlines.airline_key,
        airlines.airline_code,
        airlines.airline_name,

        dates.year,
        dates.month,
        dates.month_name

)

select *
from airline_performance