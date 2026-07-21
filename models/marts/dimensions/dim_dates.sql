with dates as (

    select
        dateadd(
            day,
            seq4(),
            to_date('1990-01-01')
        ) as date_day

    from table(generator(rowcount => 16801))
    -- 2000-01-01 through 2030-12-31

)

select

    {{ dbt_utils.generate_surrogate_key(['date_day']) }} as date_key,

    date_day as date,

    year(date_day) as year,
    quarter(date_day) as quarter,

    month(date_day) as month,
    monthname(date_day) as month_name,

    day(date_day) as day,

    dayofweekiso(date_day) as day_of_week,
    dayname(date_day) as day_name,

    case
        when dayofweekiso(date_day) in (6,7) then true
        else false
    end as is_weekend

from dates