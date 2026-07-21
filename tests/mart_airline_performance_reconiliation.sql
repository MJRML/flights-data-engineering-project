with fact as (

    select
        count(*) as total_flights
    from {{ ref('fact_flights') }}

),

mart as (

    select
        sum(total_flights) as total_flights
    from {{ ref('mart_airline_performance') }}

)

select *

from fact
cross join mart

where fact.total_flights <> mart.total_flights