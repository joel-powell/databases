TRUNCATE TABLE posts, comments RESTART IDENTITY;

INSERT INTO posts (title, content)
VALUES ('post_1', 'content_1'),
       ('post_2', 'content_2');

INSERT INTO comments (author, content, post_id)
VALUES ('Alice', 'comment_1', 1),
       ('Bob', 'comment_2', 2),
       ('Carry', 'comment_3', 2),
       ('Dan', 'comment_4', 1);