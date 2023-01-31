TRUNCATE TABLE recipes RESTART IDENTITY;

INSERT INTO recipes (name, average_cooking_time, rating)
VALUES ('Pizza', 10, 5),
       ('Pasta', 20, 4);