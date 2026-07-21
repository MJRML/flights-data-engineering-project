select

    {{ to_date_yyyymmdd('flightdate') }} as flight_date

from {{ source('raw', 'flights') }}

limit 10