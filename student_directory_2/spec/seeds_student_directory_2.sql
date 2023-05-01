TRUNCATE TABLE students, cohorts  RESTART IDENTITY;


INSERT INTO cohorts (name, starting_date) VALUES ('Level 1', '2023-01-01');
INSERT INTO cohorts (name, starting_date) VALUES ('Level 2', '2023-02-01');

INSERT INTO students (name, cohort_id) VALUES ('student 1', 1);
INSERT INTO students (name, cohort_id) VALUES ('student 2', 1);
INSERT INTO students (name, cohort_id) VALUES ('student 3', 2);
INSERT INTO students (name, cohort_id) VALUES ('student 4', 2);

