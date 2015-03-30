/*
Drop table Registration;
Drop table Viewing;
Drop table Client;
Drop table PropertyForRent;
Drop table PrivateOwner;
Drop table Staff;
Drop table Branch;
*/

--  Create all the necessary tables

CREATE TABLE Branch (
branchNo   CHAR(4) NOT NULL, 
street     VARCHAR2(25) NOT NULL, 
city       VARCHAR2(15) NOT NULL, 
postcode   VARCHAR2(8) NOT NULL, 
    PRIMARY KEY (branchNo)
);

CREATE TABLE Staff (
staffNo    varchar2(5) NOT NULL, 
fName      varchar2(15) NOT NULL, 
lName      varchar2(15) NOT NULL, 
Position  varchar2(10) NOT NULL, 
sex        CHAR(1)
           CONSTRAINT Staff_sexCHK
           CHECK (sex IN ('M','F')), 
DOB        DATE, 
salary     DECIMAL(9,2) NOT NULL, 
branchNo   CHAR(4) NOT NULL,
PRIMARY KEY (staffNo),
FOREIGN KEY (branchNo) 
    REFERENCES Branch(branchNo)
);

CREATE TABLE PropertyForRent (
propertyNo    varchar2(5) NOT NULL,
street        varchar2(255) NOT NULL,
city		  varchar2(255) NOT NULL,
postcode	  varchar2(10) NOT NULL,
type		  ENUM('House','Flat') NOT NULL,
rooms		  INTEGER(2) NOT NULL,
rent 		  INTEGER(4) NOT NULL,
PRIMARY KEY (propertyNo),
FOREIGN KEY (ownerNo)
	REFERENCES PrivateOwner(ownerNo),
FOREIGN KEY (staffNo)
	REFERENCES Staff(staffNo),
FOREIGN KEY (branchNo)
	REFERENCES Branch(branchNo)
);

CREATE TABLE Client (
clientNo	  varchar2(5) NOT NULL,
fName		  varchar2(15) NOT NULL,
lName		  varchar2(15) NOT NULL,
telNo		  varchar2(15) NOT NULL,
prefType	  ENUM('House','Flat') NOT NULL,
maxRent		  INTEGER(4) NOT NULL,
PRIMARY KEY (clientNo)
);

CREATE TABLE PrivateOwner (
ownerNo		  varchar2(5),
fName		  varchar2(15),
lName		  varchar2(15),
address		  varchar2(255),
telNo		  varchar(15),
PRIMARY KEY (ownerNo)
);

CREATE TABLE Viewing (
clientNo	  varchar2(5),
propertyNo 	  varchar2(5)
viewDate	  DATE,
comment		  TEXT,
FOREIGN KEY (clientNo) REFERENCES Client(clientNo),
FOREIGN KEY (propertyNo) REFERENCES PropertyForRent(propertyNo)
);