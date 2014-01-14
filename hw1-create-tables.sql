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
  mid   INTEGER REFERENCES MOVIE(id),
  genre TEXT
);
