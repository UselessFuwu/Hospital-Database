-- Team 5, Alex Dela Cruz, Inuka Hulathduwage
-- Disable foreign key checks
set foreign_key_checks = 0;

-- Drop tables if they exist (to handle multiple executions)
drop table if exists treatment_staff;
drop table if exists doctor;
drop table if exists manager;
drop table if exists nurse;
drop table if exists treatment;
drop table if exists billing;
drop table if exists patient;
drop table if exists staff;

-- Enables foreign key checks
set foreign_key_checks = 1;


-- creates patient table patient_id primary key
create table patient(
patient_id integer not null,
patient_name varchar(20),
medical_information varchar(100),
Emergency_Contact varchar(20) not null,
date_of_birth Date, 
roomnumber integer,
primary key (patient_id));

-- creates staff table staff_id primary key
create table staff( 
staff_id integer not null, 
position varchar(20) 
check (position in ('doctor', 'nurse', 'manager')), 
clockin datetime,
clockout datetime,
hourly_rate decimal(10, 2), 
name varchar(30),
primary key(staff_id));

-- creates billing table billing_id primary key and references patient table
create table billing(
billing_id integer not null,
room_cost integer,
total integer,
patient_id integer not null,
primary key(billing_id),
constraint billingfk1 foreign key (patient_id) references
patient(patient_id));

-- creates treatment table treatment_id primary key and references patient and billing tables
create table treatment(
treatment_id integer not null,
treatmentstarted datetime,
treatmentended datetime,
results varchar(50),
description varchar(50),
treatment_cost integer,
patient_id integer not null,
billing_id integer not null,
primary key(treatment_id),
constraint treatmentfk1 foreign key (patient_id) references 
patient(patient_id),
constraint treatmentfk2 foreign key (billing_id) references 
billing(billing_id));

-- creates treatment_staff table treatment_staff is composite key containing treatment_id and staff_id
create table treatment_staff(
staff_id integer not null,
treatment_id integer not null, 
constraint treatment_staff_pk primary key (staff_id, treatment_id),
constraint treatment_staff_fk1 foreign key (staff_id) references 
staff(staff_id),
constraint treatment_staff_fk2 foreign key (treatment_id) references 
treatment(treatment_id));

-- creates doctor subtype table of staff table dstaff_id primary key references staff table
create table doctor(
Dstaff_id integer not null,
specialization varchar (20),
primary key (dstaff_id),
constraint doctorfk1 foreign key (dstaff_id) references
staff(staff_id) on delete cascade);

-- creates manager subtype table of table mstaff_id primary key references staff table
create table manager(
mstaff_id integer not null,
floor integer,
primary key (mstaff_id),
constraint managerfk1 foreign key (mstaff_id) references 
staff(staff_id) on delete cascade);

-- creates nurse subtype table of table nstaff_id primary key references staff and manager table 
create table nurse(
nstaff_id integer not null,
specialization varchar (20),
practitioner bool,
mstaff_id integer not null,
primary key (nstaff_id),
constraint nursefk1 foreign key (nstaff_id) references
staff(staff_id) on delete cascade,
constraint nursefk2 foreign key (mstaff_id) references
manager(mstaff_id));




