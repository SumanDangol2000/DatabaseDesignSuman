
--Part 1: Create Database Schema

--Step 1: Create a database (Created database using CLI mode)
--CREATE DATABASE movie_rental_db;


--Step 2: Create tables

--Table 1: Movies
CREATE TABLE Movies(
    movie_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    director VARCHAR(100) NOT NULL,
    release_year INTEGER,
    available BOOLEAN DEFAULT TRUE,
    runtime_minutes INTEGER,
    language VARCHAR(50),
    genre VARCHAR(50)
);


--Table 2: Members
CREATE TABLE Members(
    member_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);


--Table 3: Rentals (relates Movies and Members)
CREATE TABLE Rentals(
    rental_id  SERIAL PRIMARY KEY,
    movie_id INTEGER REFERENCES Movies(movie_id),
    member_id INTEGER REFERENCES Members(member_id),
    rental_date DATE DEFAULT CURRENT_DATE,
    return_date DATE
);


--Part 2: Insert Sample Data

INSERT INTO Movies (title, director, release_year, available, runtime_minutes, language, genre)
VALUES
('Oppenheimer', 'Christopher Nolan', 2023, FALSE, 180, 'English', 'Biography'),
('Train to Busan', 'Yeon Sang-ho', 2016, TRUE, 118, 'Korean', 'Horror'),
('Spirited Away', 'Hayao Miyazaki', 2001, FALSE, 125, 'Japanese', 'Animation'),
('Dune: Part Two', 'Denis Villeneuve', 2024, FALSE, 166, 'English', 'Sci-Fi'),
('The Dark Knight', 'Christopher Nolan', 2008, FALSE, 152, 'English', 'Action'),
('Titanic', 'James Cameron', 1997, TRUE, 195, 'English', 'Romance'),
('3 Idiots', 'Rajkumar Hirani', 2009, FALSE, 170, 'Hindi', 'Comedy'),
('Hero', 'Zhang Yimou', 2002, TRUE, 99, 'Chinese', 'Action'),
('Roma', 'Alfonso Cuarón', 2018, FALSE, 135, 'Spanish', 'Drama'),
('Parasite', 'Bong Joon Ho', 2019, TRUE, 132, 'Korean', 'Thriller'),
('Your Name', 'Makoto Shinkai', 2016, TRUE, 112, 'Japanese', 'Romance'),
('Crouching Tiger, Hidden Dragon', 'Ang Lee', 2000, FALSE, 120, 'Chinese', 'Martial Arts'),
('Zindagi Na Milegi Dobara', 'Zoya Akhtar', 2011, TRUE, 155, 'Hindi', 'Adventure'),
('The Wandering Earth', 'Frant Gwo', 2019, TRUE, 125, 'Chinese', 'Sci-Fi');


INSERT INTO Members (name, email, phone)
VALUES
('Suman Dangol', 'suman.dangol@example.com', '603-555-1001'),
('Bobby Reed', 'bobby.reed@example.com', '603-555-1002'),
('Shamir Khandaker', 'shamir246@example.com', '603-555-1003'),
('Jeff Maxwell', 'jeff_max@example.com', '603-555-1004'),
('Michael Scott', 'michael.scott@example.com', '603-555-1005'),
('Pam Beesly', 'pam.beesly@example.com', '603-555-1006'),
('Jim Halpert', 'jim.halpert@example.com', '603-555-1007'),
('Dwight Maxwell', 'dwight.maxwell@example.com', '603-555-1008'),
('Harry Potter', 'harry.potter@example.com', '603-555-1009'),
('Hermione Granger', 'hermione.granger@example.com', '603-555-1010');


INSERT INTO Rentals (movie_id, member_id, rental_date, return_date)
VALUES
(10, 1, '2025-10-01', '2025-10-05'),
(1, 2, '2025-10-02', NULL),
(12, 3, '2025-10-02', '2025-10-07'),
(2, 4, '2025-10-02', NULL),
(3, 5, '2025-10-05', '2025-10-09'),
(4, 1, '2025-10-05', '2025-10-10'),
(5, 2, '2025-10-06', '2025-10-11'),
(5, 3, '2025-10-08', NULL),
(1, 1, '2025-10-09', NULL),
(1, 4, '2025-10-09', '2025-10-13'),
(8, 5, '2025-10-10', NULL),
(9, 6, '2025-10-11', '2025-10-15'),
(1, 7, '2025-10-11', '2025-10-16'),
(11, 8, '2025-10-11', NULL),
(2, 9, '2025-10-14', '2025-10-18'),
(1, 10, '2025-10-15', NULL),
(1, 9, '2025-10-15', NULL),
(2, 2, '2025-10-16', '2025-10-22'),
(6,4 , '2025-10-18', NULL);


--Part 3: Data Uniqueness Proof
SELECT
  (SELECT COUNT(*) FROM Movies) AS movie_count,
  (SELECT COUNT(DISTINCT genre) FROM Movies) AS genre_count,
  (SELECT STRING_AGG(title, ', ') FROM Movies) AS titles;

--Part 4: Join queries

--Query 1: Find members who have rented more than 1 movie
SELECT m.name, COUNT(r.rental_id) AS movies_rented
FROM Members m
JOIN Rentals r ON m.member_id = r.member_id
GROUP BY m.name
HAVING COUNT(r.rental_id) > 1
order by movies_rented;

--Query 2: List members who rented a specific movie
SELECT mem.name, mem.email, r.rental_date, r.return_date
FROM Rentals r
JOIN Members mem ON r.member_id = mem.member_id
JOIN Movies m ON r.movie_id = m.movie_id
WHERE m.title = 'Oppenheimer';

--Query 3: Count how many movies are available in each language (3 additional queries)
SELECT language, COUNT(movie_id) AS available_movies
FROM Movies
WHERE available = TRUE
GROUP BY language
ORDER BY available_movies DESC;

--Query 4:List all movies that are currently rented
SELECT title, director, language, genre
FROM Movies m
JOIN Rentals r ON m.movie_id = r.movie_id
WHERE r.return_date IS NULL;

--Query 5:List all rentals that are overdue
SELECT mem.name, m.title, r.rental_date
FROM Rentals r
JOIN Members mem ON r.member_id = mem.member_id
JOIN Movies m ON r.movie_id = m.movie_id
WHERE r.return_date IS NULL AND r.rental_date < '2025-10-25';


