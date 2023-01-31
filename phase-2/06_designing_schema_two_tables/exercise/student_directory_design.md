# Two Tables Design Recipe

## 1. Extract nouns from the user stories or specification

```
As a coach
So I can get to know all students
I want to see a list of students' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' names.

As a coach
So I can get to know all students
I want to see a list of cohorts' starting dates.

As a coach
So I can get to know all students
I want to see a list of students' cohorts.
```

```
Nouns:

student name, cohort name, cohort start date, student cohort
```

## 2. Infer the Table Name and Columns

| Record  | Properties       |
|---------|------------------|
| student | name             |
| cohort  | name, start_date |

1. Name of the first table (always plural): `students`

   Column names: `name`

2. Name of the second table (always plural): `cohorts`

   Column names: `name`, `start_date`

## 3. Decide the column types.

```
Table: students
id: SERIAL
name: text

Table: cohorts
id: SERIAL
name: text
start_date: date
```

## 4. Decide on The Tables Relationship

```
1. Can one cohort have many students? YES
2. Can one student have many cohorts? NO

-> Therefore,
-> A cohort HAS MANY students
-> A student BELONGS TO a cohort

-> Therefore, the foreign key is on the students table.
```

## 4. Write the SQL.

```sql
-- file: cohorts_table.sql
CREATE TABLE cohorts
(
    id         SERIAL PRIMARY KEY,
    name       text,
    start_date date
);

-- file: students_table.sql
CREATE TABLE students
(
    id        SERIAL PRIMARY KEY,
    name      text,
    cohort_id int,
    constraint fk_cohort foreign key (cohort_id)
        references cohorts (id)
        on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h localhost student_directory_2 < cohorts_table.sql
psql -h localhost student_directory_2 < students_table.sql
```
