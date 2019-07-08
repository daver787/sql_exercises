-- 1)Create a new file called 3.4_select_exercises.sql. Do your work for this exercise in that file.
-- 2)Use the albums_db database
USE albums_db;
-- 3) Explore the structure of the albums table.
DESCRIBE albums;
/*  4) Write queries to find the following information.
The name of all albums by Pink Floyd
The year Sgt. Pepper's Lonely Hearts Club Band was released
The genre for the album Nevermind
Which albums were released in the 1990s
Which albums had less than 20 million certified sales
All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"? */
SELECT * FROM albums;
SELECT name FROM albums WHERE artist='Pink Floyd';
SELECT release_date from albums WHERE name='Sgt. Pepper''s Lonely Hearts Club Band';
SELECT genre FROM albums WHERE name='Nevermind';
SELECT name,release_date FROM albums WHERE release_date BETWEEN 1990 and 1999;
SELECT name,sales FROM albums WHERE sales<20.0;
SELECT name,genre FROM albums WHERE genre='Rock';
