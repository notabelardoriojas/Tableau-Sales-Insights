/*Making a table*/
CREATE TABLE groceries (id INTEGER PRIMARY KEY, name TEXT, quantity INTEGER, aisle INTEGER);

/*Inserting values*/
INSERT INTO groceries VALUES(1, "Apples", 4, 7);
INSERT INTO groceries VALUES(2, "Bananas", 8, 12);
INSERT INTO groceries VALUES(3, "Cucumber", 2, 2);
INSERT INTO groceries VALUES(4, "Durian", 2, 2);
INSERT INTO groceries VALUES(5, "Eggplant", 1, 5);
INSERT INTO groceries VALUES(6, "Fig", 10, 2);
/*Prints table*/
SELECT * FROM groceries;

/*Making another table with float values*/
CREATE TABLE books (id INTEGER PRIMARY KEY, name TEXT, rating REAL);

INSERT INTO books VALUES(1, "1984", 4.5);
INSERT INTO books VALUES(2, "Do Andriods Dream of Electric Sheep", 4.9);
INSERT INTO books VALUES(3, "Hamlet", 2.1);

/*Prints only the name column*/
SELECT name FROM books;

/*Prints first table, ordered by aisle number*/
SELECT * FROM groceries ORDER BY aisle;
/*Prints first table, ordered by aisle number, but only aisle smaller than 6*/
SELECT * FROM groceries WHERE aisle < 6 ORDER BY aisle;

/*More tables, movies this time*/
/*First we print all the movies, and then filter out those released before 2000 and sort them*/
CREATE TABLE movies (id INTEGER PRIMARY KEY, name TEXT, release_year INTEGER);
INSERT INTO movies VALUES (1, "Avatar", 2009);
INSERT INTO movies VALUES (2, "Titanic", 1997);
INSERT INTO movies VALUES (3, "Star Wars: Episode IV - A New Hope", 1977);
INSERT INTO movies VALUES (4, "Shrek 2", 2004);
INSERT INTO movies VALUES (5, "The Lion King", 1994);
INSERT INTO movies VALUES (6, "Disney's Up", 2009);
SELECT * FROM movies;
SELECT * FROM movies WHERE release_year > 2000 ORDER BY release_year;

/*Back to groceries, doing aggregatiion of the quantity number*/

/*Prints sum and max of quantity*/
SELECT SUM(quantity) FROM groceries;
SELECT MAX(quantity) FROM groceries;

/*Quantity sum by aisle, make sure that in the select clause you select by the same variable you're grouping by*/
SELECT aisle, SUM(quantity) FROM groceries GROUP BY aisle;

/*To-do list*/
CREATE TABLE todo_list (id INTEGER PRIMARY KEY, item TEXT, minutes REAL);
INSERT INTO todo_list VALUES (1, "Wash the dishes", 15);
INSERT INTO todo_list VALUES (2, "Vacuuming", 20);
INSERT INTO todo_list VALUES (3, "Play guitar", 30);
INSERT INTO todo_list VALUES (4, "Watch LOTR Trilogy Director's Cut Version", 686);
/*Print number of hours to accomplish tasks*/
SELECT SUM(minutes)/60 FROM todo_list;

/*Project: Store Database (Records Store)*/

CREATE TABLE records_store (id INTEGER PRIMARY KEY, album_name TEXT, artist TEXT, length_min INTEGER, price REAL);

INSERT INTO records_store VALUES(1, "Songs in the Key of Life", "Stevie Wonder", 104, 19.99);
INSERT INTO records_store VALUES(2, "Discovery", "Daft Punk", 60, 39.99);
INSERT INTO records_store VALUES(3, "1999", "Prince", 70, 19.99);
INSERT INTO records_store VALUES(4, "OK Computer", "Radiohead", 53, 29.99);
INSERT INTO records_store VALUES(5, "Abbey Road", "The Beatles", 47, 10.99);
INSERT INTO records_store VALUES(6, "Blonde", "Frank Ocean", 60, 49.99);
INSERT INTO records_store VALUES(7, "Trout Mask Replica", "Captain Beefheart & His Magic Band", 78, 99.99);
INSERT INTO records_store VALUES(8, "The Philosophy of the World", "The Shaggs", 31, 999.99);
INSERT INTO records_store VALUES(9, "Yeezus", "Kanye West", 40, 29.99);
INSERT INTO records_store VALUES(10, "If You're Reading This It's Too Late", "Drake", 68, 10.99);
INSERT INTO records_store VALUES(11, "Happier Than Ever", "Billie Eilish", 65, 29.99);
INSERT INTO records_store VALUES(12, "Stranger In The Alps", "Phoebe Bridgers", 44, 19.99);
INSERT INTO records_store VALUES(13, "Flower Boy", "Tyler, The Creator", 46, 29.99);
INSERT INTO records_store VALUES(14, "The New Abnormal", "The Strokes", 45, 9.99);
INSERT INTO records_store VALUES(15, "Planet Her", "Doja Cat", 44, 10.99);


SELECT album_name FROM records_store ORDER BY length_min;

SELECT album_name, artist, MAX(price) FROM records_store;


