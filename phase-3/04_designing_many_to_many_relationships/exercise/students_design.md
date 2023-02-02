# Two Tables (Many-to-Many) Design Recipe Template

## 1. Extract nouns from the user stories or specification

```
As a coach
So I can get to know all students
I want to keep a list of students' names.

As a coach
So I can get to know all students
I want to assign tags to students (for example, "happy", "excited", etc).

As a coach
So I can get to know all students
I want to be able to assign the same tag to many different students.

As a coach
So I can get to know all students
I want to be able to assign many different tags to a student.
```

```
Nouns:

student names, tags name, student tags
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table.

| Record  | Properties |
|---------|------------|
| student | name       |
| tags    | name       |

1. Name of the first table (always plural): `students`

   Column names: `name`

2. Name of the second table (always plural): `tags`

   Column names: `name`

## 3. Decide the column types.

```
# EXAMPLE:

Table: students
id: SERIAL
name: text

Table: tags
id: SERIAL
name: text
```

## 4. Design the Many-to-Many relationship

```
1. Can one tag have many students? YES
2. Can one student have many tags? YES
```

## 5. Design the Join Table

```
Join table for tables: students and tags
Join table name: students_tags
Columns: student_id, tag_id
```

## 4. Write the SQL.

```sql
-- file: students_tags.sql

CREATE TABLE students
(
    id   SERIAL PRIMARY KEY,
    name text
);

CREATE TABLE tags
(
    id   SERIAL PRIMARY KEY,
    name text
);

CREATE TABLE students_tags
(
    student_id int,
    tag_id     int,
    constraint fk_student foreign key (student_id) references students (id) on delete cascade,
    constraint fk_tag foreign key (tag_id) references tags (id) on delete cascade,
    PRIMARY KEY (student_id, tag_id)
);
```

## 5. Create the tables.

```bash
psql -h localhost students < students_tags.sql
```