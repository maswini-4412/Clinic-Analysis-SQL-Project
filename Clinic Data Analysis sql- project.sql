use mis602_ass2;

select count(*)from doctor;
select count(*)from appointment;

-- find the specilized doctors

select d.name as doctor,s.name as speciality from doctor d
left join speciality s on d.speciality_id=s.speciality_id;

-- To find the how many specialization doctors. 
select d.speciality_id,s.name as specialization, count(doctor_id ) as doctors from doctor d
right join speciality s on s.speciality_id=d.speciality_id
group by s.name,d.speciality_id;

-- How many appointments per day each doctor
select name,count(appointment_id) as total_appointments,appointment_date from doctor d 
inner join appointment a on a.doctor_id=d.doctor_id
group by name,appointment_date
order by total_appointments desc;


-- How many appointments done within a week 
select doctor_id,count(*) as num_appoinments from appointment
where appointment_date >='2023-12-20 15:45:00'-interval '7' day
group by doctor_id 
order by num_appoinments desc;

select max(appointment_date)
from appointment;


SELECT doctor_id, 
    (SELECT COUNT(*) 
     FROM appointment 
     WHERE appointment.doctor_id = a.doctor_id 
     AND appointment_date >= CURDATE() - INTERVAL 7 DAY) AS num_appointments
FROM appointment a
GROUP BY doctor_id
ORDER BY num_appointments DESC;
 
 SELECT d.doctor_id, 
    IFNULL(COUNT(a.appointment_id), 0) AS num_appointments
FROM doctor d
LEFT JOIN appointment a ON d.doctor_id = a.doctor_id AND a.appointment_date >= CURDATE() - INTERVAL 7 DAY
GROUP BY d.doctor_id
ORDER BY num_appointments DESC;



-- How appointments done within 3 months each doctor.
select name as doctor,count(*) as total_appointments from doctor d 
inner join appointment a on a.doctor_id=d.doctor_id where appointment_date between '2023-07-01' and '2023-10-30'
group by name
having count(*)>1
order by total_appointments desc;

-- Which doctors have the highest number of appointments scheduled
select d.name,s.name,count(a.appointment_id) as total_appointments from appointment a  
join doctor d on d.doctor_id=a.doctor_id 
join speciality s on s.speciality_id=d.speciality_id
group by d.name,s.name;

-- How many patients does each doctor have
select doctor_id,count(patient_id) from appointment 
group by  doctor_id;




-- How many patients treatements done under 'Cardiology'&'Neurology'.
select p.name as patient,p.gender,s.name,a.status from patient p  
right join appointment a  on p.patient_id=a.patient_id
left join doctor d on d.doctor_id=a.doctor_id 
join speciality s on s.speciality_id=d.speciality_id 
where s.name in('Cardiology','Neurology');

-- find the appoinments status all
select count(*) ,status from appointment
group by status; 


SELECT * FROM medication;
select distinct(name),strength from medication where strength>250;

-- find the mostly used medicines 
SELECT m.name, COUNT(p.medication_id) AS prescription_count
FROM prescription p 
INNER JOIN medication m ON m.medication_id = p.medication_id
GROUP BY m.name
ORDER BY prescription_count DESC;



