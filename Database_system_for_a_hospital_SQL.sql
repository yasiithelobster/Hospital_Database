-- Creating the Database
create database GVH_created_by_2425476_20230724_Athauda;

-- use the newly created database to proceed
USE GVH_created_by_2425476_20230724_Athauda;


-- creating the Guardian table
create table Guardian
(GuardianID int (15),
GuardianFname varchar (50) not null,
GuardianLname varchar (50) not null,
GuardianContactNumber varchar (15) UNIQUE not null,
CONSTRAINT G_ID_pk primary key (GuardianID));


-- creating the In_patient table
create table In_patient
(PatientID int(15),
PatientFname varchar (50) not null,
PatientLname varchar(50) not null,
DateOfBirth date not null,
Patient_NIC_Number varchar(20) unique,
BloodGroup varchar(5),
DateAdmitted date not null,
TimeAdmitted time not null,
Gender varchar (10),
DateDischarged date,
TimeDischarged time,
GuardianID int(15),
CONSTRAINT IN_Patient_ID PRIMARY key (PatientID),
CONSTRAINT G_ID_FK FOREIGN key (GuardianID) REFERENCES Guardian(GuardianID));


-- creating the Out_patient table
CREATE table out_patient
(PatientID int(15),
PatientFname varchar (50) not null,
PatientLname varchar (50) not null,
DateOfBirth date not null,
ContactNumber varchar (15),
CONSTRAINT Out_p_ID_pk primary key (PatientID));


-- creating the Payment table
create table Payment
(PaymentID int (15),
PaymentType varchar (20) not null,
Amount decimal (10,2),
PaidDate date not null,
PaidTime time not null,
In_patient_ID int(15),
Out_patient_ID int (15),
CONSTRAINT Pay_ID primary key (PaymentID),
CONSTRAINT In_Pat_pay_ID foreign key (In_patient_ID) REFERENCES In_patient(PatientID),
CONSTRAINT Out_Pat_pay_ID foreign key (Out_patient_ID) REFERENCES out_patient(PatientID));


-- creating the Ward table
create table Ward
(WardNumber int(15),
WardType varchar (20) not null,
Available_beds_count int (5),
BedCapacity int (5) not null,
CONSTRAINT W_no_PK PRIMARY key (WardNumber));


-- creating the Room table
create table Room
(RoomNumber int(15),
RoomType varchar (20)not null,
WardNumber int (15),
CONSTRAINT R_no_PK primary key (RoomNumber),
CONSTRAINT W_no_FK FOREIGN key (WardNumber) REFERENCES Ward(WardNumber));


-- creating the In_patient_Room_allocation table
CREATE TABLE In_patient_Room_allocation
(PatientID int(15) not null,
RoomNumber int(15) not null,
DateAllocated date not null,
CONSTRAINT PK_P_room PRIMARY key (PatientID,RoomNumber,DateAllocated),
CONSTRAINT IN_P_ID_FK FOREIGN key (PatientID) REFERENCES In_patient(PatientID),
CONSTRAINT R_no_FK FOREIGN key (RoomNumber) REFERENCES Room(RoomNumber));


-- creating the Medical_care table
create table Medical_care
(MedicalCareID int(15),
Diagnosed_medical_condition varchar (100) not null,
Type_of_treatment_admitted varchar (100) not null,
Prescribed_medications varchar (100) not null,
dosage varchar (100)not null,
CONSTRAINT Med_ID_PK primary key (MedicalCareID));


-- creating the Doctor table 
create table Doctor
(DoctorID int(15),
DoctorFname varchar(50) not null,
DoctorLname varchar(50) not null,
DoctorContactNumber varchar(15),
Specialization varchar(50) not null,
Classification varchar (50) not null,
Availability varchar (50) not null,
Date_joined_with_GVH date not null,
CONSTRAINT Doc_ID_PK primary key (DoctorID));


-- creating the Treatment table
create table treatment 
(PatientID int (15),
MedicalCareID int(15),
DoctorID int(15),
DateTreated date not null,
CONSTRAINT treat_ID PRIMARY key (PatientID,MedicalCareID,DoctorID),
CONSTRAINT pat_treat FOREIGN key (PatientID) REFERENCES In_patient(PatientID),
CONSTRAINT Med_treat FOREIGN key (MedicalCareID) REFERENCES Medical_care(MedicalCareID),
CONSTRAINT doc_treat foreign key (DoctorID) REFERENCES Doctor(DoctorID));


-- creating the Appointment table
create table Appointment
(AppointmentNumber int (15),
Appointment_Date date not null,
Appointment_time time not null,
CONSTRAINT App_no primary key (AppointmentNumber));


-- creating the Scheduled table
create table scheduled
(PatientID int(15),
DoctorID int(15),
AppointmentNumber int(15),
CONSTRAINT Schedule_PK primary key (PatientID, DoctorID, AppointmentNumber),
constraint pat_schedule foreign key (PatientID) REFERENCES out_patient(PatientID),
CONSTRAINT doc_schedule foreign key (DoctorID) REFERENCES Doctor(DoctorID),
CONSTRAINT app_schedule foreign key (AppointmentNumber) REFERENCES Appointment(AppointmentNumber));


-- Inserting data into the Guardian table
INSERT INTO Guardian (GuardianID, GuardianFname, GuardianLname, GuardianContactNumber) VALUES
(326, 'Nishantha', 'Wickramasinghe', '0711234567'),
(327, 'Ruwani', 'Herath', '0779876543'),
(328, 'Anil', 'Sharma', '0784567890'),
(329, 'Kavitha', 'Patel', '0753210987'),
(330, 'Suhana', 'Khan', '0706543219'),
(331, 'Sai', 'Pallavi', '0728765432');


-- Inserting data into the In_patient table
INSERT INTO In_patient (PatientID, PatientFname, PatientLname, DateOfBirth, Patient_NIC_Number, BloodGroup, DateAdmitted, TimeAdmitted, Gender, DateDischarged, TimeDischarged, GuardianID) VALUES
(101, 'Mahendra', 'Perera', '1985-07-18', '850718456V', 'A+', '2024-12-11', '08:15:00', 'Male', '2024-12-13', '15:30:00', 326),
(102, 'Pooja', 'Umashankar', '1990-06-25', '900625678V', 'O-', '2024-12-11', '09:00:00', 'Female', NULL, NULL, 326),
(103, 'Vijay', 'Kumar', '1974-06-22', NULL, 'B+', '2024-12-12', '10:45:00', 'Male', '2024-12-14', '18:00:00', 327),
(104, 'Nadeesha', 'Hemamali', '1987-10-01', '871001789V', 'AB+', '2024-12-12', '11:30:00', 'Female', NULL, NULL, 327),
(105, 'Ranbir', 'Kapoor', '1982-09-28', NULL, 'O+', '2024-12-12', '12:00:00', 'Male', NULL, NULL, 327),
(106, 'Alia', 'Bhatt', '1993-03-15', NULL, 'A+', '2024-12-12', '14:00:00', 'Female', '2024-12-14', '19:00:00', 328),
(107, 'Roshan', 'Ranawaka', '1988-05-10', '880510654V', 'B-', '2024-12-13', '08:00:00', 'Male', '2024-12-15', '17:45:00', 329),
(108, 'Deepika', 'Padukone', '1986-01-05', NULL, 'AB-', '2024-12-13', '09:30:00', 'Female', '2024-12-15', '18:30:00', 329),
(109, 'Dinakshie', 'Priyasad', '1990-03-18', '900318890V', 'O+', '2024-12-13', '11:00:00', 'Female', NULL, NULL, 330),
(110, 'Shahid', 'Kapoor', '1981-02-25', NULL, 'B+', '2024-12-14', '10:00:00', 'Male', NULL, NULL, 331),
(111, 'Thushara', 'Silva', '1992-12-12', '921212546V', 'O-', '2024-12-14', '13:15:00', 'Female', NULL, NULL, 331),
(112, 'Samantha', 'Prabhu', '1987-04-28', NULL, 'A-', '2024-12-15', '11:30:00', 'Female', NULL, NULL, 331),
(113, 'Ruwan', 'Liyanage', '1989-08-08', '890808123V', 'AB+', '2024-12-16', '10:30:00', 'Male', '2024-12-18', '20:00:00', 331),
(114, 'Tamannaah', 'Bhatia', '1989-12-21', NULL, 'B-', '2024-12-17', '09:00:00', 'Female', NULL, NULL, 328),
(115, 'Saranga', 'Disasekara', '1985-11-01', '851101678V', 'A+', '2024-12-17', '14:30:00', 'Male', NULL, NULL, 329),
(116, 'Kiara', 'Advani', '1992-07-31', NULL, 'O+', '2024-12-17', '15:45:00', 'Female', '2024-12-19', '21:00:00', 327);


-- Inserting data into the out_patient table
INSERT INTO Out_patient (PatientID, PatientFname, PatientLname, DateOfBirth, ContactNumber)VALUES 
(201, 'Harsha', 'Perera', '1985-08-15', '0771234567'),
(202, 'Nivetha', 'Thomas', '1993-10-30', '0719876543'),
(203, 'Ravindra', 'Kumar', '1978-12-25', '0771122334'),
(204, 'Anjali', 'Silva', '1995-06-18', '0758765432'),
(205, 'Varun', 'Dhawan', '1987-04-24', '0775566778'),
(206, 'Sanjana', 'Fernando', '1992-09-05', '0769988776'),
(207, 'Aishwarya', 'Rai', '1973-11-01', '0703344556'),
(208, 'Chathura', 'Jayasuriya', '1989-03-12', '0788877665');


-- Inserting data into the Payment table
INSERT into Payment(PaymentID,PaymentType,Amount,PaidDate,PaidTime,In_patient_ID,Out_patient_ID) VALUES
(500, 'Cash',25000.00, '2024-12-13', '15:30:00',101, Null),
(501,'Card',50000.00,'2024-12-14', '18:00:00',103, Null),
(502,' Insurance',75000.00, '2024-12-14', '19:00:00',106, Null),
(503, 'Cash',100000.00, '2024-12-15', '17:45:00',107, Null),
(504, 'Cash',150000.00, '2024-12-15', '18:30:00',108, Null),
(505, 'Cash',85000.00, '2024-12-18', '20:00:00',113, Null),
(506, 'Card',25550.00,'2024-12-19','21:00:00',116,Null),
(509,'Insurance',125500.00,'2024-12-19','21:30:00',Null,203),
(510,'Cash',2500.00,'2024-12-19','21:45:00',Null,204),
(511,'Cash',3500.00,'2024-12-19','21:45:00',Null,205),
(512,'Card',840.00,'2024-12-19','22:00:00',Null,206),
(513,'Card',1000.00,'2024-12-19','22:05:00',Null,207),
(514,'Card',1500.00,'2024-12-19','22:10:00',Null,208),
(515, 'Cash', 3000.00, '2024-12-19', '21:00:00', NULL, 201),
(516, 'Cash', 4000.00, '2024-12-19', '21:30:00', NULL, 202);


-- Inserting data into the Ward table
INSERT INTO Ward (WardNumber, WardType, Available_beds_count, BedCapacity) VALUES 
(1, 'General', 25, 100),
(2, 'ICU', 5, 12),
(3, 'Surgical', 15, 20),
(4, 'Maternity', 10, 15);


-- Inserting data into the Room table
INSERT INTO Room (RoomNumber, RoomType, WardNumber)VALUES 
(10, 'Standard', 1),
(11, 'Deluxe', 1),
(12, 'Standard', 1),
(13, 'Deluxe', 2),
(14, 'Standard', 2),
(15, 'Deluxe', 2),
(16, 'Standard', 2),
(17, 'Deluxe', 2),
(18, 'Standard', 3),
(19, 'Deluxe', 3),
(20, 'Standard', 3),
(21, 'Deluxe', 3),
(22, 'Standard', 4),
(23, 'Deluxe', 4),
(24, 'Standard', 4),
(25, 'Deluxe', 4);


-- Inserting data into the In_patient_Room_allocation table
INSERT into In_patient_Room_allocation(PatientID, RoomNumber, DateAllocated) VALUES
(104, 18, '2024-12-12'),
(105, 11, '2024-12-12'),
(106, 12, '2024-12-12'),
(107, 16, '2024-12-13'),
(108, 23, '2024-12-13'),
(109, 25, '2024-12-13');


-- Inserting data into the Medical_care table
INSERT INTO Medical_care (MedicalCareID, Diagnosed_medical_condition, Type_of_treatment_admitted, Prescribed_medications, Dosage)VALUES
(1, 'Pneumonia', 'Medication', 'Amoxicillin', '500mg'),
(2, 'Diabetes', 'Medication', 'Metformin', '1000mg'),
(3, 'Appendicitis', 'Surgery', 'Post-surgery antibiotics', '1 tablet daily'),
(4, 'Hypertension', 'Medication', 'Lisinopril', '10mg'),
(5, 'Asthma', 'Medication', 'Salbutamol', '200mcg'),
(6, 'Fractured leg', 'Surgery', 'Painkillers', '2 tablets daily'),
(7, 'Migraine', 'Medication', 'Sumatriptan', '50mg'),
(8, 'Gastritis', 'Medication', 'Omeprazole', '20mg'),
(9, 'Bronchitis', 'Medication', 'Prednisone', '5mg'),
(10, 'Osteoarthritis', 'Medication', 'Paracetamol', '500mg'),
(11, 'Stroke', 'Rehabilitation', 'Physiotherapy sessions', '3/week'),
(12, 'Malaria', 'Medication', 'Chloroquine', '250mg'),
(13, 'Chest infection', 'Medication', 'Azithromycin', '500mg'),
(14, 'Gallstones', 'Surgery', 'Recovery medication', '1 tablet daily'),
(15, 'Hyperthyroidism', 'Medication', 'Levothyroxine', '100mg');


-- Inserting data into the Doctor table
INSERT INTO Doctor (DoctorID, DoctorFname, DoctorLname, DoctorContactNumber, Specialization, Classification, Availability, Date_joined_with_GVH) VALUES
(40, 'Sanduni', 'Perera', '0711234567', 'Dermatology', 'Resident', 'Outpatient', '2020-01-15'),
(41, 'Amal', 'Jayasinghe', '0779876543', 'Orthopaedics', 'Consultant', 'Both', '2018-06-12'),
(42, 'Nuwan', 'Silva', '0701122334', 'Cardiology', 'Resident', 'Inpatient', '2019-03-21'),
(43, 'Thusitha', 'Fernando', '0719876543', 'General Surgery', 'Consultant', 'Both', '2017-11-30'),
(44, 'Asha', 'Dissanayake', '0772233445', 'Neurology', 'Resident', 'Outpatient', '2021-07-10'),
(45, 'Lakshman', 'Abeysekara', '0703344556', 'Maternity & Gynecology', 'Consultant', 'Inpatient', '2022-04-25'),
(46, 'Kavindi', 'Rajapaksha', '0715566778', 'Pediatrics', 'Resident', 'Both', '2020-09-18'),
(47, 'Dinesh', 'Bandara', '0779988776', 'Psychiatry', 'Consultant', 'Outpatient', '2016-02-14'),
(48, 'Anjali', 'Weerakoon', '0704455667', 'Ophthalmology', 'Consultant', 'Both', '2015-12-01'),
(49, 'Sanjeewa', 'Rathnayake', '0716655443', 'ENT', 'Resident', 'Inpatient', '2021-05-20'),
(50, 'John', 'Peterson', '0789807687', 'Pediatrics', 'Resident', 'Both', '2023-11-01'),
(51, 'Linda', 'Fedrick', '0707654001', 'Pediatrics', 'Resident', 'Both', '2023-10-15'),
(52, 'Ruwan', 'Jayawardena', '0704455667', 'Cardiology', 'Resident', 'Outpatient', '2020-06-15'),
(53, 'Shanthi', 'Weerasinghe', 0711238899, 'Neurology', 'Resident', 'Outpatient', '2021-03-10');


-- Inserting data into the treatment table
insert into treatment(PatientID, MedicalCareID, DoctorID, DateTreated) VALUES
(101, 8, 42, '2024-12-11'),
(108, 7, 45, '2024-12-13'),
(109, 14, 45, '2024-12-13'),
(105, 6, 43, '2024-12-12'),
(106, 11, 42, '2024-12-12'),
(103, 3, 43, '2024-12-13'),
(102, 2, 43, '2024-12-11');


-- Inserting data into the Appointment table
INSERT INTO Appointment (AppointmentNumber, Appointment_Date, Appointment_time) VALUES
(5001, '2024-12-19', '21:00:00'),
(5002, '2024-12-19', '21:10:00'),
(5003, '2024-12-19', '21:15:00'),
(5004, '2024-12-19', '21:30:00'),
(5005, '2024-12-19', '21:35:00'),
(5006, '2024-12-19', '21:45:00'),
(5007, '2024-12-19', '22:00:00'),
(5008, '2024-12-19', '22:00:00'),
(5009, '2024-12-19', '21:00:00'),
(5010, '2024-12-19', '21:10:00');


-- Inserting data into the Scheduled table
INSERT INTO Scheduled (PatientID, DoctorID, AppointmentNumber)VALUES
(201, 40, 5001),
(202, 41, 5002),
(203, 43, 5003),
(204, 44, 5004),
(205, 46, 5005),
(206, 47, 5006),
(207, 48, 5007),
(208, 48, 5008),
(201, 50, 5009),  
(202, 51, 5010);









