-- exercise one

SELECT posts.id, posts.title
FROM posts
         JOIN posts_tags ON posts.id = posts_tags.post_id
         JOIN tags on tags.id = posts_tags.tag_id
WHERE tags.name = 'travel';

-- challenge

INSERT INTO tags (name)
VALUES ('SQL');

INSERT INTO posts_tags (post_id, tag_id)
VALUES (7, 5);

SELECT posts.title
FROM posts
         JOIN posts_tags on posts.id = posts_tags.post_id
         JOIN tags on posts_tags.tag_id = tags.id
WHERE tags.name = 'SQL';