with fact as (

    select
        count(*) as total_departures
    from {{ ref('fact_flights') }}

),

mart as (

    select
        sum(total_departures) as total_departures
    from {{ ref('mart_busiest_airports') }}

)

select *

from fact
cross join mart

where fact.total_departures <> mart.total_departures