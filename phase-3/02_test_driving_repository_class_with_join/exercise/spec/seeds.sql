TRUNCATE TABLE cohorts, students RESTART IDENTITY;

INSERT INTO cohorts (name, start_date)
VALUES ('December 22', '2022-12-05'),
       ('January 23', '2023-01-16');

INSERT INTO students (name, cohort_id)
VALUES ('Alice', 1),
       ('Bob', 2),
       ('Carry', 2),
       ('Dan', 1);