# Hospital Database Management System

## Overview

This project implements a relational database system designed to manage core operations and data within a hospital environment. It includes schemas for patients, staff (doctors, nurses, managers), billing, and treatments, demonstrating robust database design principles, schema creation, and direct interaction using SQL.

## Features

* **Patient Management:** Comprehensive records including personal details, medical information, and emergency contacts.

* **Staff Management:** Categorization of staff into doctors, nurses, and managers with specific attributes for each role.

* **Billing System:** Tracks room costs and total charges, linked to patient records.

* **Treatment Tracking:** Records details of treatments, including start/end times, results, descriptions, and costs, linked to both patients and billing.

* **Staff-Treatment Association:** Manages which staff members are involved in specific treatments.

* **Hierarchical Staff Structure:** Defines relationships between managers and nurses.

* **Data Integrity:** Enforces referential integrity and consistency through primary and foreign key constraints.

## Technologies Used

* **Database:** MySQL

* **Database Design Tool:** Draw.io (for Entity-Relationship Diagrams)

## Database Design

The database schema was meticulously designed using **Entity-Relationship Diagrams (ERDs)** created in Draw.io, translating logical hospital concepts into a normalized relational model. The design incorporates the following tables and relationships:

* **`patient`**: Stores patient demographics, medical information, emergency contacts, and room assignments. (`patient_id` as Primary Key).

* **`staff`**: A supertype table for all hospital personnel, including their position, clock-in/out times, hourly rate, and name. (`staff_id` as Primary Key).

* **`doctor`**: A subtype of `staff`, detailing doctor's specialization. (`Dstaff_id` as Primary Key, referencing `staff_id`).

* **`manager`**: A subtype of `staff`, indicating the floor they manage. (`mstaff_id` as Primary Key, referencing `staff_id`).

* **`nurse`**: A subtype of `staff`, including specialization, practitioner status, and a foreign key to their `manager`. (`nstaff_id` as Primary Key, referencing `staff_id`, and `mstaff_id` referencing `manager`).

* **`billing`**: Manages patient billing information (room cost, total cost), linked to the `patient` table. (`billing_id` as Primary Key, `patient_id` as Foreign Key).

* **`treatment`**: Records details of medical treatments, linked to both `patient` and `billing` records. (`treatment_id` as Primary Key, `patient_id` and `billing_id` as Foreign Keys).

* **`treatment_staff`**: A junction table to represent the many-to-many relationship between `staff` and `treatment`, indicating which staff members were involved in which treatments. (`staff_id`, `treatment_id` as Composite Primary Key).
