CREATE TABLE posts
(
    id         SERIAL PRIMARY KEY,
    title      text,
    content    text,
    views      int,
    account_id int,
    constraint fk_account foreign key (account_id)
        references accounts (id)
        on delete cascade
);