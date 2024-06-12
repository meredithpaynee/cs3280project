create database phase_3;

use phase_3;

##Database created using MySQL as the RDBMS

create table Library_User(
	Card_Num bigint primary key NOT NULL,
    Phone_Num bigint,
    First_Name char(25),
    Last_Name char(25)
);

create table Titles_Borrowed(
	Card_Num bigint, 
    foreign key (Card_Num) references Library_User(Card_Num),
    Report_Num bigint, 
    foreign key (Report_Num) references Report(Report_Num),
    Title char(100)
);

create table Library_Admin(
	Employee_Num bigint primary key NOT NULL,
    First_Name char(25),
    Last_Name char(25)
);

create table Report(
	Report_Num bigint primary key auto_increment,
    Card_Num bigint,
	foreign key (Card_Num) references Library_User(Card_Num),
    Title char(100),
    ISBN bigint,
    foreign key (ISBN) references Book(ISBN),
    Return_Date date, 
    Employee_Num bigint,
	foreign key (Employee_Num) references Library_Admin(Employee_Num)
);

create table Publisher(
	Publisher_ID bigint primary key NOT NULL,
    Publisher_Name char(25)
);

create table Book(
	ISBN bigint primary key NOT NULL,
    Num_Total int,
    Num_Available int,
    Author char(50),
    Title char(100),
    Publisher_ID bigint,
    foreign key (Publisher_ID) references Publisher(Publisher_ID)
);

create table Placement(
    bISBN bigint,
	foreign key (bISBN) references Book(ISBN),
    Shelf_Num int,
    Category char(25),
    Floor_Num int
);

create table Creates_Report(
	Employee_Num bigint, 
	foreign key (Employee_Num) references Library_Admin(Employee_Num),
    Card_Num bigint,
    foreign key (Card_Num) references Library_User(Card_Num),
    ISBN bigint,
    foreign key (ISBN) references Book(ISBN)
);

create table Contacts_Publisher(
	Employee_Num bigint, 
	foreign key (Employee_Num) references Library_Admin(Employee_Num),
    Publisher_ID bigint,
    foreign key (Publisher_ID) references Publisher(Publisher_ID)
);

create table Publishes(
	ISBN bigint, 
	foreign key (ISBN) references Book(ISBN),
    Publisher_ID bigint, 
    foreign key (Publisher_ID) references Publisher(Publisher_ID)
);

create table Reserves(
	Card_Num bigint,
    foreign key (Card_Num) references Library_User(Card_Num),
    Employee_Num bigint,
    foreign key (Employee_Num) references Library_Admin(Employee_Num),
    ISBN bigint,
    foreign key (ISBN) references Book(ISBN),
    Return_Date date
);

INSERT INTO Library_User (Card_Num, Phone_Num, First_Name, Last_Name) VALUES
(784329, '2125551234', 'John', 'Doe'),
(502176, '3104346789', 'Jane', 'Smith'),
(931845, '7137872468', 'Michael', 'Johnson'),
(365924, '3059349876', 'Emily', 'Brown'),
(608713, '2067214321', 'David', 'Taylor');

INSERT INTO Titles_Borrowed (Card_Num, Title) VALUES
(784329, 'Introduction to Database Systems'),
(784329, 'Data Structures and Algorithms'),
(502176, 'Programming in Python'),
(931845, 'Artificial Intelligence'),
(365924, 'Web Development Basics');

INSERT INTO Library_Admin (Employee_Num, First_Name, Last_Name) VALUES
(101, 'Adam', 'Clark'),
(102, 'Sarah', 'Wilson'),
(103, 'Ryan', 'Miller'),
(104, 'Laura', 'Davis'),
(105, 'Kevin', 'Martinez');

INSERT INTO Report (Report_Num, Card_Num, Title, ISBN, Return_Date, Employee_Num) VALUES
(default, 784329, 'Introduction to Database Systems', 1234567890, '2024-05-05', 101),
(default, 784329, 'Data Structures and Algorithms', 0678901234, '2024-05-15', 105),
(default, 502176, 'Programming in Python', 1345678901, '2024-05-07', 102),
(default, 931845, 'Artificial Intelligence', 0456789012, '2024-05-10', 103),
(default, 365924, 'Web Development Basics', 1567890123, '2024-05-12', 104);

INSERT INTO Publisher (Publisher_ID, Publisher_Name) VALUES
(1001, 'Pearson'),
(1002, 'OReilly Media'),
(1003, 'Springer'),
(1004, 'McGraw Hill'),
(1005, 'Wiley');

INSERT INTO Book (ISBN, Num_Total, Num_Available, Author, Title, Publisher_ID) VALUES
(1234567890, 5, 3, 'Abraham Silberschatz', 'Introduction to Database Systems', 1001),
(1345678901, 4, 2, 'Mark Lutz', 'Programming in Python', 1002),
(0456789012, 3, 2, 'Stuart Russell and Peter Norvig', 'Artificial Intelligence', 1003),
(1567890123, 7, 4, 'Jon Duckett', 'Web Development Basics', 1004),
(0678901234, 5, 2, 'Thomas H. Cormen', 'Data Structures and Algorithms', 1005);

INSERT INTO Placement (bISBN, Shelf_Num, Category, Floor_Num) VALUES
(1234567890, 1, 'Educational', 2),
(1345678901, 2, 'Computer Science', 1),
(0456789012, 3, 'Computer Science', 3),
(1567890123, 4, 'Tutorial', 1),
(0678901234, 5, 'Computer Science', 2);

INSERT INTO Creates_Report (Employee_Num, Card_Num, ISBN) VALUES
(101, 784329, 1234567890),
(102, 502176, 1345678901),
(103, 931845, 0456789012),
(104, 365924, 1567890123),
(105, 784329, 0678901234);

INSERT INTO Contacts_Publisher (Employee_Num, Publisher_ID) VALUES
(101, 1001),
(102, 1002),
(103, 1003),
(104, 1004),
(105, 1005);

INSERT INTO Publishes (ISBN, Publisher_ID) VALUES
(1234567890, 1001),
(1345678901, 1002),
(0456789012, 1003),
(1567890123, 1004),
(0678901234, 1005);

INSERT INTO Reserves (Card_Num, Employee_Num, ISBN, Return_Date) VALUES
(784329, 101, 1234567890, '2024-05-08'),
(502176, 102, 1345678901, '2024-05-10'),
(931845, 103, 0456789012, '2024-05-12'),
(365924, 104, 1567890123, '2024-05-14'),
(784329, 105, 0678901234, '2024-05-16');

SELECT * FROM Book;
