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
  count(movie_directors) as total_films 
FROM 
  directors,
  movie_directors
WHERE
  directors.id = movie_directors.did
GROUP BY directors.id 
HAVING count(*) > 500
ORDER BY total_films DESC;

-- #5 - 24 rows
SELECT 
  actors.fname,
  actors.lname,
  movies.name,
  count(casts)
FROM actor AS actors
JOIN casts ON actors.id = casts.pid
JOIN movie AS movies ON casts.mid = movies.id
WHERE
  movies.year = 2010
GROUP BY actors.id, casts.pid, casts.mid, movies.id
HAVING count(DISTINCT casts) >= 5;

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
    SELECT count(DISTINCT subcast)
    FROM casts as subcast
    WHERE subcast.pid = actors.id AND subcast.mid = movies.id
    GROUP BY subcast.pid, subcast.mid
  ) >= 5
;






