DROP DATABASE IF EXISTS veterinaryclinicdb;
CREATE DATABASE veterinaryclinicdb; 
USE veterinaryclinicdb;

DROP TABLE IF EXISTS ANIMAL;
CREATE TABLE ANIMAL (
	AnimalID				integer	not null AUTO_INCREMENT,
	AnimalName				varchar(45),
	Weight					integer,
	TattooNum				integer,
    BirthDate				varchar(45),
    AnimalType				varchar(45),
    AnimalStatus			varchar(45),
    Availability			varchar(45),
    Breed					varchar(45),
    Sex						varchar(45),
    CoatColor				varchar(45),
    RFID					varchar(45),
	primary key (AnimalID)
);

INSERT INTO ANIMAL (AnimalID, AnimalName, Weight, TattooNum, BirthDate, AnimalType, AnimalStatus, Availability, Breed, Sex, CoatColor, RFID)
VALUES
('001', 'Simon', '35', '234234', '2017-08-14', 'Dog', 'Good', 'Booked', 'Beagle', 'M', 'Red', '83612863189'),
('002', 'Lucy', '6', '234235', '2013-06-10', 'Cat', 'Requires Monitoring', 'Available', 'Persian', 'F', 'White', '83634863189'),
('003', 'Sam', '127', '234236', '2010-06-07', 'Cow', 'Urgent Attention Required', 'Available', 'Abigar', 'M', 'Dark Brown', '83634865789'),
('004', 'bill', '10', '234237', '2014-06-014', 'Cat', 'Requires Monitoring', 'Available', 'Bengal', 'F', 'Spotted golden', '83504865789'),
('005', 'simba', '12', '234238', '2020-01-01', 'Cat', 'Good', 'Available', 'Sphynx', 'M', 'Grey White', '72634865789'),
('006', 'Jonny', '30', '234239', '2018-01-13', 'Dog', 'Requires Monitoring', 'Available', 'Husky', 'M', 'Grey White', '72634861089'),
('007', 'Limba', '6', '234240', '2017-05-04', 'Cat', 'Good', 'Available', 'Scottish', 'F', 'Grey White', '72633865789');

DROP TABLE IF EXISTS USERS;
CREATE TABLE USERS (
	UCID					integer	not null AUTO_INCREMENT,
	FName					varchar(45),
	LName					varchar(45),
	Email					varchar(45),
    Occupancy				varchar(45),
    UserStatus				varchar(45),
    UserPassword			varchar(45),
	primary key (UCID)
);

INSERT INTO USERS (UCID, FName, LName, Email, Occupancy, UserStatus, UserPassword)
VALUES
('10036030', 'Billy', 'Bob', 'BillyBob@ucalgary.ca', 'Admin', 'Current', 'billy'),
('10036031', 'John', 'Smith', 'JohnSmith@ucalgary.ca', 'Health Technician', 'Current', 'john'),
('10036032', 'Ryan', 'Drake', 'RyanDrake@ucalgary.ca', 'Teaching Technician', 'Current', 'ryan'),
('10036033', 'Chad', 'Roberts', 'ChadRoberts@ucalgary.ca', 'Attendant', 'Current', 'chad'),
('10036034', 'Brad', 'Downey', 'BradDowney@ucalgary.ca', 'Student', 'Current', 'brad'),
('10036035', 'Lad', 'Fisher', 'LadFisher@ucalgary.ca', 'Attendant', 'Current', 'lad'),
('10036036', 'Steven', 'Burks', 'StevenBurks@ucalgary.ca', 'Attendant', 'Current', 'steven'),
('10036037', 'Liam', 'Holtz', 'LiamHoltz@ucalgary.ca', 'Attendant', 'Pending', 'liam');

DROP TABLE IF EXISTS IMAGES;
CREATE TABLE IMAGES (
	AnimalID				integer	not null,
    ImagePath				varchar(60) not null,
	UCID					integer	not null,
	primary key (AnimalID, ImagePath),
    foreign key (UCID) references USERS(UCID)
);

INSERT INTO IMAGES (AnimalID, ImagePath, UCID)
VALUES
('001','C:\Users\sheik\Pictures\Wallpapers\image1.jpg', '10036030'),
('001', 'C:\Users\sheik\Pictures\Wallpapers\image2.jpg', '10036030'),
('003', 'C:\Users\sheik\Pictures\Wallpapers\image3.jpg', '10036030');

DROP TABLE IF EXISTS REMINDER;
CREATE TABLE REMINDER (
	AnimalID				integer	not null,
	EntryDate				varchar(45) not null,
	ReminderDescription		varchar(45) not null,
	DueDate					varchar(45),
	UCID					integer	not null,
	primary key (AnimalID, EntryDate, ReminderDescription),
    foreign key (UCID) references USERS(UCID)
);

INSERT INTO REMINDER (AnimalID, EntryDate, ReminderDescription, DueDate, UCID)
VALUES
('001', '2021-12-11', 'Vaccination', '2021-12-30', '10036033');


DROP TABLE IF EXISTS COMMENTS;
CREATE TABLE COMMENTS (
	AnimalID				integer	not null,
	EntryDate				varchar(45) not null,
	Comments				varchar(60) not null,
	UCID					integer	not null,
	primary key (AnimalID, EntryDate, Comments),
    foreign key (UCID) references USERS(UCID)
);

INSERT INTO COMMENTS (AnimalID, EntryDate, Comments, UCID)
VALUES
('001', '2021-12-11', 'Animal Breathing heavily', '10036033');


DROP TABLE IF EXISTS BOOKING;
CREATE TABLE BOOKING (
	AnimalID				integer	not null,
	BookingDate				varchar(45) not null,
	ReturnDate				varchar(60),
	UCID					integer	not null,
	primary key (AnimalID, BookingDate),
    foreign key (UCID) references USERS(UCID)
);

INSERT INTO BOOKING (AnimalID, BookingDate, ReturnDate, UCID)
VALUES
('001', '2021-12-11', '2022-01-20', '10036033'),
('003', '2022-02-10', '2022-05-20', '10036032'),
('003', '2022-06-10', '2022-07-20', '10036033'),
('003', '2022-08-10', '2022-09-20', '10036033'),
('002', '2022-02-07', '2022-03-20', '10036035'),
('001', '2022-03-15', '2022-03-20', '10036034'),
('002', '2022-02-14', '2022-04-20', '10036033');


DROP TABLE IF EXISTS CONSULTATION;
CREATE TABLE CONSULTATION (
	AnimalID				integer	not null,
	ConsultationDate		varchar(45) not null,
	Diagnosis				varchar(60),
	Treatment				varchar(60),
	Prescription			varchar(60),
	UCID					integer	not null,
	primary key (AnimalID, ConsultationDate),
    foreign key (UCID) references USERS(UCID)
);

INSERT INTO CONSULTATION (AnimalID, ConsultationDate, Diagnosis, Treatment, Prescription, UCID)
VALUES
('001', '2021-12-02', 'Broken Paws', 'Cast', ' ','10036033'),
('004', '2021-12-04', 'Stomach Flu', 'Medication', 'Acepromazine ','10036033'),
('003', '2021-12-08', 'Depression', 'Medication', 'Amitriptyline','10036033'),
('004', '2021-12-09', 'Diabetes', 'Medication', 'Enalapril ','10036033'),
('007', '2021-12-10', 'Kidney Desease', 'Medication', ' Enalapril','10036033'),
('007', '2021-12-13', 'Heart Papilations', 'Medication', ' Enalapril','10036033');










