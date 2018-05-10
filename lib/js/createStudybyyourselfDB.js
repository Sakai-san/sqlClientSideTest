var studybyyourselfDB =
    `CREATE TABLE IF NOT EXISTS Department(
        ID							INTEGER PRIMARY KEY AUTOINCREMENT,
        Name						VARCHAR(128) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS Project(
        ID							INTEGER PRIMARY KEY AUTOINCREMENT,
        Name						VARCHAR(128) NOT NULL,
        Start						DATE NOT NULL,
        End							DATE
    );

    CREATE TABLE IF NOT EXISTS Employee(
        ID							INTEGER PRIMARY KEY AUTOINCREMENT,
        First_name					VARCHAR(128) NOT NULL,
        Last_name					VARCHAR(128) NOT NULL,
        Start						DATE NOT NULL,
        End							DATE,
        Kids_number					INTEGER UNSIGNED,
        Salary						FLOAT UNSIGNED,
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
            ID						INTEGER PRIMARY KEY AUTOINCREMENT,
            Name					VARCHAR(128) NOT NULL
        );

        CREATE TABLE IF NOT EXISTS Book(
            ID						INTEGER PRIMARY KEY AUTOINCREMENT,
            Title					VARCHAR(128) NOT NULL,
            Isbn					VARCHAR(128) NOT NULL,
            Publication_Year		INTEGER,
            Publisher_id			INTEGER REFERENCES Publisher(ID) ON DELETE RESTRICT ON UPDATE RESTRICT
        );

        CREATE TABLE IF NOT EXISTS Author(
            ID						INTEGER PRIMARY KEY AUTOINCREMENT,
            Last_name 				VARCHAR(128) NOT NULL,
            First_name 				VARCHAR(128) NOT NULL
        );


        CREATE TABLE IF NOT EXISTS Writing(
            Book_id	 				INTEGER REFERENCES Book(ID) ON DELETE RESTRICT ON UPDATE RESTRICT,
            Author_id				INTEGER REFERENCES Author(ID) ON DELETE RESTRICT ON UPDATE RESTRICT
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
    `;