

Suppose we have the following database schema for a school management system:

-- `students` table: Contains student information (student_id, first_name, last_name, grade_level)
-- `courses` table: Contains course information (course_id, course_name, department)
-- `enrollments` table: Stores student enrollment records (enrollment_id, student_id, course_id, semester, year)
-- `teachers` table: Contains teacher information (teacher_id, first_name, last_name, department)
-- `class_schedules` table: Stores class schedule details (schedule_id, course_id, teacher_id, classroom, start_time, end_time)




1.Self-Join

-- To retrieve a list of students along with the names of their classmates in the same grade level:


SELECT
    s1.first_name || ' ' || s1.last_name AS student,
    s2.first_name || ' ' || s2.last_name AS classmate
FROM
    students s1
    JOIN students s2 ON s1.grade_level = s2.grade_level AND s1.student_id != s2.student_id;


-- In this query, the `students` table is joined with itself to compare each student with their classmates in the same
  -- grade level. The `AND s1.student_id != s2.student_id` condition ensures that a student is not compared with 
      -- themselves.



2.Multiple Join Conditions

To retrieve a list of students enrolled in a specific course during a given semester and year:


SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    e.semester,
    e.year
FROM
    students s
    JOIN enrollments e ON s.student_id = e.student_id
    JOIN courses c ON e.course_id = c.course_id AND c.department = 'Computer Science'
WHERE
    e.semester = 'Fall' AND e.year = 2022;


-- This query joins the `students`, `enrollments`, and `courses` tables based on multiple conditions.
  -- It retrieves students enrolled in Computer Science courses during the Fall 2022 semester.



3.Nested Joins

-- To retrieve a list of students along with their course schedules, including the teacher's name and classroom:


SELECT
    s.first_name,
    s.last_name,
    c.course_name,
    t.first_name || ' ' || t.last_name AS teacher,
    cs.classroom,
    cs.start_time,
    cs.end_time
FROM
    students s
    JOIN enrollments e ON s.student_id = e.student_id
    JOIN courses c ON e.course_id = c.course_id
    JOIN class_schedules cs ON c.course_id = cs.course_id
    JOIN teachers t ON cs.teacher_id = t.teacher_id;


-- This query involves nested joins to combine data from multiple tables.
 -- It retrieves student information, course details, teacher names, classrooms, and class schedules.



4.Cross Join

-- To generate all possible combinations of students and courses (not recommended for large datasets):


SELECT
    s.first_name,
    s.last_name,
    c.course_name
FROM
    students s
    CROSS JOIN courses c;


-- This query performs a cross join between the `students` and `courses` tables, resulting in every combination 
    --of student and course. Cross joins should be used with caution, as they can generate a large number of rows,
       -- especially when dealing with large tables.





5.Joining Multiple Tables

-- To retrieve a comprehensive report that includes student information, course details, enrollment records, 
     -- teacher names, and class schedules:



SELECT
    s.first_name AS student_first_name,
    s.last_name AS student_last_name,
    c.course_name,
    t.first_name || ' ' || t.last_name AS teacher,
    e.semester,
    e.year,
    cs.classroom,
    cs.start_time,
    cs.end_time
FROM
    students s
    JOIN enrollments e ON s.student_id = e.student_id
    JOIN courses c ON e.course_id = c.course_id
    JOIN class_schedules cs ON c.course_id = cs.course_id
    JOIN teachers t ON cs.teacher_id = t.teacher_id;

-- This query joins the `students`, `enrollments`, `courses`, `class_schedules`, and `teachers` tables to retrieve
   -- comprehensive information about students, their enrolled courses, teachers, classrooms, and class schedules.
