with totalamount as (
    select
        visited_on,
        sum(amount) over (
            order by visited_on
            rows between 6 preceding and current row
        ) as total_amount,
        avg(amount) over (
            order by visited_on
            rows between 6 preceding and current row
        ) as average_amount
    from
        (select visited_on, sum(amount) as amount
         from customer
         group by visited_on) grouped_customer
)
select
    visited_on,
    total_amount as amount,
    round(average_amount, 2) as average_amount
from
    totalamount
where
    (select count(distinct visited_on) from customer c2 where c2.visited_on <= totalamount.visited_on) >= 7
order by
    visited_on asc;