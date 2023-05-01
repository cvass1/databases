CREATE TABLE movies (
  id SERIAL PRIMARY KEY,
  title text,
  genre text,
  release_year int
);

INSERT INTO "public"."movies" ("title", "genre", "release_year") VALUES
('Matilda', 'family', 1996),
('The Matrix', 'sci-fi', 1999)
;