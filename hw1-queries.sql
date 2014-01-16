-- #1 - 13 Rows
SELECT actors.fname, actors.lname
FROM actor AS actors,
     casts,
     movie AS movies
WHERE
  actors.id   = casts.pid AND
  casts.mid   = movies.id AND
  movies.name = 'Officer 444';

-- #2 - 113 Rows
SELECT DISTINCT
  directors.fname,
  directors.lname,
  movies.name,
  movies.year
FROM
  directors,
  movie as movies,
  genre as genres,
  movie_directors
WHERE
  genres.genre = 'Film-Noir' AND
  movies.id = genres.mid AND
  directors.id = movie_directors.did AND
  movies.id = movie_directors.mid AND
  movies.year % 4 = 0;

-- #3 - 48 Rows
SELECT DISTINCT
  actors.id,
  actors.fname,
  actors.lname
FROM
  actor AS actors,
  casts AS early_casting,
  casts AS late_casting,
  movie AS early_movies,
  movie AS late_movies
WHERE
  actors.id = early_casting.pid AND
  actors.id = late_casting.pid AND
  early_casting.mid = early_movies.id AND
  late_casting.mid = late_movies.id AND
  early_movies.year < 1900 AND
  late_movies.year > 2000;

-- Historical figure appearing in modern footage and being credited. Likly using old footage.
SELECT 
  movie.year,
  genre.genre
FROM movie, casts, genre
WHERE
  casts.pid = 525433 and
  casts.mid = movie.id and
  (movie.year < 1900 or movie.year > 2000) and
  genre.mid = movie.id;

-- #4 - 47 rows
SELECT
  directors.fname,
  directors.lname,
  count(movie_directors.mid) as total_films 
FROM 
  directors,
  movie_directors
WHERE
  directors.id = movie_directors.did
GROUP BY directors.id, directors.fname, directors.lname
HAVING count(*) > 500
ORDER BY total_films DESC;

-- #5 - 24 rows
SELECT 
  actors.fname,
  actors.lname,
  movies.name,
  count(DISTINCT casts.role)
FROM actor AS actors
JOIN casts ON actors.id = casts.pid
JOIN movie AS movies ON casts.mid = movies.id
WHERE
  movies.year = 2010
GROUP BY actors.id, actors.fname, actors.lname, casts.pid, casts.mid, movies.id, movies.name
HAVING count(DISTINCT casts.role) >= 5;

-- #6 - 137 rows
SELECT 
  actors.fname,
  actors.lname,
  movies.name,
  casts.role
FROM actor AS actors
JOIN casts ON actors.id = casts.pid
JOIN movie AS movies ON casts.mid = movies.id
WHERE
  movies.year = 2010 AND
  (
    SELECT count(DISTINCT subcast.role)
    FROM casts as subcast
    WHERE subcast.pid = actors.id AND subcast.mid = movies.id
    GROUP BY subcast.pid, subcast.mid
  ) >= 5
;

-- #7 - 129 rows
SELECT
  movies.year,
  count(movies.id)
FROM
  movie AS movies
WHERE
  NOT EXISTS (
    SELECT *
    FROM actor AS actors
    JOIN casts ON actors.id = casts.pid
    WHERE
      actors.gender = 'M' AND
      casts.mid = movies.id
  )
GROUP BY movies.year
ORDER BY movies.year DESC;

-- #8 - 136 rows
SELECT movies.year, female_casts.count * 100.0 / count(movies.id), count(movies.id)
FROM movie as movies
JOIN (SELECT movies.year, count(movies.id) as count
    FROM movie AS movies
    WHERE NOT EXISTS (
      SELECT *
      FROM actor AS actors
      JOIN casts ON actors.id = casts.pid
      WHERE
          actors.gender = 'M' AND casts.mid = movies.id)
      GROUP BY movies.year) as female_casts
ON movies.year = female_casts.year
GROUP BY movies.year, female_casts.count
ORDER BY movies.year DESC;

-- #9 - 1 row
SELECT
  movies.name,
  role_agg.count
FROM movie as movies,
  (SELECT
    movie.id as id,
    count(DISTINCT casts.pid) as count
  FROM casts, movie
  WHERE movie.id = casts.mid
  GROUP BY movie.id) AS role_agg
WHERE
  movies.id = role_agg.id AND
  role_agg.count = (
    SELECT max(role_agg.count)
    FROM
      (SELECT
        movie.id AS id,
        count(DISTINCT casts.pid) AS count
      FROM casts, movie
      WHERE movie.id = casts.mid
      GROUP BY movie.id) as role_agg);

-- #10 - 1 row
SELECT
  decade_agg.year,
  decade_agg.count
FROM (
  SELECT a.year, count(b.id) as count
  FROM (SELECT DISTINCT year FROM movie)
  AS a JOIN movie AS b on b.year >= a.year and b.year < a.year + 10
  GROUP BY a.year
) AS decade_agg
WHERE decade_agg.count = (
  SELECT max(decade_agg.count)
  FROM (
    SELECT a.year, count(b.id) as count
    FROM (SELECT DISTINCT year FROM movie)
    AS a JOIN movie AS b on b.year >= a.year and b.year < a.year + 10
    GROUP BY a.year
  ) AS decade_agg
);

-- #11 - 1 row
select count(second_order_pid)
from (select DISTINCT second_order.pid as second_order_pid
from casts as first_movie
join casts as first_order on first_movie.mid = first_order.mid
join casts as second_movie on first_order.pid = second_movie.pid
join casts as second_order on second_movie.mid = second_order.mid 
where 
  first_movie.pid = 52435 and 
  first_movie.mid != second_movie.mid AND
  52435 != first_order.pid AND
  52435 != second_order.pid AND
  first_order.pid != second_order.pid
EXCEPT
SELECT DISTINCT first_order.pid
from casts as first_movie
join casts as first_order on first_movie.mid = first_order.mid
where
  first_movie.pid = 52435 and 52435 != first_order.pid) as second_order;


