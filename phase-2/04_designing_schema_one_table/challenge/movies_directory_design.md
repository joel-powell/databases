# Single Table Design Recipe

## 1. Extract nouns from the user stories or specification

```
As a person who loves movies,
So I can list all my favourite movies
I want to see a list of movies' titles.

As a person who loves movies,
So I can list all my favourite movies
I want to see a list of movies' genres.

As a person who loves movies,
So I can list all my favourite movies
I want to see a list of movies' release year.
```

```
Nouns:

movies, title, genre, release year
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record | Properties                 |
|--------|----------------------------|
| movie  | title, genre, release year |

Name of the table (always plural): `movies`

Column names: `title`, `genre`, `release_year`

## 3. Decide the column types.

```
id: SERIAL
title: text
genre: text
release_year: int
```

## 4. Write the SQL.

```sql
-- file: albums_table.sql

CREATE TABLE movies
(
    id           SERIAL PRIMARY KEY,
    title        text,
    genre        text,
    release_year int
);
```

## 5. Create the table.

```bash
psql -h localhost movies_directory < movies_table.sql
```
