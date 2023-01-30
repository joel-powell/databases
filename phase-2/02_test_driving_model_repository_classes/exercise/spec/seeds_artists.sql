TRUNCATE TABLE artists RESTART IDENTITY;

INSERT INTO artists (name, genre)
VALUES ('Pixies', 'Rock'),
       ('ABBA', 'Pop');