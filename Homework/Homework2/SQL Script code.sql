--Part 1: Create Database Schema --

--Step 1: Create Database (Created database using CLI mode)
--CREATE DATABASE course_registration_db;

--Step 2: Create Tables

--Students Table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL ,
    email VARCHAR(100) UNIQUE ,
    major VARCHAR(100) NOT NULL,
    year INTEGER CHECK (year BETWEEN 1 AND 4) NOT NULL
);


--Courses table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE ,
    title VARCHAR(100) NOT NULL,
    credits INTEGER CHECK (credits > 0) NOT NULL,
    department VARCHAR(100) NOT NULL

);

--Professors table
CREATE TABLE professors (
    professor_id  SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department VARCHAR(100) NOT NULL,
    office VARCHAR(100) NOT NULL
);


--Enrollments table
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY ,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id),
    semester VARCHAR(10) NOT NULL,
    grade VARCHAR(2)
);

--CourseOfferings table
CREATE TABLE course_offerings (
    offering_id SERIAL PRIMARY KEY,
    course_id INTEGER REFERENCES courses(course_id),
    professor_id INTEGER REFERENCES professors(professor_id),
    semester VARCHAR(10) NOT NULL,
    year INTEGER NOT NULL
);



--Part 2: Insert sample data --

INSERT INTO students (name, email, major, year) VALUES
('Suman Dangol', 'suman.dangol@example.com', 'Data Science', 1),
('Prashida Prajuli', 'parajuli@example.com', 'Data Science', 2),
('Evi Reed', 'evi.reed@example.com', 'Information Systems', 3),
('Anjeela Shretha', 'anjeela.shrestha@example.com', 'Computer Science', 1),
('Jack Johnson', 'jack11@example.com', 'Computer Science', 4),
('Carry Kim', 'carry.kim@example.com', 'Data Science', 2),
('Jack Smith', 'jacksmith372@example.com', 'Cyber Security', 1),
('Jenny Maxwell', 'jenny234@example.com', 'Cyber Security', 4),
('Rin Parker', 'rin.parker@example.com', 'Data Science', 4);


INSERT INTO courses (course_code, title, credits, department) VALUES
('DS310', 'Machine Learning', 3, 'Data Science'),
('DS320', 'Artificial Intelligence', 3, 'Data Science'),
('IT210', 'Software Engineering', 2, 'Information Technology'),
('IT220', 'Mobile App Development', 2, 'Information Technology'),
('CS110', 'Database Design', 4, 'Computer Science'),
('CBS410', 'Ethical Hacking', 3, 'Cyber Security'),
('DS330', 'Practical Data Science', 3, 'Data Science');


INSERT INTO professors (name, email, department, office) VALUES
('Jeff Maxwell ', 'jeff.maxwell@university.edu', 'Computer Science', 'Room 101'),
('Bobby Reed', 'bobby.reed@university.edu', 'Information Technology', 'Room 210'),
('Shamir Khandaker', 'skhandaker123@university.edu', 'Data Science', 'Room 205'),
('Suresh Dangol', 'suresh.dangol@university.edu', 'Cyber Security', 'Room 105');


INSERT INTO enrollments (student_id, course_id, semester, grade) VALUES
(1, 1, 'Spring', 'A-'),
(3, 3, 'Spring', 'B+'),
(2, 1, 'Spring', 'B-'),
(5, 5, 'Fall', 'A'),
(6, 7, 'Fall', 'A'),
(8, 6, 'Spring', 'B'),
(4, 5, 'Spring', 'A'),
(7, 6, 'Fall', 'B'),
(9, 7, 'Fall', 'A'),
(9, 1, 'Spring', 'A'),
(3, 4, 'Spring', 'A-'),
(2, 2, 'Fall', 'B+');


INSERT INTO course_offerings (course_id, professor_id, semester, year) VALUES
(1, 3, 'Spring', 2024),
(4, 2, 'Fall', 2024),
(5, 1, 'Fall', 2024),
(2, 3, 'Fall', 2024),
(3, 2, 'Spring', 2025),
(4, 2, 'Spring', 2025),
(2, 3, 'Spring', 2025),
(5, 1, 'Fall', 2025),
(4, 2, 'Fall', 2025),
(6, 4, 'Fall', 2025),
(7, 3, 'Fall', 2025);


--Part 3: Queries --

-- List all students with their majors and year
SELECT name, major, year FROM students;


-- Show which courses each student is enrolled in (JOIN)
SELECT s.name AS student_name, c.title AS course_title, e.semester
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
ORDER BY s.name;


-- Find which professor teaches which course (JOIN with CourseOfferings)
SELECT Distinct p.name AS professor_name, c.title AS course_title
FROM course_offerings co
JOIN professors p ON co.professor_id = p.professor_id
JOIN courses c ON co.course_id = c.course_id
ORDER BY p.name, c.title;


-- Count how many students are in each course (GROUP BY)
SELECT c.title AS course_title, COUNT(e.student_id) AS student_count
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
GROUP BY c.title
ORDER BY student_count DESC;


-- Professors who taught in every semester of a given year
SELECT p.name
FROM professors p
JOIN course_offerings co ON p.professor_id = co.professor_id
WHERE co.year = 2025
GROUP BY p.name
HAVING COUNT(DISTINCT co.semester) = (
    SELECT COUNT(DISTINCT semester) FROM course_offerings WHERE year = 2025
);
 