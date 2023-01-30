TRUNCATE TABLE albums RESTART IDENTITY;

INSERT INTO albums (title, release_year, artist_id)
VALUES ('Doolittle', 1989, 1),
       ('Surfer Rosa', 1988, 1),
       ('Super Trouper', 1980, 2);