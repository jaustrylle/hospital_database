SELECT 
    p.patient_id,
    p.patient_name,
    SUM(b.total_amount) AS total_billed
FROM patient p
INNER JOIN bills b 
    ON p.patient_id = b.patient_id
GROUP BY p.patient_id, p.patient_name
ORDER BY total_billed DESC;

SELECT 
    gender,
    AVG(age) AS average_age
FROM patient
GROUP BY gender;

SELECT 
    s.staff_id,
    s.name,
    sp.specialization_name,
    o.occupation_name,
    s.office_no
FROM staff s
LEFT JOIN specialization sp 
    ON s.specialization_id = sp.specialization_id
INNER JOIN occupation o 
    ON s.occupation_id = o.occupation_id
ORDER BY s.staff_id;

SELECT 
    pr.prescription_id,
    pr.prescription_name,
    pr.type,
    pr.price
FROM prescriptions pr
WHERE pr.prescription_id NOT IN (
        SELECT DISTINCT prescription_id FROM treatments
    )
  AND pr.prescription_id NOT IN (
        SELECT DISTINCT prescription_id FROM bills
    );

SELECT 
    p.patient_id,
    p.patient_name
FROM patient p
WHERE p.patient_id IN (
        SELECT DISTINCT patient_id 
        FROM appointments
    )
  AND p.patient_id NOT IN (
        SELECT DISTINCT patient_id 
        FROM treatments
    );

SELECT 
    DATE(appointment_date) AS appointment_day,
    COUNT(*) AS number_of_appointments
FROM appointments
GROUP BY DATE(appointment_date)
ORDER BY appointment_day;