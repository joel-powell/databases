-- 02_using_psql
-- exercise

SELECT *
FROM artists;

-- 03_querying_data
-- exercise one

SELECT release_year
FROM albums;

-- exercise two

SELECT release_year
FROM albums
WHERE release_year = 1990;

-- challenge

SELECT title, release_year
FROM albums
WHERE artist_id = 1
  AND release_year BETWEEN 1988 AND 1990;

-- 04_updating_and_deleting_data
-- exercise

UPDATE albums
SET release_year = 1972
WHERE id = 3;

SELECT release_year
FROM albums
WHERE id = 3;

-- challenge

DELETE
FROM albums
WHERE id = 12;

SELECT *
FROM albums;

-- 05_creating_new_data
--exercise

INSERT INTO albums
    (title, release_year)
VALUES ('Mezzanine', 1998);

SELECT *
FROM albums;

UPDATE albums
SET artist_id = 5
WHERE id = 13;

-- challenge

INSERT INTO artists
    (name, genre)
VALUES ('Radiohead', 'Alternative');

INSERT INTO albums
    (title, release_year, artist_id)
VALUES ('OK Computer', 1997, 6);

SELECT *
FROM artists
WHERE name = 'Radiohead';