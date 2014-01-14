CREATE TABLE ACTOR (
  id     INTEGER PRIMARY KEY ,
  fname  TEXT,
  lname  TEXT,
  gender VARCHAR(1) 
);

CREATE TABLE MOVIE (
  id   INTEGER PRIMARY KEY,
  name TEXT,
  year INTEGER
);

CREATE TABLE DIRECTORS (
  id    INTEGER PRIMARY KEY,
  fname TEXT,
  lname TEXT
);

CREATE TABLE CASTS (
  pid  INTEGER REFERENCES ACTOR(id),
  mid  INTEGER REFERENCES MOVIE(id),
  role TEXT
);

CREATE TABLE MOVIE_DIRECTORS (
  did INTEGER REFERENCES DIRECTORS(id),
  mid INTEGER REFERENCES MOVIE(id)
);

CREATE TABLE GENRE (
  mid   INTEGER,
  genre TEXT
);

\copy ACTOR           from '/Users/kstone/homework/544/hw1/imdb2010/actor-ascii.txt'           with delimiter '|' csv quote E'\n'
\copy MOVIE           from '/Users/kstone/homework/544/hw1/imdb2010/movie-ascii.txt'           with delimiter '|' csv quote E'\n'
\copy DIRECTORS       from '/Users/kstone/homework/544/hw1/imdb2010/directors-ascii.txt'       with delimiter '|' csv quote E'\n'
\copy CASTS           from '/Users/kstone/homework/544/hw1/imdb2010/casts-ascii.txt'           with delimiter '|' csv quote E'\n'
\copy MOVIE_DIRECTORS from '/Users/kstone/homework/544/hw1/imdb2010/movie_directors-ascii.txt' with delimiter '|' csv quote E'\n'
\copy GENRE           from '/Users/kstone/homework/544/hw1/imdb2010/genre-ascii.txt'           with delimiter '|' csv quote E'\n'
