-- Team 5, Alex Dela Cruz, Inuka Hulathduwage
-- 1. Get staff names ordered by hourly rate in descending order.
-- Purpose: Orders staff by pay rate.
select name, hourly_rate
from staff
order by hourly_rate desc;

-- 2. Get all treatments that cost more than 100.
-- Purpose: Filters treatments based on cost.
select description, treatment_cost
from treatment
where treatment_cost > 100;


-- 3. Get the names of all doctors and the patients they are treating.
-- Purpose: Joins staff, doctor, treatment, and patient information using where clauses.
select s.name as doctor_name, p.patient_name
from staff s, doctor d, treatment_staff ts, treatment t, patient p
where s.staff_id = d.dstaff_id
and s.staff_id = ts.staff_id
and ts.treatment_id = t.treatment_id
and t.patient_id = p.patient_id
and s.position = 'doctor';

-- 4. Get the names of staff members who administered treatments to patient 'Alice Adams'.
-- Purpose:  Filters based on a patient name using where clauses.
select s.name as staff_name, p.patient_name as patient_name
from staff s, treatment_staff ts, treatment t, patient p
where s.staff_id = ts.staff_id
and ts.treatment_id = t.treatment_id
and t.patient_id = p.patient_id
and p.patient_name = 'Alice Adams';

-- 5. Get the names of doctors and the number of patients they are treating.
-- Purpose: Uses a group by clause to count patients per doctor.
select s.name as doctor_name, COUNT(DISTINCT p.patient_id) as number_of_patients_treating
from staff s, doctor d, treatment_staff ts, treatment t, patient p
where s.staff_id = d.dstaff_id
and s.staff_id = ts.staff_id
and ts.treatment_id = t.treatment_id
and t.patient_id = p.patient_id
and s.position = 'doctor'
group by s.name;

-- 6. Show the name of each staff member and the treatments they have administered.
-- Purpose:  Joins staff and treatment_staff.
select s.name as staff_name, t.description
from staff s, treatment_staff ts, treatment t
where s.staff_id = ts.staff_id
and ts.treatment_id = t.treatment_id;

-- 7. Show the amount a staff has made within the workday 
select
    s.staff_id,
    s.name,
    s.clockin,
    s.clockout,
    s.hourly_rate,
    -- Calculate the difference in hours between clockout and clockin.
    timestampdiff(hour, s.clockin, s.clockout) as hours_worked,
    -- Calculate the total pay by multiplying hours worked by hourly_rate.
    (timestampdiff(hour, s.clockin, s.clockout) * s.hourly_rate) as total_pay
from
    staff s
order by s.staff_id;