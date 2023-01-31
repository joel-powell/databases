# Two Tables Design Recipe

## 1. Extract nouns from the user stories or specification

```
As a blogger
So I can write interesting stuff
I want to write posts having a title.

As a blogger
So I can write interesting stuff
I want to write posts having a content.

As a blogger
So I can let people comment on interesting stuff
I want to allow comments on my posts.

As a blogger
So I can let people comment on interesting stuff
I want the comments to have a content.

As a blogger
So I can let people comment on interesting stuff
I want the author to include their name in comments.
```

```
Nouns:

post title, post content, comment post, comment content, comment author
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table.

| Record  | Properties      |
|---------|-----------------|
| post    | title, content  |
| comment | content, author |

1. Name of the first table (always plural): `posts`

   Column names: `title`, `content`

2. Name of the second table (always plural): `comments`

   Column names: `author`, `content`

## 3. Decide the column types.

```
Table: posts
id: SERIAL
title: text
content: text

Table: comments
id: SERIAL
author: text
content: text
```

## 4. Decide on The Tables Relationship

```
1. Can one post have many comments? YES
2. Can one comment have many posts? NO

-> Therefore,
-> A post HAS MANY comments
-> A comment BELONGS TO a post

-> Therefore, the foreign key is on the comments table.
```

## 4. Write the SQL.

```sql
-- file: posts_table.sql
CREATE TABLE posts
(
    id      SERIAL PRIMARY KEY,
    title   text,
    content text
);

-- file: comments_table.sql
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
```

## 5. Create the tables.

```bash
psql -h localhost blog < posts_table.sql
psql -h localhost blog < comments_table.sql
```