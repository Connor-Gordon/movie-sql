-- Select all columns and rows from the movies table

SELECT *
FROM `movies`; 

-- Select only the title and id of the first 10 rows

SELECT `id`, `title`
FROM `movies`
LIMIT 10;

-- Find the movie with the id of 485

SELECT `title`
FROM `movies`
WHERE `id` = 485;

-- Find the id (only that column) of the movie Made in America (1993)

SELECT `id`
FROM `movies`
WHERE `title` = "Made in America (1993)";

-- Find the first 10 sorted alphabetically

SELECT *
FROM `movies`
WHERE `id` > 0 AND `id` < 11
ORDER BY `title`;

-- Find all movies from 2002

SELECT *
FROM `movies`
WHERE `title` LIKE '%2002%';

-- Find out what year the Godfather came out (1972)

SELECT `title`
FROM `movies`
WHERE `title` LIKE '%Godfather%';

-- Without using joins find all the comedies

SELECT *
FROM `movies`
WHERE `genres` LIKE '%Comedy%';

-- Find all comedies in the year 2000

SELECT *
FROM `movies`
WHERE `genres` LIKE '%Comedy%' AND `title` LIKE '%2000%';

-- Find any movies that are about death and are a comedy

SELECT *
FROM `movies`
WHERE `genres` LIKE '%Comedy%' AND `title` LIKE '%death%';

-- Find any movies from either 2001 or 2002 with a title containing super

SELECT *
FROM `movies`
WHERE `title` LIKE '%super%' AND (`title` LIKE '%2002%' or `title` LIKE '%2001%');

-- Create a new table called actors (We are going to pretend the actor can only play in one movie). The table should include name, character name, foreign key to movies and date of birth at least plus an id field.

CREATE TABLE `actors` (
  `id` int(11) DEFAULT NULL,
  `c_name` varchar(255) DEFAULT NULL,
  `a_name` varchar(255) DEFAULT NULL,
  `f_key` varchar(255) DEFAULT NULL,
  `dob` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Pick 3 movies and create insert statements for 10 actors each. You should use the multi value insert statements

INSERT INTO `actors` 
	(c_name, a_name, f_key, dob)
VALUE 
	('Jesus', 'John', 'idk1', 12/25/2001),
	('Mary', 'John', 'idk2', 12/15/1990),
	('Joseph', 'Joe', 'idk3', 12/15/1991),
	('Jack', 'Joey', 'idk4', 12/15/1992),
	('Teya', 'Josh', 'idk5', 12/15/1989),
	('Eddie', 'Joshua', 'idk6', 12/15/1987),
	('Kevin', 'Jared', 'idk7', 12/15/1989),
	('Garret', 'Jock', 'idk8', 12/15/1993),
	('Sucely', 'Jquan', 'idk9', 12/15/1994),
	('Karsten', 'J', 'idk10', 12/15/1872);
	
-- Create a new column in the movie table to hold the MPAA rating. UPDATE 5 different movies to their correct rating

ALTER TABLE `movies`
ADD COLUMN mpaa_rating int(6) NOT NULL;

UPDATE `movies`
SET `mpaa_rating` = 'G'
WHERE id = 1;

UPDATE `movies`
SET `mpaa_rating` = 'PG'
WHERE id = 2;

UPDATE `movies`
SET `mpaa_rating` = 'PG-13'
WHERE id = 3;

UPDATE `movies`
SET `mpaa_rating` = 'R'
WHERE id = 4;

UPDATE `movies`
SET `mpaa_rating` = 'PG'
WHERE id = 5;

-- WITH JOINS

-- Find all the ratings for the movie Godfather, show just the title and the rating

SELECT *
FROM `movies`
WHERE `title` LIKE '%Godfather%';

UPDATE `movies`
SET `mpaa_rating` = 'R'
WHERE id = 858;

UPDATE `movies`
SET `mpaa_rating` = 'R'
WHERE id = 1221;

UPDATE `movies`
SET `mpaa_rating` = 'R'
WHERE id = 2023;

-- Im an idiot, didnt realize there was another table named ratings, just added those mpaa rating fer nothin but Im leaving what I did up there

SELECT m.title, r.rating 
FROM `movies` m
LEFT JOIN `ratings` r ON r.movie_id = m.id
WHERE `title` LIKE '%godfather%';

-- Order the previous objective by newest to oldest

SELECT m.title, r.rating, r.timestamp
FROM `movies` m
LEFT JOIN `ratings` r ON r.movie_id = m.id
WHERE `title` LIKE '%godfather%'
ORDER BY r.timestamp ASC;

-- Find the comedies from 2005 and get the title and imdbid from the links table

SELECT m.title, l.imdb_Id
FROM `movies` m
LEFT JOIN `links` l ON l.movie_id = m.id
WHERE `title` LIKE '%2005%' AND `genres` LIKE '%comedy%';

-- Find all movies that have no ratings

SELECT m.title, r.rating 
FROM `movies` m
LEFT JOIN `ratings` r ON r.movie_id = m.id
WHERE `rating` = null;

-- Get the average rating for a movie

SELECT avg(r.rating)
FROM `movies` m
LEFT JOIN `ratings` r ON r.movie_id = m.id
WHERE m.id = '1';

-- Get the total ratings for a movie

SELECT COUNT(r.rating)
FROM `movies` m
LEFT JOIN `ratings` r ON r.movie_id = m.id
WHERE m.id = '2';

-- Get the total movies for a genre

SELECT COUNT(m.genres)
FROM `movies` m
LEFT JOIN `ratings` r ON r.movie_id = m.id
WHERE `genres` LIKE '%comedy%';

-- Get the average rating for a user

SELECT avg(r.rating)
FROM `movies` m
LEFT JOIN `ratings` r ON r.movie_id = m.id
WHERE r.user_id = '6';

-- Find the user with the most ratings

SELECT 
