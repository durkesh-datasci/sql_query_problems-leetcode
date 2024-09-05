with UserMovieCount as (
    select u.name, count(mr.movie_id) as movie_count
    from Users u
    join MovieRating mr on u.user_id = mr.user_id
    group by u.name
    order by movie_count desc, u.name
    limit 1
),
MovieRatingsInFeb as (
    select m.title, avg(mr.rating) as avg_rating
    from Movies m
    join MovieRating mr on m.movie_id = mr.movie_id
    where mr.created_at between '2020-02-01' and '2020-02-29'
    group by m.title
    order by avg_rating desc, m.title
    limit 1
)
select name as results from UserMovieCount
union all
select title as results from MovieRatingsInFeb;