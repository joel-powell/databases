# Two Tables Design Recipe Template

## 1. Extract nouns from the user stories or specification

```
As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.
```

```
Nouns:

account email address, account username, post account, post title, post content, post views
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table.

| Record  | Properties            |
|---------|-----------------------|
| account | email, username       |
| post    | title, content, views |

1. Name of the first table (always plural): `accounts`

   Column names: `email`, `username`

2. Name of the second table (always plural): `posts`

   Column names: `title`, `content`, `views`

## 3. Decide the column types.

```
Table: accounts
id: SERIAL
email: text
username: text

Table: posts
id: SERIAL
title: text
content: text
views: int
```

## 4. Decide on The Tables Relationship

```
1. Can one account have many posts? YES
2. Can one post have many accounts? NO

-> Therefore,
-> An account HAS MANY posts
-> A post BELONGS TO an account

-> Therefore, the foreign key is on the posts table.
```

## 4. Write the SQL.

```sql
-- file: accounts_table.sql
CREATE TABLE accounts
(
    id       SERIAL PRIMARY KEY,
    email    text,
    username text
);

-- file: posts_table.sql
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

```

## 5. Create the tables.

```bash
psql -h localhost social_network < accounts_table.sql
psql -h localhost social_network < posts_table.sql
psql -h localhost social_network_test < accounts_table.sql
psql -h localhost social_network_test < posts_table.sql
```