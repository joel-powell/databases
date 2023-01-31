TRUNCATE TABLE accounts, posts RESTART IDENTITY;

INSERT INTO accounts (email, username)
VALUES ('test@email.com', 'user_one'),
       ('email@testing.co.uk', 'user_two');

INSERT INTO posts (title, content, views, account_id)
VALUES ('first_post', 'this post has some content', 56, 1),
       ('second_post', 'some cool content', 34, 2),
       ('third_post', 'best content yet', 156, 1);