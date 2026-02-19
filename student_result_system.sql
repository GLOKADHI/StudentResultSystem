-- Student Result System
CREATE DATABASE student_result_system;
USE student_result_system;
-- Create Students Table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL
);
-- Create Subjects Table
CREATE TABLE subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(50) NOT NULL
);
-- Create Marks Table

CREATE TABLE marks (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_id INT,
    marks INT CHECK (marks BETWEEN 0 AND 100),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);
-- Insert Students
INSERT INTO students (student_name) VALUES
('Ananya'),
('Rohit'),
('Karthik'),
('Meera');
-- Insert Subjects
INSERT INTO subjects (subject_name) VALUES
('Maths'),
('Science'),
('English');
-- Insert Marks
INSERT INTO marks (student_id, subject_id, marks) VALUES
(1,1,65),
(1,2,78),
(1,3,88),
(2,1,92),
(2,2,81),
(2,3,75),
(3,1,70),
(3,2,68),
(3,3,72),
(4,1,95),
(4,2,89),
(4,3,91);
-- Student-wise Average
SELECT s.student_name, AVG(m.marks) AS average_marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_name;
-- Subject-wise Average
SELECT sub.subject_name, AVG(m.marks) AS average_marks
FROM subjects sub
JOIN marks m ON sub.subject_id = m.subject_id
GROUP BY sub.subject_name;
-- Top Performer Query
SELECT s.student_name, AVG(m.marks) AS avg_marks
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_name
HAVING AVG(m.marks) = (
    SELECT MAX(avg_score)
    FROM (
        SELECT AVG(marks) AS avg_score
        FROM marks
        GROUP BY student_id
    ) AS avg_table
);
-- Highest Marks Per Subject
SELECT sub.subject_name, MAX(m.marks) AS highest_marks
FROM subjects sub
JOIN marks m ON sub.subject_id = m.subject_id
GROUP BY sub.subject_name;
