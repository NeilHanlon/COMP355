INSERT INTO Branch (branchNo, street, city, postcode) VALUES ('B005','22 Deer Rd','London','SW1 4EH');
INSERT INTO Branch (branchNo, street, city, postcode) VALUES ('B007','16 Argyll St','Aberdeen','AB2 3SU');
INSERT INTO Branch (branchNo, street, city, postcode) VALUES ('B003','163 Main St','Glasgow','G11 9QX');
INSERT INTO Branch (branchNo, street, city, postcode) VALUES ('B004','32 Manse Rd','Bristol','BS99 1NZ');
INSERT INTO Branch (branchNo, street, city, postcode) VALUES ('B002','56 Clover Dr','London','NW10 6EU');
SELECT branchNo, street, city, postcode from Branch;

INSERT INTO Staff (staffNo,fName,lName,position,sex,DOB,salary,branchNo) VALUES ('SL21','John','White','Manager','M',TO_DATE('1-Oct-45'),30000,'B005');
INSERT INTO Staff (staffNo,fName,lName,position,sex,DOB,salary,branchNo) VALUES ('SG37','Ann','Beech','Assistant','F',TO_DATE('10-Nov-60'),12000,'B003');
INSERT INTO Staff (staffNo,fName,lName,position,sex,DOB,salary,branchNo) VALUES ('SG14','David','Ford','Supervisor','M',TO_DATE('24-Mar-58'),18000,'B003');
INSERT INTO Staff (staffNo,fName,lName,position,sex,DOB,salary,branchNo) VALUES ('SA9','Mary','Howe','Assistant','F',TO_DATE('19-Feb-70'),9000,'B005');
INSERT INTO Staff (staffNo,fName,lName,position,sex,DOB,salary,branchNo) VALUES ('SG5','Susan','Brand','Manager','F',TO_DATE('3-Jun-40'),24000,'B003');
INSERT INTO Staff (staffNo,fName,lName,position,sex,DOB,salary,branchNo) VALUES ('SL41','Julia','Lee','Assistant','F',TO_DATE('13-Jun-65'),9000,'B005');
SELECT * FROM Staff;

INSERT INTO PrivateOwner (ownerNo,fName,lName,address,telNo) VALUES ('CO46','Joe','Keogh','2 Fergus Dr, Aberdeen AB2 7SX','01224-861212');
INSERT INTO PrivateOwner (ownerNo,fName,lName,address,telNo) VALUES ('CO87','Aline','Stewart','6 Achray St, Glasgow G32 9DX','0141-357-7419');
INSERT INTO PrivateOwner (ownerNo,fName,lName,address,telNo) VALUES ('CO40','Tina','Murphy','63 Well St, Glasgow G42','0141-943-1728');
INSERT INTO PrivateOwner (ownerNo,fName,lName,address,telNo) VALUES ('CO93','Tony','Shaw','12 Park Pl, Glasgow G4 0QR','0141-225-7025');
SELECT * FROM PrivateOwner;

INSERT INTO PropertyForRent (propertyNo,street,city,postcode,type,rooms,rent,ownerNo,staffNo,branchNo) VALUES ('PA14','16 Holhead','Aberdeen','AB7 5SU','House',6,650,'CO46','SA9','B007');
INSERT INTO PropertyForRent (propertyNo,street,city,postcode,type,rooms,rent,ownerNo,staffNo,branchNo) VALUES ('PL94','6 Argyll St','London','NW2','Flat',4,400,'CO87','SL41','B005');
INSERT INTO PropertyForRent (propertyNo,street,city,postcode,type,rooms,rent,ownerNo,staffNo,branchNo) VALUES ('PG4','6 Lawrance St','Glasgow','G11 (QX','Flat',3,350,'CO40',NULL,'B003');
INSERT INTO PropertyForRent (propertyNo,street,city,postcode,type,rooms,rent,ownerNo,staffNo,branchNo) VALUES ('PG36','2 Manor Rd','Glasgow','G32 4QX','Flat',3,375,'CO93','SG37','B003');
INSERT INTO PropertyForRent (propertyNo,street,city,postcode,type,rooms,rent,ownerNo,staffNo,branchNo) VALUES ('PG21','18 Dale Rd','Glasgow','G12','House',5,600,'CO87','SG37','B003');
INSERT INTO PropertyForRent (propertyNo,street,city,postcode,type,rooms,rent,ownerNo,staffNo,branchNo) VALUES ('PG16','5 Novar Dr','Glasgow','G12 9AX','Flat',4,450,'C093','SG14','B003');
SELECT * FROM PropertyForRent;

INSERT INTO Client (clientNo,fName,lName,telNo,prefType,maxRent) VALUES ('CR76','John','Kay','0207-774-5632','Flat',425);
INSERT INTO Client (clientNo,fName,lName,telNo,prefType,maxRent) VALUES ('CR56','Aline','Stewart','0141-848-1825','Flat',350);
INSERT INTO Client (clientNo,fName,lName,telNo,prefType,maxRent) VALUES ('CR74','Mike','Ritchie','01475-392178','House',750);
INSERT INTO Client (clientNo,fName,lName,telNo,prefType,maxRent) VALUES ('CR62','Mary','Tregear','01224-196720','Flat',600);
SELECT * FROM Client;

INSERT INTO 