-- exercise one

SELECT albums.id,
       albums.title
FROM albums
         JOIN artists
              ON albums.artist_id = artists.id
WHERE artists.name = 'Taylor Swift';

-- exercise two

SELECT albums.id,
       albums.title
FROM albums
         JOIN artists
              ON albums.artist_id = artists.id
WHERE artists.name = 'Pixies'
  AND release_year = 1988;

-- challenge

SELECT albums.id, albums.title
FROM albums
         JOIN artists
              ON albums.artist_id = artists.id
WHERE artists.name = 'Nina Simone'
  AND release_year > 1975;