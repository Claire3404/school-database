USE school;


-- Prepare an example query with group by and having to demonstrate how to extract data from your DB for analysis

    -- Which employees earn more than the average salary and why? 
    -- Are all employees on the same band earning the same salary? Why?
    
SELECT 
  e.id,
  e.first_name,
  e.last_name,
  e.start_date,
  s.salary,
  j.title,
  su.subject_name
FROM employee AS e
LEFT JOIN subject_lead AS sl
  ON sl.employee_id = e.id
LEFT JOIN subject AS su
  ON su.id = sl.subject_id
LEFT JOIN salary AS s
  ON s.employee_id = e.id
INNER JOIN jobtype as j
  ON j.id = e.jobtype_id
WHERE j.title LIKE "%teacher%"
GROUP BY 5, 1, 2, 3, 4, 6, 7
HAVING s.salary > (SELECT AVG(salary) FROM salary)
ORDER BY salary DESC;


-- Using any type of the joins create a view that combines multiple tables in a logical way

    -- Example 1 - a view of children who are absent without a reason. 
    -- We'd use this to call their carer and find out why they're absent. --

CREATE VIEW vw_pupil_absence
AS
SELECT
  p.first_name AS Pupil_Name,
  p.last_name AS Pupil_Surname,
  c.class_name AS class,
  cr.first_name AS Carer_Name,
  cr.last_name AS Carer_Surname,
  cr.relationship_to_pupil,
  cr.mobile_telephone_number AS mobile,
  cr.work_telephone_number AS work,
  r.register_date
FROM pupil AS p
  LEFT JOIN class AS c
    ON c.id = p.class_id
  INNER JOIN carer AS cr
    ON cr.id = p.id
  INNER JOIN attendance AS a
    ON a.pupil_id = p.id
  LEFT JOIN register AS r
    ON r.attendance_id = a.id
WHERE a.acode_id = "N"
  AND r.register_date = "2022-01-02"
GROUP BY 3, 1, 2, 4, 5, 6, 7, 8, 9;

SELECT *
FROM vw_pupil_absence;


    -- Example 2 - if a child came to the office was unwell/injured, we'd need the following data --


CREATE VIEW vw_sickness_injury
AS
SELECT 
  p.first_name AS Pupil_Name,
  p.last_name AS Pupil_Surname,
  c.class_name AS class,
  cr.first_name AS Carer_Name,
  cr.last_name AS Carer_Surname,
  cr.relationship_to_pupil,
  cr.mobile_telephone_number AS mobile,
  cr.work_telephone_number AS work,
  ct.consent_type,
  co.consent_given AS consent,
  mc.condition_name AS medical,
  me.medication_name
FROM pupil AS p
  LEFT JOIN class AS c
    ON c.id = p.class_id
  LEFT JOIN carer AS cr
    ON cr.id = p.id
  LEFT JOIN consent AS co
    ON co.pupil_id = p.id
  LEFT JOIN consent_type AS ct
    ON ct.id = co.consent_type_id
  LEFT JOIN medical AS m
    ON m.id = p.id
  LEFT JOIN medical_condition AS mc
    ON mc.id = m.medical_condition_id
  LEFT JOIN medication AS me
    ON me.id = m.medication_id
WHERE 
  p.first_name = 'Jessie'
  AND p.last_name = 'Jackson'
  AND ct.consent_type = 'calpol';

SELECT * 
FROM vw_sickness_injury;


-- In your database, create a stored function that can be applied to a query in your DB

    -- Example 1 - stored function for seeing the number of years a person has been registered at the school -

DELIMITER //

CREATE FUNCTION no_of_years(date1 DATE) 
RETURNS INT
DETERMINISTIC
BEGIN
 DECLARE date2 DATE;
 SELECT CURRENT_DATE()INTO date2;
 RETURN YEAR(date2)-YEAR(date1);
END //

DELIMITER ;


SELECT 
  id, first_name, last_name, no_of_years(start_date) AS years 
FROM employee;


SELECT
  id, first_name, last_name, no_of_years(admission_date) AS years 
FROM pupil;



-- Prepare an example query with a subquery to demonstrate how to extract data from your DB for analysis 

     --  Example 1 - the number of children in each class working below average in writing in Spring 2022 -
     
SELECT 
    COUNT(p.id),
    c.class_name
FROM
    pupil AS p
  LEFT JOIN class AS c
    ON c.id = p.class_id
WHERE
    p.id IN (
      SELECT 
            a.pupil_id
      FROM
            attainment AS a
	  WHERE
            a.term_id = 8
		AND a.attainment_level_id = 3
        AND a.subject_id = 2)
GROUP BY c.class_name;


    -- Example 2 - A fire spread through the houses at Hale End Road yesterday. Find all the pupils who may be effected. -
    
SELECT
  p.first_name,
  p.last_name,
  c.class_name
FROM pupil AS p
LEFT JOIN class AS c
  ON c.id = p.class_id
WHERE p.id IN (
    SELECT c.id
    FROM carer AS c
    WHERE c.id IN (
      SELECT ca.id
      FROM carer_address AS ca
      WHERE ca.street_name = "Hale End Road")
	);


-- In your database, create a stored procedure and demonstrate how it runs
  
    -- Inserting a new pupil --
    
DELIMITER // 

CREATE PROCEDURE InsertNewPupil(
  IN id INT,
  IN PupilFirstName VARCHAR(50),
  IN PupilLastName VARCHAR(50),
  IN BirthDate DATE,
  IN Gender ENUM ('Male', 'Female', 'Other'),
  IN DateOfAdmission DATE,
  IN ClassID INT)
BEGIN
  INSERT INTO pupil (id, first_name, last_name, date_of_birth, gender, admission_date, class_id)
  VALUES
    (id, PupilFirstName, PupilLastName, BirthDate, Gender, DateOfAdmission, ClassID);

END//
DELIMITER ;

CALL InsertNewPupil (11, "Ash", "Ketchum", "2018-11-10", "Male", "2023-05-28", 4);

SELECT * FROM pupil;

DELETE FROM pupil
WHERE id = 11;


-- In your database, create a trigger and demonstrate how it runs

    -- Creating consistency with font when adding data --

DELIMITER //

CREATE TRIGGER name_before_insert
BEFORE INSERT ON pupil
FOR EACH ROW 
BEGIN
  SET NEW.first_name = CONCAT(UPPER(LEFT(NEW.first_name, 1)),
                         LOWER(SUBSTRING(NEW.first_name, 2)));
  SET NEW.last_name = CONCAT(UPPER(LEFT(NEW.last_name, 1)),
                         LOWER(SUBSTRING(NEW.last_name, 2)));
END //

DELIMITER ;

CALL InsertNewPupil (12, "beth", "barrow", "2014-01-21", "Female", "2023-05-28", 1);

SELECT *
FROM pupil;



-- In your database, create an event and demonstrate how it runs

    -- event = monitoring updates to the pupil table --

CREATE TABLE monitoring_pupil
  (id INT NOT NULL AUTO_INCREMENT,
  Last_Update TIMESTAMP,
  PRIMARY KEY (id));
  
DELIMITER //
  
CREATE EVENT recurring_event_monitoring_pupil
    ON SCHEDULE EVERY 1 MINUTE
    STARTS NOW()
    DO BEGIN
      INSERT INTO monitoring_pupil(Last_Update)
      VALUES (NOW());
END//

DELIMITER ;
      
SELECT * 
FROM monitoring_pupil
ORDER BY id DESC;

DROP TABLE monitoring_pupil;
DROP EVENT recurring_event_monitoring_pupil;



-- Create a view that uses at least 3-4 base tables; 

CREATE VIEW vw_pupil_class
AS
SELECT 
  p.id,
  p.first_name,
  p.last_name,
  p.class_id,
  c.class_name
FROM pupil AS p
LEFT JOIN class AS c
    ON c.id = p.class_id;

SELECT * 
FROM vw_pupil_class;


CREATE VIEW  vw_writing_attainment_Autumn22
AS
SELECT 
  pupil_id,
  attainment_level_id AS Autumn_2022
FROM attainment
WHERE term_id = 7
AND subject_id = 2;

SELECT * 
FROM vw_writing_attainment_Autumn22;


CREATE VIEW vw_writing_attainment_Spring22
AS
SELECT 
pupil_id,
attainment_level_id AS Spring_2022
FROM attainment
WHERE term_id = 8
AND subject_id = 2;

SELECT * 
FROM vw_writing_attainment_Spring22;


CREATE VIEW vw_class_send
AS
SELECT
  sr.pupil_id AS pupil_id,
  sr.send_id AS send_id,
  s.category AS send
FROM send_register AS sr
LEFT JOIN send AS s
ON s.id = sr.send_id;

SELECT * 
FROM vw_class_send;


CREATE VIEW vw_intervention_groups
AS
SELECT
  i.pupil_id,
  it.intervention_name
FROM intervention AS i
LEFT JOIN intervention_type AS it
ON it.id = i.intervention_type_id;

SELECT *
FROM vw_intervention_groups;


CREATE VIEW vw_writing_attainment2022
AS
SELECT
  p.first_name,
  p.last_name,
  p.class_name,
  aw.Autumn_2022,
  sw.Spring_2022,
  cs.send,
  ig.intervention_name
FROM vw_pupil_class AS p
JOIN vw_writing_attainment_Autumn22 AS aw
  ON aw.pupil_id = p.id
JOIN vw_writing_attainment_Spring22 AS sw
  ON sw.pupil_id = p.id
LEFT JOIN vw_class_send AS cs
  ON cs.pupil_id = p.id
LEFT JOIN vw_intervention_groups AS ig
  ON ig.pupil_id = p.id
GROUP BY 3, 1, 2, 4, 5, 6, 7
ORDER BY p.class_name DESC;

SELECT *
FROM vw_writing_attainment2022;


-- prepare and demonstrate a query that uses the view to produce a logically arranged result set for analysis.

    -- Example 1 - Show all the children in 3AN who are working towards in writing. 
    --  Why are they WT? Are they on the SEND register? Do we have adequate support in place? --
    
SELECT 
  first_name,
  last_name,
  send,
  intervention_name
FROM vw_writing_attainment2022
WHERE Spring_2022 = 3
AND class_name = "3AN";


    -- same as above for 1LB -
    
SELECT 
  first_name,
  last_name,
  send,
  intervention_name
FROM vw_writing_attainment2022
WHERE Spring_2022 = 3
AND class_name = "1LB";

    -- Example 2 - Are there any children who were working AT or Above in writing who have fallen behind and now working below? 
    -- Why? Is there adequate support in place? --
    
SELECT
  first_name,
  last_name,
  intervention_name,
  send
FROM vw_writing_attainment2022
WHERE Autumn_2022 < 3
AND Spring_2022 = 3;


    -- Example 3 - What progress have children on the SEND register made in the Spring Term 2022 in writing? --
    
SELECT
  first_name,
  last_name,
  Autumn_2022,
  Spring_2022,
  class_name
FROM vw_writing_attainment2022
WHERE send != "NULL"
GROUP BY 5, 1, 2, 3, 4;








  
  
  