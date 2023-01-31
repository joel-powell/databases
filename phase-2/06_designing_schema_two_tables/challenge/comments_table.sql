CREATE TABLE comments
(
    id      SERIAL PRIMARY KEY,
    author  text,
    content text,
    post_id int,
    constraint fk_post foreign key (post_id)
        references posts (id)
        on delete cascade
);