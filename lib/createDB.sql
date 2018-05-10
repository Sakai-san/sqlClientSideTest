CREATE TABLE IF NOT EXISTS Department(
     ID 								INTEGER PRIMARY KEY AUTOINCREMENT,
     Name 							VARCHAR(128) NOT NULL
);

 CREATE TABLE IF NOT EXISTS Project(
     ID								INTEGER PRIMARY KEY AUTOINCREMENT,
     Name							VARCHAR(128) NOT NULL,
     Start							DATE NOT NULL,
     End								DATE
);

CREATE TABLE IF NOT EXISTS Employee(
     ID								INTEGER PRIMARY KEY AUTOINCREMENT,
     First_name					VARCHAR(128) NOT NULL,
     Last_name						VARCHAR(128) NOT NULL,
     Start							DATE NOT NULL,
     End								DATE,
     Kids_number					INTEGER UNSIGNED,
     Salary							FLOAT UNSIGNED,
     Department_id				INTEGER REFERENCES Department(id) ON DELETE RESTRICT ON UPDATE RESTRICT
);

 CREATE TABLE IF NOT EXISTS Involvement(
     Employee_id	 				INTEGER REFERENCES Employee(ID) ON DELETE RESTRICT ON UPDATE RESTRICT,
     Project_id 					INTEGER REFERENCES Project(id) ON DELETE RESTRICT ON UPDATE RESTRICT,
     PRIMARY KEY (Employee_id, Project_id)
 );


 INSERT INTO Department(Name)
 VALUES
     ('Marketing'),
     ('Finance'),
     ('Sales'),
     ('IT');

 INSERT INTO Project(Name, Start, End)
 VALUES
     ('Alpha', '2010-03-01', NULL),
     ('Beta', '2014-05-01', NULL);

 INSERT INTO Employee(First_name, Last_name, Start, End, Kids_number, Salary, Department_id)
 VALUES
     ('Ryu', 'Tanaka', '2010-02-01',	'2012-12-31',	0,	30700.30, (SELECT ID FROM Department WHERE Name='Finance')  ),
     ('Ryoko', 'Sasaki', '2014-08-01', NULL,	1,	50900, (SELECT ID FROM Department WHERE Name='Sales')  ),
     ('Dimitri', 'Pavlovsky', '2007-05-01', NULL,	0,	61400.50, (SELECT ID FROM Department WHERE Name='Marketing')  ),
     ('Oleg', 'Grichkin', '2008-07-01', '2011-10-31', 3, 78000.80, (SELECT ID FROM Department WHERE Name='Sales')  );

 INSERT INTO Involvement( Employee_id, Project_id )
 VALUES
     ( (SELECT id FROM Employee WHERE First_name='Dimitri'), (SELECT ID FROM Project WHERE Name='Beta') ),

     ( (SELECT id FROM Employee WHERE First_name='Ryu'), (SELECT ID FROM Project WHERE Name='Beta') ),

     ( (SELECT id FROM Employee WHERE First_name='Ryoko'), (SELECT ID FROM Project WHERE Name='Beta') ),

     ( (SELECT id FROM Employee WHERE First_name='Ryoko'), (SELECT ID FROM Project WHERE Name='Alpha') );

CREATE TABLE IF NOT EXISTS Publisher(
   ID 								INTEGER PRIMARY KEY AUTOINCREMENT,
   Name 								VARCHAR(128) NOT NULL
);

CREATE TABLE IF NOT EXISTS Book(
   ID 								INTEGER PRIMARY KEY AUTOINCREMENT,
   Title 							VARCHAR(128) NOT NULL,
   Isbn 								VARCHAR(128) NOT NULL,
   Publication_Year 				INTEGER,
   Publisher_id 					INTEGER REFERENCES Publisher(ID) ON DELETE RESTRICT ON UPDATE RESTRICT
);

CREATE TABLE IF NOT EXISTS Author(
   ID 								INTEGER PRIMARY KEY AUTOINCREMENT,
   Last_name 						VARCHAR(128) NOT NULL,
   First_name 						VARCHAR(128) NOT NULL
);


CREATE TABLE IF NOT EXISTS Writing(
   Book_id 							INTEGER REFERENCES Book(ID) ON DELETE RESTRICT ON UPDATE RESTRICT,
   Author_id 						INTEGER REFERENCES Author(ID) ON DELETE RESTRICT ON UPDATE RESTRICT,
   PRIMARY KEY (Book_id, Author_id)
);

     INSERT INTO Publisher(Name)
     VALUES
     ('Presses polytechniques et universitaires romandes'),
     ("O'Reilly"),
     ('Technip'),
     ('Eyrolles'),
     ('Micro Application'),
     ('Packt'),
     ('CreateSpace');


     INSERT INTO Author( Last_name, First_name )
     VALUES
     ('Schumacher', 'Michael'),
     ('Faltings', 'Boi'),
     ('Maksay', 'Gabor'),
     ('Pigneur', 'Yves'),
     ('Milton', 'Michael'),
     ('Benedetti', 'Ryan'),
     ('Cranley', 'Ronan'),
     ('Ashworth', 'Stuart'),
     ('Duncan', 'Andrew'),
     ('Chuan', 'Shi'),
     ('Bloch', 'Laurent'),
     ('Wolfhugel', 'Christophe'),
     ('Deruelle', 'Laurent'),
     ('Shapiro', 'Jim');


     INSERT INTO Book(Title, Isbn, Publication_year, Publisher_id)
     VALUES
     ("L'intelligence artificielle par la pratique", '978-2-88074-764-0', 2009, (SELECT ID FROM Publisher WHERE Name='Presses polytechniques et universitaires romandes' ) ),
     ("Modéliser par l'exemple", '978-2-88074-895-1', 2010, (SELECT ID FROM Publisher WHERE Name='Presses polytechniques et universitaires romandes' )),
     ('Head First Data Analysis', '978-0-596-15393-9', 2009, (SELECT ID FROM Publisher WHERE Name="O'Reilly" )),
     ('Head First jQuery', '978-1-449-39321-2', 2011, (SELECT ID FROM Publisher WHERE Name="O'Reilly" )),
     ('Ext JS 4 Web Application Development Cookbook', '978-1-84951-686-0', 2012, (SELECT ID FROM Publisher WHERE Name='Packt' )),
     ('Mathematics in a nutshell', '498-0-098-00934-0', 2012, (SELECT ID FROM Publisher WHERE Name='Packt' )),
     ('HTML5 Mobile Development Cookbook', '978-1-84969-196-3', 2012, (SELECT ID FROM Publisher WHERE Name='Packt' )),
     ('Initiation à la programmation avec Scheme', '2-7108-0795-5', 2001, (SELECT ID FROM Publisher WHERE Name='Technip')),
     ('Sécurité informatique, Principes et méthode', '2-212-12021-4', 2007, (SELECT ID FROM Publisher WHERE Name='Eyrolles')),
     ('DirectX', '978-2742923540', 2002, (SELECT ID FROM Publisher WHERE Name='Micro Application')),
     ('Développement Java/J2EE avec JBuilder', '978-2212113464', 2003, (SELECT ID FROM Publisher WHERE Name='Eyrolles')),
     ('In Your Head', '978-1479357239', 2012, (SELECT ID FROM Publisher WHERE Name='CreateSpace'));


     INSERT INTO Writing(Book_id, Author_id)
     VALUES
     ( (SELECT ID FROM Book WHERE Title="L'intelligence artificielle par la pratique" ),(SELECT ID FROM Author WHERE Last_name='Schumacher' and First_name ='Michael' ) ),

     ( (SELECT ID FROM Book WHERE Title="L'intelligence artificielle par la pratique" ),(SELECT ID FROM Author WHERE Last_name='Faltings' and First_name ='Boi' ) ),

     ( (SELECT ID FROM Book WHERE Title="Modéliser par l'exemple" ),(SELECT ID FROM Author WHERE Last_name='Maksay' and First_name ='Gabor' ) ),

     ( (SELECT ID FROM Book WHERE Title="Modéliser par l'exemple" ),(SELECT ID FROM Author WHERE Last_name='Pigneur' and First_name ='Yves' ) ),

     ( (SELECT ID FROM Book WHERE Title='Head First Data Analysis' ),(SELECT ID FROM Author WHERE Last_name='Milton' and First_name ='Michael' ) ),

     ( (SELECT ID FROM Book WHERE Title='Head First jQuery' ),(SELECT ID FROM Author WHERE Last_name='Benedetti' and First_name ='Ryan' ) ),

     ( (SELECT ID FROM Book WHERE Title='Head First jQuery' ),(SELECT ID FROM Author WHERE Last_name='Cranley' and First_name ='Ronan' ) ),

     ( (SELECT ID FROM Book WHERE Title='Ext JS 4 Web Application Development Cookbook' ),(SELECT ID FROM Author WHERE Last_name='Ashworth' and First_name ='Stuart' ) ),

     ( (SELECT ID FROM Book WHERE Title='Ext JS 4 Web Application Development Cookbook' ),(SELECT ID FROM Author WHERE Last_name='Duncan' and First_name ='Andrew' ) ),

     ( (SELECT ID FROM Book WHERE Title='Mathematics in a nutshell' ),(SELECT ID FROM Author WHERE Last_name='Duncan' and First_name ='Andrew' ) ),

     ( (SELECT ID FROM Book WHERE Title='HTML5 Mobile Development Cookbook' ),(SELECT ID FROM Author WHERE Last_name='Chuan' and First_name='Shi' ) ),

     ( (SELECT ID FROM Book WHERE Title='Initiation à la programmation avec Scheme' ),(SELECT ID FROM Author WHERE Last_name='Bloch' and First_name='Laurent' ) ),

     ( (SELECT ID FROM Book WHERE Title='Sécurité informatique, Principes et méthode' ),(SELECT ID FROM Author WHERE Last_name='Bloch' and First_name ='Laurent' ) ),

     ( (SELECT ID FROM Book WHERE Title='Sécurité informatique, Principes et méthode' ),(SELECT ID FROM Author WHERE Last_name='Wolfhugel' and First_name ='Christophe' ) ),

     ( (SELECT ID FROM Book WHERE Title='DirectX' ),(SELECT ID FROM Author WHERE Last_name='Deruelle' and First_name='Laurent' ) ),

     ( (SELECT ID FROM Book WHERE Title='Développement Java/J2EE avec JBuilder' ),(SELECT ID FROM Author WHERE Last_name='Deruelle' and First_name ='Laurent' ) ),

     ( (SELECT ID FROM Book WHERE Title='In Your Head' ),(SELECT ID FROM Author WHERE Last_name='Shapiro' and First_name ='Jim' ) );

CREATE TABLE IF NOT EXISTS Worker(
	ID								INTEGER PRIMARY KEY AUTOINCREMENT,
	First_name					VARCHAR(128) NOT NULL,
	Last_name					VARCHAR(128) NOT NULL,
	Salary						FLOAT UNSIGNED,
	Boss_id						INTEGER REFERENCES Worker(ID) ON DELETE RESTRICT ON UPDATE RESTRICT,
	Department_id				INTEGER REFERENCES Department(ID) ON DELETE RESTRICT ON UPDATE RESTRICT
);


INSERT INTO Worker(First_name, Last_name, Salary, Boss_id, Department_id)
VALUES
-- big boss
('Eddy', 'Fisher', 100912.80, NULL, NULL);


INSERT INTO Worker(First_name, Last_name, Salary, Boss_id, Department_id)
VALUES
-- department chief
('Louise', 'Miller', 50900.97, (SELECT W.ID FROM Worker as W WHERE First_name = 'Eddy' AND Last_name = 'Fisher' ), (SELECT ID FROM Department WHERE Name = 'Finance' )),
('Deborah', 'Laporte', 80131.10, (SELECT W.ID FROM Worker as W WHERE First_name = 'Eddy' AND Last_name = 'Fisher' ), (SELECT ID FROM Department WHERE Name = 'Marketing' )),
('Thomas', 'Truman', 75000.40, (SELECT W.ID FROM Worker as W WHERE First_name = 'Eddy' AND Last_name = 'Fisher' ), (SELECT ID FROM Department WHERE Name = 'Sales' ));

-- subordinate
INSERT INTO Worker(First_name, Last_name, Salary, Boss_id, Department_id)
VALUES
('Gabriela', 'Henriquez', 60000.90, (SELECT W.ID FROM Worker as W WHERE First_name = 'Louise' AND Last_name = 'Miller' ), (SELECT ID FROM Department WHERE Name = 'Finance' )),
('Gwen', 'Richards', 39000.85, (SELECT W.ID FROM Worker as W WHERE First_name = 'Louise' AND Last_name = 'Miller' ), (SELECT ID FROM Department WHERE Name = 'Finance' )),

('Quentin', 'Travoli', 90800.85, (SELECT W.ID FROM Worker as W WHERE First_name = 'Deborah' AND Last_name = 'Laporte' ), (SELECT ID FROM Department WHERE Name = 'Marketing' )),

('Massimo', 'Cataldo', 72000.85, (SELECT W.ID FROM Worker as W WHERE First_name = 'Thomas' AND Last_name = 'Truman' ), (SELECT ID FROM Department WHERE Name = 'Sales' )),
('Claire', 'Walters', 30600.20, (SELECT W.ID FROM Worker as W WHERE First_name = 'Thomas' AND Last_name = 'Truman' ), (SELECT ID FROM Department WHERE Name = 'Sales' )),
('Oliver', 'Fisher', 27982.90, (SELECT W.ID FROM Worker as W WHERE First_name = 'Thomas' AND Last_name = 'Truman' ), (SELECT ID FROM Department WHERE Name = 'Sales' )),
('Katia', 'Stephens', 17124.90, (SELECT W.ID FROM Worker as W WHERE First_name = 'Thomas' AND Last_name = 'Truman' ), (SELECT ID FROM Department WHERE Name = 'Sales' ));


CREATE TABLE IF NOT EXISTS users(
  ID INTEGER PRIMARY KEY AUTOINCREMENT,
  user_login varchar(60) NOT NULL default '',
  user_pass varchar(64) NOT NULL default '',
  user_nicename varchar(50) NOT NULL default '',
  user_email varchar(100) NOT NULL default '',
  user_url varchar(100) NOT NULL default '',
  user_registered datetime NOT NULL default '0000-00-00 00:00:00',
  user_activation_key varchar(60) NOT NULL default '',
  user_status int(11) NOT NULL default '0',
  display_name varchar(250) NOT NULL default ''
);


CREATE TABLE IF NOT EXISTS posts(
  ID INTEGER PRIMARY KEY AUTOINCREMENT,
  post_author INTEGER NOT NULL default '0',
  post_date datetime NOT NULL default '0000-00-00 00:00:00',
  post_date_gmt datetime NOT NULL default '0000-00-00 00:00:00',
  post_content longtext NOT NULL,
  post_title text NOT NULL,
  post_excerpt text NOT NULL,
  post_status varchar(20) NOT NULL default 'publish',
  comment_status varchar(20) NOT NULL default 'open',
  ping_status varchar(20) NOT NULL default 'open',
  post_password varchar(20) NOT NULL default '',
  post_name varchar(200) NOT NULL default '',
  to_ping text NOT NULL,
  pinged text NOT NULL,
  post_modified datetime NOT NULL default '0000-00-00 00:00:00',
  post_modified_gmt datetime NOT NULL default '0000-00-00 00:00:00',
  post_content_filtered longtext NOT NULL,
  post_parent INTEGER NOT NULL default '0',
  guid varchar(255) NOT NULL default '',
  menu_order int(11) NOT NULL default '0',
  post_type varchar(20) NOT NULL default 'post',
  post_mime_type varchar(100) NOT NULL default '',
  comment_count bigint(20) NOT NULL default '0'
);


CREATE TABLE IF NOT EXISTS comments (
  comment_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  comment_post_ID INTEGER NOT NULL default '0',
  comment_author tinytext NOT NULL,
  comment_author_email varchar(100) NOT NULL default '',
  comment_author_url varchar(200) NOT NULL default '',
  comment_author_IP varchar(100) NOT NULL default '',
  comment_date datetime NOT NULL default '0000-00-00 00:00:00',
  comment_date_gmt datetime NOT NULL default '0000-00-00 00:00:00',
  comment_content text NOT NULL,
  comment_karma int(11) NOT NULL default '0',
  comment_approved varchar(20) NOT NULL default '1',
  comment_agent varchar(255) NOT NULL default '',
  comment_type varchar(20) NOT NULL default '',
  comment_parent INTEGER NOT NULL default '0',
  user_id INTEGER NOT NULL default '0'
);


CREATE TABLE IF NOT EXISTS likes (
  like_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  like_post_ID INTEGER NOT NULL default '0',
  like_author tinytext NOT NULL,
  like_author_email varchar(100) NOT NULL default '',
  like_author_IP varchar(100) NOT NULL default '',
  like_date datetime NOT NULL default '0000-00-00 00:00:00',
  like_date_gmt datetime NOT NULL default '0000-00-00 00:00:00',
  like_agent varchar(255) NOT NULL default '',
  user_id INTEGER NOT NULL default '0'
);



INSERT INTO `posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES

(37, 1, '2014-06-30 20:22:30', '2014-06-30 11:22:30', 'En informatique il est souvent nécessaire de pratiquer pour d''assimiler les différents concepts. Les exercices suivants couvrent les notions abordées dans la théorie.', 'SQL en pratique', '', 'publish', 'open', 'open', '', 'pratique-de-sql', '', '', '2015-01-06 20:19:43', '2015-01-06 11:19:43', '', 0, 'http://studybyyourself.com/?p=37', 13, 'post', '', 0),
(129, 1, '2014-07-04 11:16:25', '2014-07-04 02:16:25', 'Ce cours est destiné à quiconque s’intéresse au sujet. Il explique les divers concepts d''une manière aussi simple que possible. Aucune connaissance préalable n’est nécessaire.\r\n\r\nSont abordées, dans un premier temps, les notions d''entité, schéma de base de données, table, enregistrement, attribut, clé primaire, association, clé étrangère et typage de données.', 'Apprendre SQL', 'Sont abordés les notions de tables, d''enregistrement, de clé primaire, d''association, de clé étrangère et les requêtes SQL.', 'publish', 'open', 'open', '', 'apprendre-sql', '', '', '2015-02-19 20:29:34', '2015-02-19 11:29:34', '', 0, 'http://studybyyourself.com/?p=129', 11, 'post', '', 1),
(840, 1, '2014-10-09 19:27:08', '2014-10-09 10:27:08', 'This course is intended for anyone with an interest in SQL. No prerequisites are needed. Explanations are made as simple as possible.\r\n\r\nFirst, we are going to cover the concepts of entity, database schema, table, record, attribute, primary key, association, foreign key and data type.', 'Learn SQL', 'Topics include table, records, primary key, association, foreign key and SQL query.', 'publish', 'open', 'open', '', 'learn-sql', '', '', '2015-02-19 20:23:55', '2015-02-19 11:23:55', '', 0, 'http://studybyyourself.com/?p=840', 5, 'post', '', 20),
(922, 1, '2014-10-09 19:13:20', '2014-10-09 10:13:20', 'The practice plays an important role in understanding the concepts. Doing the following exercises may help the progress in learning SQL. All the studied concepts are covered.', 'Let''s practice SQL', '', 'publish', 'open', 'open', '', 'lets-pratice-sql', '', '', '2015-02-19 23:41:11', '2015-02-19 14:41:11', '', 0, 'http://studybyyourself.com/?p=922', 8, 'post', '', 0),
(2091, 1, '2015-01-16 09:29:35', '0000-00-00 00:00:00', 'Ce cours est destiné à quiconque s’intéresse au sujet. Il explique les divers concepts d''une manière aussi simple que possible. Aucune connaissance préalable n’est nécessaire.\r\n\r\nSont abordées les notions d''équations linéaires, de matrice, de vecteur, d''échelonnage, de dépendance linéaire, de déterminant, d''application linéaire, de diagonalisation et transformation linéaire.', 'Algèbre linéaire facilement', '', 'draft', 'open', 'open', '', '', '', '', '2015-01-16 09:29:35', '2015-01-16 00:29:35', '', 0, 'http://studybyyourself.com/?p=2091', 2, 'post', '', 0);



INSERT INTO `comments` (`comment_ID`, `comment_post_ID`, `comment_author`, `comment_author_email`, `comment_author_url`, `comment_author_IP`, `comment_date`, `comment_date_gmt`, `comment_content`, `comment_karma`, `comment_approved`, `comment_agent`, `comment_type`, `comment_parent`, `user_id`) VALUES
(1, 840, 'Quora', '', 'http://www.quora.com/SQL/What-are-some-videos-or-websites-to-learn-SQL-in-one-complete-day#ans9215858', '54.174.21.145', '2015-01-16 18:06:53', '2015-01-16 09:06:53', '<strong>What are some videos or websites to learn SQL in one complete day?</strong>\n\nI ve learnt SQL quickly on this website http://www.studybyyourself.com/learn-sql', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(2, 840, 'Quora', '', 'http://www.quora.com/Are-there-any-free-online-courses-to-learn-SQL#ans9229533', '54.173.233.254', '2015-01-17 10:04:44', '2015-01-17 01:04:44', '<strong>Are there any free online courses to learn SQL?</strong>\n\nA good resource for learning SQL quickly for beginners here : http://www.studybyyourself.com/learn-sql', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(3, 840, 'Quora', '', 'http://www.quora.com/Why-do-I-need-to-use-a-subquery-for-this-SQL-query-1#ans9229610', '54.173.233.254', '2015-01-17 10:12:01', '2015-01-17 01:12:01', '<strong>Why do I need to use a subquery for this SQL query?</strong>\n\nA good way to understand subqueries is to browse there : http://www.studybyyourself.com/learn-sql.', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(4, 840, 'Quora', '', 'http://www.quora.com/How-do-I-get-really-good-at-advanced-SQL#ans9248540', '54.164.39.112', '2015-01-18 11:45:46', '2015-01-18 02:45:46', '<strong>How do I get really good at advanced SQL?</strong>\n\nGo step by step. Concept after one other. Good resource on this purpose here. Http://www.studybyyourself.com/learn-sql', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(5, 840, 'Quora', '', 'http://www.quora.com/Which-are-the-best-introductory-courses-to-databases-e-g-SQL#ans9424046', '54.175.148.72', '2015-01-27 05:46:08', '2015-01-26 20:46:08', '<strong>Which are the best introductory courses to databases (e.g. SQL)?</strong>\n\nYou re likely in hurry, check out this online course for free. http://www.studybyyourself.com/learn-sql.', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(6, 840, 'Quora', '', 'http://www.quora.com/Where-can-i-get-a-lot-of-quality-sql-query-examples-to-learn-online#ans9448340', '54.88.177.171', '2015-01-28 07:19:13', '2015-01-27 22:19:13', '<strong>Where can i get a lot of quality sql query examples to learn online?</strong>\n\nYou can learn SQL through exemples and by practicing here http://www.studybyyourself.com/learn-sql', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(7, 840, 'Quora', '', 'http://www.quora.com/I-want-to-learn-more-than-just-basic-database-queries-Can-someone-guide-me-from-where-I-can-learn-complex-database-queries#ans9470851', '54.152.106.247', '2015-01-29 06:53:58', '2015-01-28 21:53:58', '<strong>I want to learn more than just basic database queries. Can someone guide me from where I can learn complex database queries?</strong>\n\nCheck this site. You can learn from easy query to difficult one. Http://www.studybyyourself.com/learn-sql', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(8, 840, 'Quora', '', 'http://www.quora.com/Is-there-a-Codecademy-equivalent-for-learning-how-to-query-databases#ans9470885', '54.152.67.32', '2015-01-29 06:56:20', '2015-01-28 21:56:20', '<strong>Is there a Codecademy equivalent for learning how to query databases?</strong>\n\nI learn to deal with queries here. Http://studybyyourself.com/learn-sql', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(9, 840, 'Quora', '', 'http://www.quora.com/What-is-the-best-and-quickest-way-to-learn-SQL-Books-courses-How-to-obtain-a-database-and-practice-on-a-home-computer-I-need-to-run-queries-extract-data-to-dump-into-Excel-etc-for', '54.152.126.9', '2015-01-29 06:59:03', '2015-01-28 21:59:03', '<strong>What is the best and quickest way to learn SQL? Books, courses? How to obtain a database and practice on a home computer? I need to run queries, extract data to dump into Excel, etc., for further analysis.</strong>\n\nIf you d like to learn quickly you can check here. Http://studybyyourself.com/learn-sql', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(10, 840, 'Quora', '', 'http://www.quora.com/What-is-the-best-book-to-learn-databases-for-a-Django-developer#ans9470991', '54.152.163.199', '2015-01-29 07:04:48', '2015-01-28 22:04:48', '<strong>What is the best book to learn databases for a Django developer?</strong>\n\nDjango uses a so-called ORM. So you do not need to do SQL query directly. However for complex queries it s easier to write SQL (this latter is standardized). You can learn here. http:///www.studybyyourself.com/learn-sql', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(11, 840, 'Quora', '', 'http://www.quora.com/PostgreSQL/What-are-some-good-tutorials-for-learning-to-write-SQL-queries-preferably-in-a-postgres-Ruby-environment#ans9495105', '54.152.166.215', '2015-01-30 09:50:38', '2015-01-30 00:50:38', '<strong>What are some good tutorials for learning to write SQL queries (preferably in a postgres/Ruby environment)?</strong>\n\nFirst of all, the environment your code runs on is independent to the way your data are stored (data persistence), since you are likely to use an engine for fetching data. If you are willing to learn SQL quickly, check out this resource down here. http&#8230;', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(12, 840, 'Quora', '', 'http://www.quora.com/What-are-some-good-books-online-tutorials-for-self-teaching-DBMS#ans9520398', '54.84.221.18', '2015-01-31 12:48:38', '2015-01-31 03:48:38', '<strong>What are some good books / online tutorials for self-teaching DBMS?</strong>\n\nActually you need to know SQL first since some manipulation (creation, insertion, deletion, drop, grant, etc) for setting up you database can be done through SQL queries. You can learn some basics about SQL here. http://www.studybyyourself.com/learn-sq&#8230;', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(13, 840, 'Quora', '', 'http://www.quora.com/What-are-the-best-online-sources-from-which-to-learn-databases#ans9520776', '54.86.34.150', '2015-01-31 13:16:38', '2015-01-31 04:16:38', '<strong>What are the best online sources from which to learn databases?</strong>\n\nGood resource if you d like to have a practical way to learn. http://www.studybyyourself.com/learn-sql.', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(14, 840, 'Quora', '', 'http://www.quora.com/Where-can-I-learn-SQL-online-and-Where-can-I-practice-for-the-same#ans9520833', '54.152.92.62', '2015-01-31 13:20:51', '2015-01-31 04:20:51', '<strong>Where can I learn SQL online and Where can I practice for the same?</strong>\n\nTutorial with examples, exercises and course for beginners. http://www.studybyyourself.com/learn-sql.', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(15, 840, 'Quora', '', 'http://www.quora.com/What-are-best-online-links-for-learning-SQL-right-from-very-basic-level#ans9525497', '54.152.186.221', '2015-01-31 19:28:37', '2015-01-31 10:28:37', '<strong>What are best online links for learning SQL right from very basic level?</strong>\n\nHere basics with exercises online. For beginners. Http://www.studybyyourself.com/learn-sql', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(16, 840, 'Quora', '', 'http://www.quora.com/What-are-the-basics-required-to-learn-SQL#ans9537623', '54.152.233.11', '2015-02-01 11:11:02', '2015-02-01 02:11:02', '<strong>What are the basics required to learn SQL?</strong>\n\nOnly thing you need is to understand the concept of set. You can learn by yourself easily. SQL is very very popular and will be so for a long time because it s mathematically well designed. Here an introduction http://www.studybyyourself.com/learn-sql.', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(17, 840, 'Quora', '', 'http://www.quora.com/Oracle/What-is-the-best-book-to-purchase-for-learning-SQL#ans9537918', '54.152.211.45', '2015-02-01 11:40:04', '2015-02-01 02:40:04', '<strong>What is the best book to purchase for learning SQL?</strong>\n\nYou better try to learn online. Takes less time and you can directly pratctice. More interactive, namely you can switch from course to exercise quickly. Try this resource. Http://www.studybyyourself.com/learn-sql', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(18, 840, 'Quora', '', 'http://www.quora.com/Which-books-are-good-and-easy-to-understand-for-learning-SQL-completely-from-beginner#ans9537953', '54.164.253.58', '2015-02-01 11:43:04', '2015-02-01 02:43:04', '<strong>Which books are good and easy to understand for learning SQL completely from beginner?</strong>\n\nOnly thing you need to know is the concept of set. For beginners here http://www.studybyyourself.com/learn-sql', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(19, 840, 'Quora', '', 'http://www.quora.com/What-is-the-best-book-to-learn-some-general-SQL-queries-for-a-begginer#ans9736777', '52.0.96.211', '2015-02-10 17:36:55', '2015-02-10 08:36:55', '<strong>What is the best book to learn some general SQL queries for a begginer?</strong>\n\nTry this out http://www.studybyyourself.com/learn-sql.', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),
(20, 840, 'Quora', '', 'http://www.quora.com/How-can-I-start-learning-about-RDBMS-or-SQL#ans9736872', '54.164.39.112', '2015-02-10 17:42:08', '2015-02-10 08:42:08', '<strong>How can I start learning about RDBMS or SQL?</strong>\n\nBest resources : W3Schools Online Web Tutorials http://dev.mysql.com/doc/ http://www.studybyyourself.com/learn-sql', 0, '1', 'Python-urllib/2.7', 'trackback', 0, 0),

(21, 129, 'studybyyourselfSQL avancé avec des exemples et des exercices en ligne', '', 'http://studybyyourself.com/apprendre-sql-avance/', '50.62.160.232', '2015-02-18 09:53:01', '2015-02-18 00:53:01', '[&#8230;] Ce cours est destiné à quiconque s’intéresse au sujet. Il explique les divers concepts d&#8217;une manière aussi simple que possible. Il est toutefois nécessaire d&#8217;avoir suivi le cours de base disponible ici. [&#8230;]', 0, '1', 'The Incutio XML-RPC PHP Library -- WordPress/4.1', 'pingback', 0, 0);


INSERT INTO `likes` (`like_ID`, `like_post_ID`, `like_author`, `like_author_email`, `like_author_IP`, `like_date`, `like_date_gmt`, `like_agent`, `user_id`) 
VALUES
(1, 840, 'Quora', '', '54.174.21.145', '2015-01-16 18:06:53', '2015-01-16 09:06:53', 'Python-urllib/2.7', 0),
(2, 840, 'Quora', '', '54.173.233.254', '2015-01-17 10:04:44', '2015-01-17 01:04:44', 'Python-urllib/2.7', 0),
(3, 840, 'Quora', '', '54.173.233.254', '2015-01-17 10:12:01', '2015-01-17 01:12:01', 'Python-urllib/2.7', 0),
(4, 37, 'Quora', '',  '54.152.186.221', '2015-01-31 19:28:37', '2015-01-31 10:28:37', 'Python-urllib/2.7', 0),
(5, 37, 'Quora', '',  '54.152.233.11', '2015-02-01 11:11:02', '2015-02-01 02:11:02',  'Python-urllib/2.7', 0),
(6, 129, 'Quora', '', '54.164.39.112', '2015-02-10 17:42:08', '2015-02-10 08:42:08',  'Python-urllib/2.7', 0);
