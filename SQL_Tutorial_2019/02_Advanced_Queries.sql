/*AUTOINCREMENT means we don't have to type in the id anymore, nice!*/
CREATE TABLE exercise_logs
    (id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT,
    minutes INTEGER, 
    calories INTEGER,
    heart_rate INTEGER);

/*By doing insert into then (variable1, variable2, ....) we can just fill in the columns we want to*/
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("biking", 30, 100, 110);
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("biking", 10, 30, 105);
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("dancing", 15, 200, 120);

/*Which exercises do I burn more than 50 calories doing?*/
SELECT * FROM exercise_logs WHERE calories > 50 ORDER BY calories;

/*Which exercises do I burn more than 50 calories, and take less than 30 minutes (most efficient)*/

SELECT * FROM exercise_logs WHERE calories > 50 AND minutes < 30;

/*Most vigorous exercises*/
SELECT * FROM exercise_logs WHERE calories > 50 OR heart_rate > 100;


/*Karaoke song selector*/
CREATE TABLE songs (
    id INTEGER PRIMARY KEY,
    title TEXT,
    artist TEXT,
    mood TEXT,
    duration INTEGER,
    released INTEGER);
    
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Bohemian Rhapsody", "Queen", "epic", 60, 1975);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Let it go", "Idina Menzel", "epic", 227, 2013);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("I will survive", "Gloria Gaynor", "epic", 198, 1978);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Twist and Shout", "The Beatles", "happy", 152, 1963);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("La Bamba", "Ritchie Valens", "happy", 166, 1958);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("I will always love you", "Whitney Houston", "epic", 273, 1992);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Sweet Caroline", "Neil Diamond", "happy", 201, 1969);
INSERT INTO songs (title, artist, mood, duration, released)
    VALUES ("Call me maybe", "Carly Rae Jepsen", "happy", 193, 2011);
    
SELECT title FROM songs;
SELECT title FROM songs WHERE released > 1990 OR mood = "epic";
SELECT title FROM songs WHERE duration < 240 AND mood = "epic" AND released > 1990;

/*Using the IN and NOT IN commands*/
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("tree climbing", 30, 70, 90);
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("tree climbing", 25, 72, 80);
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("rowing", 30, 70, 90);
INSERT INTO exercise_logs(type, minutes, calories, heart_rate) VALUES ("hiking", 60, 80, 85);


/*Bad! Do not do this*/
SELECT * FROM exercise_logs WHERE type = "biking" OR type = "hiking" OR type = "tree climbing" OR type = "rowing";

/* IN for outdoor activities */
SELECT * FROM exercise_logs WHERE type IN ("biking", "hiking", "tree climbing", "rowing");

/*NOT IN for indoor activities*/
SELECT * FROM exercise_logs WHERE type NOT IN ("biking", "hiking", "tree climbing", "rowing");

/*Doctor reccomended activities*/
CREATE TABLE drs_favorites
    (id INTEGER PRIMARY KEY,
    type TEXT,
    reason TEXT);


INSERT INTO drs_favorites(type, reason) VALUES ("biking", "Improves endurance and flexibility.");
INSERT INTO drs_favorites(type, reason) VALUES ("hiking", "Increases cardiovascular health.");

SELECT type FROM drs_favorites;

/*Using subqueires to see which activities in the exercise log are in the doctor reccomended activities*/
SELECT * FROM exercise_logs WHERE type IN (
    SELECT type FROM drs_favorites);

/*The seocnd line is the same as line 81, so we're selecting from the results of THAT query*/


/*Now we have two tables that relate to each other, let's make them kiss!*/
CREATE TABLE artists (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    country TEXT,
    genre TEXT);

INSERT INTO artists (name, country, genre)
    VALUES ("Taylor Swift", "US", "Pop");
INSERT INTO artists (name, country, genre)
    VALUES ("Led Zeppelin", "US", "Hard rock");
INSERT INTO artists (name, country, genre)
    VALUES ("ABBA", "Sweden", "Disco");
INSERT INTO artists (name, country, genre)
    VALUES ("Queen", "UK", "Rock");
INSERT INTO artists (name, country, genre)
    VALUES ("Celine Dion", "Canada", "Pop");
INSERT INTO artists (name, country, genre)
    VALUES ("Meatloaf", "US", "Hard rock");
INSERT INTO artists (name, country, genre)
    VALUES ("Garth Brooks", "US", "Country");
INSERT INTO artists (name, country, genre)
    VALUES ("Shania Twain", "Canada", "Country");
INSERT INTO artists (name, country, genre)
    VALUES ("Rihanna", "US", "Pop");
INSERT INTO artists (name, country, genre)
    VALUES ("Guns N' Roses", "US", "Hard rock");
INSERT INTO artists (name, country, genre)
    VALUES ("Gloria Estefan", "US", "Pop");
INSERT INTO artists (name, country, genre)
    VALUES ("Bob Marley", "Jamaica", "Reggae");

CREATE TABLE songs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    artist TEXT,
    title TEXT);

INSERT INTO songs (artist, title)
    VALUES ("Taylor Swift", "Shake it off");
INSERT INTO songs (artist, title)
    VALUES ("Rihanna", "Stay");
INSERT INTO songs (artist, title)
    VALUES ("Celine Dion", "My heart will go on");
INSERT INTO songs (artist, title)
    VALUES ("Celine Dion", "A new day has come");
INSERT INTO songs (artist, title)
    VALUES ("Shania Twain", "Party for two");
INSERT INTO songs (artist, title)
    VALUES ("Gloria Estefan", "Conga");
INSERT INTO songs (artist, title)
    VALUES ("Led Zeppelin", "Stairway to heaven");
INSERT INTO songs (artist, title)
    VALUES ("ABBA", "Mamma mia");
INSERT INTO songs (artist, title)
    VALUES ("Queen", "Bicycle Race");
INSERT INTO songs (artist, title)
    VALUES ("Queen", "Bohemian Rhapsody");
INSERT INTO songs (artist, title)
    VALUES ("Guns N' Roses", "Don't cry");
    

/*Which songs are Queen songs?*/
SELECT title from SONGS where artist="Queen";

/*Which artists are pop artists?*/
SELECT name from artists where genre = 'Pop';

/*Display song and artist name from songs table that are pop artist from the artist table*/
SELECT title, artist from SONGS where artist IN (SELECT name from artists where genre = 'Pop');

/*Back to the exercise logs, lets use aggregation and groups to figure out the number of calories by activity*/

SELECT type, SUM(calories) AS total_cal from exercise_logs GROUP BY type;
/*AS keyword renames the sum column*/

/*Of those groups which has a total_cal above 150?*/
SELECT type, SUM(calories) AS total_cal from exercise_logs GROUP BY type HAVING total_cal > 150;

/*Use HAVING keyword here, identical to WHERE but for aggregated data*/

/*Using HAVING keyword again, this time to find which exercises we've done more than 2 times*/

SELECT type from exercise_logs GROUP BY type HAVING COUNT(*) >= 2;


/*Authors with over 1 million total words from database of books*/

CREATE TABLE books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    author TEXT,
    title TEXT,
    words INTEGER);
    
INSERT INTO books (author, title, words)
    VALUES ("J.K. Rowling", "Harry Potter and the Philosopher's Stone", 79944);
INSERT INTO books (author, title, words)
    VALUES ("J.K. Rowling", "Harry Potter and the Chamber of Secrets", 85141);
INSERT INTO books (author, title, words)
    VALUES ("J.K. Rowling", "Harry Potter and the Prisoner of Azkaban", 107253);
INSERT INTO books (author, title, words)
    VALUES ("J.K. Rowling", "Harry Potter and the Goblet of Fire", 190637);
INSERT INTO books (author, title, words)
    VALUES ("J.K. Rowling", "Harry Potter and the Order of the Phoenix", 257045);
INSERT INTO books (author, title, words)
    VALUES ("J.K. Rowling", "Harry Potter and the Half-Blood Prince", 168923);
INSERT INTO books (author, title, words)
    VALUES ("J.K. Rowling", "Harry Potter and the Deathly Hallows", 197651);

INSERT INTO books (author, title, words)
    VALUES ("Stephenie Meyer", "Twilight", 118501);
INSERT INTO books (author, title, words)
    VALUES ("Stephenie Meyer", "New Moon", 132807);
INSERT INTO books (author, title, words)
    VALUES ("Stephenie Meyer", "Eclipse", 147930);
INSERT INTO books (author, title, words)
    VALUES ("Stephenie Meyer", "Breaking Dawn", 192196);
    
INSERT INTO books (author, title, words)
    VALUES ("J.R.R. Tolkien", "The Hobbit", 95022);
INSERT INTO books (author, title, words)
    VALUES ("J.R.R. Tolkien", "Fellowship of the Ring", 177227);
INSERT INTO books (author, title, words)
    VALUES ("J.R.R. Tolkien", "Two Towers", 143436);
INSERT INTO books (author, title, words)
    VALUES ("J.R.R. Tolkien", "Return of the King", 134462);
    
/*Interesting note, scientific notation works same as python, neat*/
SELECT author, SUM(words) AS total_words FROM books GROUP BY author HAVING total_words > 1e6;

/*Authors with an average word count per book over 150,000*/
SELECT author, avg(words) as avg_words FROM books group by author HAVING avg_words > 1.5e5;

/*Back to exercise logs, this time we use the CASE statement to make groups based on a criteria (kind of like an if statement)*/
SELECT COUNT(*) FROM exercise_logs WHERE heart_rate > 220 - 30;

/* 50-90% of max*/
SELECT COUNT(*) FROM exercise_logs WHERE
    heart_rate >= ROUND(0.50 * (220-30)) 
    AND  heart_rate <= ROUND(0.90 * (220-30));
    
/* CASE statement*/
SELECT type, heart_rate,
    CASE 
        WHEN heart_rate > 220-30 THEN "danger zone, don't die!"
        WHEN heart_rate > ROUND(0.90 * (220-30)) THEN "above good hr zone"
        WHEN heart_rate > ROUND(0.50 * (220-30)) THEN "within good hr zone"
        ELSE "below good hr zone"
    END as "hr_zone"
FROM exercise_logs
GROUP BY hr_zone;



/*Gradebook assignment*/
CREATE TABLE student_grades (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    number_grade INTEGER,
    fraction_completed REAL);
    
INSERT INTO student_grades (name, number_grade, fraction_completed)
    VALUES ("Winston", 90, 0.805);
INSERT INTO student_grades (name, number_grade, fraction_completed)
    VALUES ("Winnefer", 95, 0.901);
INSERT INTO student_grades (name, number_grade, fraction_completed)
    VALUES ("Winsteen", 85, 0.906);
INSERT INTO student_grades (name, number_grade, fraction_completed)
    VALUES ("Wincifer", 66, 0.7054);
INSERT INTO student_grades (name, number_grade, fraction_completed)
    VALUES ("Winster", 76, 0.5013);
INSERT INTO student_grades (name, number_grade, fraction_completed)
    VALUES ("Winstonia", 82, 0.9045);

select name, number_grade, ROUND(fraction_completed*100) AS percent_completed from student_grades;

/*Number of students by grade*/
select COUNT(*),
    CASE
        WHEN number_grade > 90 THEN "A"
        WHEN number_grade > 80 THEN "B"
        WHEN number_grade > 70 THEN "C"
        ELSE "F"
    END as "letter_grade"
from student_grades group by letter_grade;

/*Data dig, performing analysis on solar system objects*/
/* Put your data in here and query it! */
/* 
Solar system objects
Adapted from: http://en.wikipedia.org/wiki/List_of_Solar_System_objects_by_size
Collected by: https://www.khanacademy.org/profile/patrick809/programs
*/
CREATE TABLE solar_system_objects(
  body TEXT
, mean_radius NUMERIC         /* km */
, mean_radius_rel NUMERIC     /* relative to earth */
, volume NUMERIC              /* 10^9 km^3 */
, volume_rel NUMERIC          /* relative to earth */
, mass NUMERIC                /* 10^21 kg */
, mass_rel NUMERIC            /* relative to earth */
, density NUMERIC             /* g/cm^3 */
, surface_gravity NUMERIC     /* m/s^2 */
, surface_gravity_rel NUMERIC /* relative to earth */
, type_of_object TEXT
, shape TEXT
);
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Sun',696342,109.3,1414300000,1305700,1988550000,333000,1.408,274,28.02,'star','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Jupiter',69911,10.97,1431280,1321,1898600,317.83,1.326,24.79,2.535,'planet (gas giant) has rings','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Saturn',58232,9.14,827130,764,568460,95.159,0.687,10.445,1.06,'planet (gas giant) has rings','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Uranus',25362,3.98,68340,63.1,86832,14.536,1.27,8.87,0.9,'planet (ice giant) has rings','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Neptune',24622,3.86,62540,57.7,102430,17.147,1.638,11.15,1.14,'planet (ice giant) has rings','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Earth',6371,1,1083.21,1,5973.60,1,5.514,9.78033,0.99732,'planet (terrestrial)','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Venus',6051.8,0.95,928.43,0.857,4868.50,0.815,5.243,8.872,0.905,'planet (terrestrial)','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Mars',3389.5,0.532,163.18,0.151,641.85,0.107,3.9335,3.7,0.38,'planet (terrestrial)','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Ganymede',2634.1,0.413,76.3,0.0704,148.2,0.0248,1.936,1.428,0.15,'satellite of Jupiter','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Titan ',2576,0.404,71.52,0.066,134.5,0.0225,1.8798,1.354,0.14,'satellite of Saturn','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Mercury',2439.7,0.383,60.83,0.0562,330.2,0.0553,5.427,3.7,0.38,'planet (terrestrial)','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Callisto',2410.3,0.378,58.65,0.0541,107.6,0.018,1.8344,1.23603,0.126,'satellite of Jupiter','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Io',1821.6,0.286,25.32,0.0234,89.3,0.015,3.528,1.797,0.183,'satellite of Jupiter','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Moon',1737.1,0.273,21.958,0.0203,73.5,0.0123,3.3464,1.625,0.166,'satellite of Earth','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Europa',1560.8,0.245,15.93,0.0147,48,0.00803,3.013,1.316,0.134,'satellite of Jupiter','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Triton ',1353.4,0.212,10.38,0.0096,21.5,0.00359,2.061,0.782,0.0797,'satellite of Neptune','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('PlutoR',1184,0.185,7,0.0066,13.105,0.0022,2.03,0.61,0.062,'dwarf planet plutino multiple','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('ErisR',1163,0.182,7,0.007,16.7,0.0027,2.52,0.662,0.0677,'dwarf planet SDO binary','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Titania ',788.4,0.124,2.06,0.0019,3.526,0.00059,1.711,0.378,0.0385,'satellite of Uranus','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Rhea ',763.8,0.12,1.87,0.0017,2.3166,0.00039,1.236,0.26,0.027,'satellite of Saturn','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Oberon ',761.4,0.12,1.85,0.0017,3.014,0.0005,1.63,0.347,0.035,'satellite of Uranus','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Iapetus ',734.5,0.113,1.55,0.0014,1.9739,0.00033,1.088,0.223,0.0227,'satellite of Saturn','round (not in technical HE)');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('MakemakeR',715,NULL,1.7,NULL,NULL,NULL,2.3,NULL,NULL,'dwarf planet cubewano','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ("2007 OR10",640,0.1,1.0981,0.00101,NULL,NULL,NULL,NULL,NULL,'resonant KBO (3:10)','unknown');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('HaumeaR',620,0.117,1.3,0.001,4.006,0.00069,2.55,0.44,0.045,'dwarf planet resonant KBO (7:12) trinary','round (scalene ellipsoid)');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Charon ',603.5,0.095,0.87,0.0008,1.52,0.00025,1.65,0.279,0.028,'satellite of Pluto','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Umbriel ',584.7,0.092,0.84,0.0008,1.2,0.0002,1.39,0.234,0.024,'satellite of Uranus','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Ariel  ',578.9,0.091,0.81,0.0008,1.35,0.00022,1.66,0.269,0.027,'satellite of Uranus','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Dione ',561.4,0.088,0.73,0.0007,1.096,0.000183,1.478,0.232,0.0236,'satellite of Saturn','round (not in technical HE)');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Quaoar',555,NULL,NULL,NULL,1.4,0.0003,2.2,0.125,NULL,'cubewano binary','unknown');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Tethys ',531.1,0.083,0.624,0.0006,0.6173,0.000103,0.984,0.145,0.015,'satellite of Saturn','round');
INSERT INTO solar_system_objects(body,mean_radius,mean_radius_rel,volume,volume_rel,mass,mass_rel,density,surface_gravity,surface_gravity_rel,type_of_object,shape) VALUES ('Ceres ',476.2,0.076,0.437,0.0004,0.95,0.000159,2.077,0.27,0.0275,'dwarf planet belt asteroid','round');

SELECT * from solar_system_objects;

SELECT body, max(surface_gravity) AS "maximum surface gravity" from solar_system_objects;

SELECT type_of_object, avg(surface_gravity) AS "avg_surface_gravity" from solar_system_objects group by type_of_object order by type_of_object;

select type_of_object, avg(mass) as "average mass" from solar_system_objects group by type_of_object;

select type_of_object,
    CASE
        WHEN avg(mass) > 1e3 THEN "Large"
        WHEN avg(mass) > 1e2 THEN "Medium"
        ELSE "Small"
    END as "Mass groups"
from solar_system_objects
group by type_of_object 






