#GROUP 970 Final Project Database Search Queries

USE veterinaryclinicdb;
SELECT @@version

# Update Operation with Neccessary Triggers ---------------------------------------------------------

DELIMITER //

CREATE TRIGGER BOOKING_UPDATE
BEFORE UPDATE 
ON booking
FOR EACH ROW
INSERT INTO comments (AnimalID, EntryDate, Comments, UCID) 
VALUES (New.AnimalID, DATE_FORMAT(NOW(), '%Y-%m-%d'), CONCAT('Booking ReturnDate changed for animal: ', NEW.ReturnDate), New.UCID); //

DELIMITER ;

--  DROP TRIGGER IF EXISTS BOOKING_UPDATE;

UPDATE booking SET ReturnDate = '2022-04-16' WHERE AnimalID = 1 AND BookingDate = '2021-12-11';

# Delete Operation with Neccessary Triggers ----------------------------------------------------------

DELIMITER //

CREATE PROCEDURE animal_deletion_cascade (IN ID_Animal int)
BEGIN
	DELETE FROM booking WHERE booking.AnimalID = ID_Animal;
	DELETE FROM comments WHERE comments.AnimalID = ID_Animal;
	DELETE FROM consultation WHERE consultation.AnimalID = ID_Animal;
	DELETE FROM images WHERE images.AnimalID = ID_Animal;
	DELETE FROM reminder WHERE reminder.AnimalID = ID_Animal;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER DELETE_ANIMAL_VIOLATION
AFTER DELETE 
ON animal
FOR EACH ROW 
BEGIN 
	CALL animal_deletion_cascade (OLD.AnimalID);
END; //

DELIMITER ;


DELETE FROM animal WHERE AnimalID = 1;


#Simple Retrieval Query --------------------------------------------------------------------

SELECT * FROM users;

# Ordered Retrieval Queries -----------------------------------------------------------------

# This query returns the bookings in chronological order for a particular animal
SELECT * FROM booking WHERE booking.animalID = 2 ORDER BY CONVERT (booking.BookingDate, date);

# Nested Retrieval Queries


# This nested query returns the animal types that are presecribed the two drugs shown below
SELECT AnimalType 
FROM animal 
WHERE animal.AnimalID IN 
( SELECT consultation.animalID 
FROM consultation 
WHERE (consultation.prescription = 'Amitriptyline' OR consultation.prescription = 'Enalapril '));



UPDATE booking 
SET BookingDate = date_add(BookingDate, interval 14 day)
WHERE AnimalID =
(SELECT AnimalID
FROM (SELECT AnimalID, COUNT(AnimalID) AS COUNT
FROM booking
GROUP BY AnimalID) AS CountTable
WHERE COUNT > 2);

# Retrieval Queries using Joined Tables

# This query uses an inner join between user and bookings to obtain how many times a particular occupancy have made bookings
SELECT Occupancy, COUNT(Occupancy) 
FROM users INNER JOIN booking ON users.UCID = booking.UCID 
GROUP BY Occupancy;





# Repository Class Queries in JAVA *********************************************************************************************

# User Queries -----------------------------------------------------------

SELECT * FROM users WHERE users.UCID = 10036030;

SELECT * FROM users;

INSERT INTO users (FName, LName, Email, Occupancy, UserStatus, UserPassword)
VALUES ('Olivia', 'Liam', 'OliviaLiam@ucalgary.ca', 'student', 'Pending', 'olivia');

UPDATE users SET UserStatus = 'Blocked' WHERE UCID = 10036032;

# Animal Queries ---------------------------------------------------------

SELECT * FROM veterinaryclinicdb.animal;

SELECT * FROM animal WHERE animal.Availability = 'Available';

SELECT * FROM animal WHERE animal.AnimalID = 2;

UPDATE animal SET Availability = 'Booked' WHERE animal.AnimalID = 2;

UPDATE animal SET AnimalStatus = 'Good' WHERE animal.AnimalID = 2;

DELETE FROM animal WHERE animal.AnimalID = 2;
INSERT INTO animal (AnimalID, AnimalName, Weight, TattooNum, BirthDate, AnimalType, AnimalStatus, Availability, Breed, Sex, CoatColor, RFID)
VALUES
('002', 'Lucy', '6', '234235', '2013-06-10', 'Cat', 'Requires Monitoring', 'Available', 'Persian', 'F', 'White', '83634863189');

INSERT INTO animal (AnimalID, AnimalName, Weight, TattooNum, BirthDate, AnimalType, AnimalStatus, Availability, Breed, Sex, CoatColor, RFID)
VALUES
('004', 'Bill', '2', '234237', '2014-05-21', 'Parrot', 'Requires Monitoring', 'Available', 'African', 'F', 'Red', '83634863190');


# Consultation Queries ---------------------------------------------------

SELECT * FROM consultation;

INSERT INTO CONSULTATION (AnimalID, ConsultationDate, Diagnosis, Treatment, Prescription, UCID)
VALUES
('002', '2021-12-12', 'Cannot Talk', 'Speech Therapy', 'Joshanda','10036035');

# Comment Queries --------------------------------------------------------

SELECT * FROM comments;

INSERT INTO COMMENTS (AnimalID, EntryDate, Comments, UCID)
VALUES
('002', '2021-12-12', 'Limping rear leg', '10036034');

# Image Queries ----------------------------------------------------------

SELECT * FROM images;

INSERT INTO IMAGES (AnimalID, ImagePath, UCID)
VALUES
('004','C:\Users\sheik\Pictures\Wallpapers\image4.jpg', '10036033');

# Booking Queries --------------------------------------------------------

SELECT * FROM booking;

SELECT * FROM booking WHERE booking.AnimalID = 1;

INSERT INTO BOOKING (AnimalID, BookingDate, ReturnDate, UCID)
VALUES
('002', '2021-12-12', '2022-01-22', '10036035');

DELETE FROM booking WHERE booking.animalID = 2 AND booking.BookingDate = '2021-12-12';
INSERT INTO BOOKING (AnimalID, BookingDate, ReturnDate, UCID)
VALUES
('002', '2021-12-18', '2022-01-22', '10036035');

DELETE FROM booking WHERE booking.animalID = 2 AND booking.BookingDate = '2021-12-18';

# Reminder Queries -------------------------------------------------------

SELECT * FROM reminder;

INSERT INTO REMINDER (AnimalID, EntryDate, ReminderDescription, DueDate, UCID)
VALUES
('002', '2021-12-12', 'Annual Checkup', '2022-12-12', '10036032');










