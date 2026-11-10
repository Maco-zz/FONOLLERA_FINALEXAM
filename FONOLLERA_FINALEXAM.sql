CREATE DATABASE FONOLLERA_FINALEXAM;
USE FONOLLERA_FINALEXAM;

CREATE TABLE Profile (
    Profile_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    Age INT,
    Department VARCHAR(100),
    Position VARCHAR(100)
);

INSERT INTO Profile (Profile_ID, Name, Address, Age, Department, Position) VALUES
(101, 'Aeron kylle huerto', 'Manila, Philippines', 25, 'IT Department', 'Database Administrator'),
(102, 'Carl Carandang', 'Quezon City, Philippines', 29, 'Engineering', 'Software Engineer'),
(103, 'Alexandra Perez', 'Mandaluyong, Philippines', 22, 'IT Department', 'Support Specialist'),
(104, 'John Marco Fonollera', 'Makati, Philippines', 31, 'Human Resources', 'HR Manager'),
(105, 'Lebron James', 'Pasig, Philippines', 27, 'Engineering', 'System Analyst');

CREATE DATABASE FONOLLERA_FINALEXAM_RESTORED;
USE FONOLLERA_FINALEXAM_RESTORED;

CREATE TABLE Profile AS SELECT * FROM FONOLLERA_FINALEXAM.Profile;

ALTER TABLE Profile ADD PRIMARY KEY (Profile_ID);

ALTER TABLE Profile ADD Encrypted_Address VARBINARY(512);

SET SQL_SAFE_UPDATES = 0;

UPDATE Profile 
SET Encrypted_Address = AES_ENCRYPT(Address, 'MySecretKey123');

SELECT 
    Profile_ID,
    Name,
    CAST(AES_DECRYPT(Encrypted_Address, 'MySecretKey123') AS CHAR) AS Decrypted_Address,
    Age,
    Department,
    Position
FROM Profile
WHERE Profile_ID IN (102, 103);

SELECT 
    Profile_ID, 
    Name, 
    HEX(Encrypted_Address) AS Encrypted_Address, 
    Department, 
    Position 
FROM Profile;