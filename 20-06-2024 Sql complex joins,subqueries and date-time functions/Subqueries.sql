-- A subquery is a SQL query nested inside another SQL query. 
-- Subqueries can be used in various parts of a SQL statement, 
   -- such as the `SELECT`, `FROM`, `WHERE`, `HAVING`, and `ORDER BY` clauses.



1.Subquery in the SELECT clause

-- To retrieve the student's name and their rank based on their grade point average (GPA):


SELECT
    student_name,
    (
        SELECT
            COUNT(*) + 1
        FROM
            student_records sr2
        WHERE
            sr2.gpa > sr1.gpa
    ) AS rank
FROM
    student_records sr1
ORDER BY
    rank;


-- In this example, the subquery calculates the rank of each student by counting the number of students with a higher
  -- GPA than the current student. The `COUNT(*) + 1` expression includes the current student's position in the ranking.



2.Subquery in the FROM clause

-- To retrieve the names of students who have taken at least one course from the Computer Science department:


SELECT
    student_name
FROM
    (
        SELECT
            s.student_name,
            c.department
        FROM
            students s
            JOIN enrollments e ON s.student_id = e.student_id
            JOIN courses c ON e.course_id = c.course_id
    ) AS student_courses
WHERE
    department = 'Computer Science'
GROUP BY
    student_name;


-- In this example, the subquery joins the `students`, `enrollments`, and `courses` tables to retrieve the student
  -- names and the departments of the courses they have taken. The outer query then filters the result to include 
     -- only students who have taken at least one Computer Science course.

3.Subquery in the WHERE clause

-- To retrieve the courses that have more enrollments than the average number of enrollments across all courses:


SELECT
    course_name,
    (
        SELECT
            COUNT(*)
        FROM
            enrollments e
        WHERE
            e.course_id = c.course_id
    ) AS enrollments
FROM
    courses c
WHERE
    (
        SELECT
            COUNT(*)
        FROM
            enrollments e
        WHERE
            e.course_id = c.course_id
    ) > (
        SELECT
            AVG(count)
        FROM
            (
                SELECT
                    COUNT(*) AS count
                FROM
                    enrollments
                GROUP BY
                    course_id
            ) AS enrollment_counts
    )
ORDER BY
    enrollments DESC;


-- This query involves multiple subqueries. The first subquery calculates the number of enrollments for each course.
-- The second subquery calculates the average number of enrollments across all courses.
  --  The outer query retrieves the course names and their enrollment counts, filtering for courses with enrollments 
     -- higher than the average.


4.Correlated Subquery

-- A correlated subquery is a subquery that references a column from the outer query. Here's an example:


SELECT
    department,
    (
        SELECT
            COUNT(*)
        FROM
            teachers t
        WHERE
            t.department = d.department
    ) AS num_teachers
FROM
    departments d;


-- In this example, the subquery is correlated with the outer query because it references the `department` column from
   -- the `departments` table. The subquery counts the number of teachers in each department, and the outer query 
      -- retrieves the department names along with the corresponding number of teachers.


5.Subquery with EXISTS and NOT EXISTS

-- The `EXISTS` and `NOT EXISTS` operators can be used with subqueries to check if a subquery returns any rows or not.


SELECT
    student_name
FROM
    students s
WHERE
    EXISTS (
        SELECT
            1
        FROM
            enrollments e
        WHERE
            e.student_id = s.student_id
    );


-- This query retrieves the names of students who have at least one enrollment record in the `enrollments` table. 
  -- The `EXISTS` operator checks if the subquery returns any rows for each student, indicating that the student has
  -- an enrollment record.


SELECT
    course_name
FROM
    courses c
WHERE
    NOT EXISTS (
        SELECT
            1
        FROM
            enrollments e
        WHERE
            e.course_id = c.course_id
    );
