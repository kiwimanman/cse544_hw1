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

-- #4









