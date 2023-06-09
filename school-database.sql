DROP DATABASE IF EXISTS school;

CREATE DATABASE school;

USE school;

CREATE TABLE country (
  id INT PRIMARY KEY,
  name VARCHAR(50)
); 
 
INSERT INTO country
VALUES
  (1, "United Kingdom"),
  (2, "France"),
  (3, "Spain"),
  (4, "Itally"),
  (5, "Turkey"),
  (6, "Pakistan"),
  (7, "Bangladesh");

CREATE TABLE post_code (
  id INT PRIMARY KEY,
  post_code VARCHAR(50)
); 

INSERT INTO post_code
VALUES
  (1, "E4 6ZN"),
  (2, "E4 9RT"),
  (3, "E4 8DB"),
  (4, "E4 3NJ"),
  (5, "E4 7MA"),
  (6, "E4 2NG"),
  (7, "E4 6HH"),
  (8, "FR12 7KL"),
  (9, "E4 2AB"),
  (10, "E4 6PK"),
  (11, "E17 7RD"),
  (12, "E17 8HP"),
  (13, "E17 3GB"),
  (14, "E4 9KM"),
  (15, "E4 3ED"),
  (16, "E17 6PM"),
  (17, "E4 9CJ"),
  (18, "E17 8DA"),
  (19, "E17 8EG"),
  (20, "E5 9BJ"),
  (21, "E4 9NG"),
  (22, "E17 8KP"),
  (23, "E5 9FT"),
  (24, "E4 4NK"),
  (25, "E4 5MD");

CREATE TABLE carer_address (
  id INT NOT NULL PRIMARY KEY,
  door_number VARCHAR(50) NOT NULL,
  street_name VARCHAR(50),
  post_code_id INT NOT NULL,
  country_id INT NOT NULL,
    CONSTRAINT fk_carer_address_country_id
    FOREIGN KEY (country_id)
    REFERENCES country(id),
    CONSTRAINT fk_carer_address_post_code_id
    FOREIGN KEY (post_code_id)
    REFERENCES post_code(id)
);

INSERT INTO carer_address 
VALUES
  (1, "37", "Coolgardie_Avenue", 1, 1),
  (2, "17", "Hale End Road", 2, 1),
  (3, "42", "Coolgardie Avenue", 1, 1),
  (4, "426", "Handsworth Avenue", 3, 1),
  (5, "5", "Hale End Road", 4, 1),
  (6, "40", "Beech Hall Road", 5, 1),
  (7, "27b", "Handsworth Avenue", 3, 1),
  (8, "135", "Castle Avenue", 6, 1),
  (9, "173", "Winchester Road", 7, 1),
  (10, "10", "Rue Rouge", 8, 2);


CREATE TABLE carer (
  id INT NOT NULL primary key,
  title VARCHAR(50),
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  relationship_to_pupil VARCHAR(50),
  mobile_telephone_number VARCHAR(50) NOT NULL,
  work_telephone_number VARCHAR(50),
  email VARCHAR(50),
  carer_address_id INT, 
    CONSTRAINT fk_carer_address_id
    FOREIGN KEY (carer_address_id)
    REFERENCES carer_address(id)
);

INSERT INTO carer
VALUES
  (1, "MRS", "Claire", "Dale", "Foster Carer", "07956371094", 02045678394, "c.dale@yahoo.com", 1),
  (2, "MRS", "Anna", "Jones", "Mother", "07984561094", "02045673467", "a.jon@yahoo.com", 2),
  (3, "MR", "Ali", "Dale", "Father", "07956371094", "02045678394", "c.dale@yahoo.com", 3),
  (4, NULL, "Beth", "Jackson", "Mother", "08766371094", "02090878394", "jackson12@gmail.com", 4),
  (5, "MR", "Clarck", "Munroe", "Father", "04598371094", "02011228394", "ckmunroe@gmail.com", 5),
  (6, NULL, "Ayla", "Muhammad", "Aunt", "07956444554", "02047586394", "muhay@yahoo.com", 6),
  (7, "MRS", "Jess", "Greenup","Mother", "07367771094", "02039908394", "g.h.greenup@hotmail.com", 7),
  (8, "MR", "Raja", "Arceus", "Father", "07956444997", "02045089770", "raja234@gmail.com", 8),
  (9, "MRS", "Claire", "Peters", "Mother", "07956455594", "02045670001", "c.peters@yahoo.com", 9),
  (10, "MR", "Kevin", "Jackson", "Father", "07444791094", NULL, "k.jackson@yahoo.com", 4),
  (11, "MRS", "Jasmine", "Ali", "Mother", "07933321094", NULL, "ali.y@yahoo.com", 2), 
  (12, "MR", "Stefan", "Greenup", "Father", "07955588094", 02033338394, "green.s@yahoo.com", 10);


CREATE TABLE class (
  id INT NOT NULL PRIMARY KEY,
  class_name VARCHAR(50) 
);

INSERT INTO class
VALUES
  (1, "RAA"),
  (2, "1LB"),
  (3,"2AH"),
  (4, "3AN"),
  (5, "4RM"),
  (6, "5CJ"),
  (7, "6IM"),
  (8, "1SH"),
  (9, "2BT"),
  (10, "3CH"),
  (11, "4PL"),
  (12, "5JS");


Create TABLE pupil (
  id INT NOT NULL primary key,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  gender ENUM ('Male', 'Female', 'Other'),
  admission_date DATE NOT NULL,
  class_id INT NOT NULL,
    CONSTRAINT fk_pupil_class_id
    FOREIGN KEY (class_id) 
    REFERENCES class(id)
);

INSERT INTO pupil 
VALUES 
  (1, "Robin", "Dale", "2014-10-05", "Male", "2018-09-01", 4),
  (2, "Evie", "Jones", "2015-01-17", "Female", "2018-09-01", 4),
  (3, "Abrar", "Ali", "2015-01-31", "Male", "2018-09-01", 4),
  (4, "Jessie", "Jackson", "2015-04-04", "Male", "2018-09-01", 4),
  (5, "Seb", "Munroe", "2014-11-11", "Male", "2018-09-01", 4),
  (6, "Amelia", "Sabbit", "2014-12-05", "Female", "2018-12-05", 4),
  (7, "Ruby", "Greenup", "2017-05-02", "Female", "2021-09-01", 2),
  (8, "Kay", "Arceus", "2017-07-04", "Male", "2021-09-01", 2),
  (9, "Ruby", "Arceus", "2017-07-04", "Female", "2021-09-01", 2),
  (10, "Phoebe", "Peters", "2017-07-11", "Female", "2021-09-01", 2),
  (14, "Zak", "Greenup", "2015-05-19", "Male", "2022-12-04", 4);

CREATE TABLE family (
  id INT NOT NULL PRIMARY KEY,
  pupil_id INT NOT NULL,
  carer_id INT NOT NULL,
	CONSTRAINT fk_family_pupil_id
    FOREIGN KEY (pupil_id) 
    REFERENCES pupil(id),
	CONSTRAINT fk_family_carer_id
    FOREIGN KEY (carer_id) 
    REFERENCES carer(id)
  );
  
  INSERT INTO family 
  VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5),
    (6, 6, 6),
    (7, 7, 7),
    (8, 8, 8),
    (9, 9, 8),
    (10, 10, 9),
    (11, 4, 10),
    (12, 2, 11),
    (13, 7, 12);
  
  CREATE TABLE consent_type (
    id INT NOT NULL PRIMARY KEY,
    consent_type VARCHAR(50)
);

INSERT INTO consent_type
VALUES
  (1, "seek emergency medical advice"),
  (2, "calpol"),
  (3, "photos on website"),
  (4, "trip on public transport");
  
CREATE TABLE consent (
  id INT NOT NULL PRIMARY KEY,
  consent_type_id INT NOT NULL,
  consent_given ENUM ("yes", "no") NOT NULL,
  pupil_id INT NOT NULL,
    CONSTRAINT fk_consent_pupil_id
    FOREIGN KEY (pupil_id)
    REFERENCES pupil(id),
    CONSTRAINT fk_consent_consent_type_id
    FOREIGN KEY (consent_type_id)
    REFERENCES consent_type(id)
);

INSERT INTO consent
VALUES
  (1, 1, "yes", 1),
  (2, 2, "yes", 1),
  (3, 3, "yes", 1),
  (4, 4, "yes", 1),
  (5, 1, "yes", 2),
  (6, 2, "yes", 2),
  (7, 3, "yes", 2),
  (8, 1, "yes", 3),
  (9, 2, "no", 3),
  (10, 3, "no", 3),
  (11, 1, "yes", 4),
  (12, 2, "yes", 4),
  (13, 3, "yes", 4);

CREATE TABLE send
  (id INT NOT NULL PRIMARY KEY,
  category VARCHAR(50) NOT NULL
);

INSERT INTO send
VALUES
  (1, "SLD"),
  (2, "MLD"),
  (3, "SLD"),
  (4, "PMLD"),
  (5, "Speech Language Communication Needs"),
  (6, "SEMH"),
  (7, "ASD"),
  (8, "VI"),
  (9, "HI"),
  (10, "MSI"),
  (11, "PD"),
  (12, "no assessment");

CREATE TABLE send_register (
  id INT NOT NULL PRIMARY KEY,
  pupil_id INT NOT NULL,
  send_id INT NOT NULL,
  statement ENUM ("yes", "no"),
  EHCP ENUM ("yes", "no"),
  IEP ENUM ("yes", "no"),
    CONSTRAINT fk_send_register_pupil_id
    FOREIGN KEY (pupil_id)
    REFERENCES pupil(id),
    CONSTRAINT fk_send_register_send_id
    FOREIGN KEY (send_id)
    REFERENCES send(id)
);
  
  
INSERT INTO send_register
VALUES
  (1, 2, 7, "yes", "no", "yes"),
  (2, 5, 11, "no", "yes", "yes"),
  (3, 8, 7, "no", "no", "yes"),
  (4, 9, 5, "no", "no", "yes");


CREATE TABLE employee_address (
  id INT NOT NULL PRIMARY KEY,
  house_number VARCHAR(50) NOT NULL,
  street_name VARCHAR(50) NOT NULL,
  post_code_id INT NOT NULL,
  country_id INT NOT NULL,
    CONSTRAINT fk_employee_address_country_id
	FOREIGN KEY (country_id)
    REFERENCES country(id),
    CONSTRAINT fk_employee_address_post_code_id
	FOREIGN KEY (post_code_id)
    REFERENCES post_code(id)
);
 
 INSERT INTO employee_address
 VALUES
   (1, "175", "Studley Avenue", 10, 1),
   (2, "32", "Main Road", 11, 1),
   (3, "4", "Bell Avenue", 12, 1),
   (4, "105", "Hoe Street", 13, 1),
   (5, "75", "Wood Street", 14, 1),
   (6, "136", "Larkswood road", 15, 1),
   (7, "83", "Warner Road", 16, 1),
   (8, "2b", "Castle Avenue", 17, 1),
   (9, "91", "Market Street", 18, 1),
   (10, "276", "Warner Road", 19, 1),
   (11, "35", "Bradstock Road", 20, 1),
   (12, "75", "Handsworth Avenue", 21, 1),
   (13, "09", "Market Street", 22, 1);

 
 CREATE TABLE jobtype (
  id INT NOT NULL PRIMARY KEY,
  title VARCHAR(50) NOT NULL
);

INSERT INTO jobtype
VALUES
 (1, "Head Teacher"),
 (2, "Office"),
 (3, "Deputy Head Teacher"),
 (4, "SLT"),
 (5, "M5 Teacher"),
 (6, "M6 Teacher"),
 (7, "U1 Teacher"),
 (8, "U2 Teacher"),
 (9, "TA"),
 (10, "HLTA");

CREATE Table employee (
  id INT NOT NULL PRIMARY KEY,
  title VARCHAR(50),
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  NI_number VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  address_id INT NOT NULL,
  jobtype_id INT,
  start_date DATE NOT NULL,
  end_date DATE,
    CONSTRAINT fk_employee_address_id
    FOREIGN KEY (address_id) 
    REFERENCES employee_address(id),
    CONSTRAINT fk_employee_jobtype_id
    FOREIGN KEY (jobtype_id)
    REFERENCES jobtype(id)
);

INSERT INTO employee
VALUES
  (1, "Mrs", "Afshan", "Ali", "JG974617B", "1980-05-10", 1, 5, "2022-09-01", NULL),
  (2, NULL, "Lynsey", "Black", "JC973477B", "1982-09-21", 2, 6, "2000-09-01", NULL),
  (3, "Mr", "Sam", "Dawes", "JG974286G", "1986-01-23", 3, 10, "2019-09-01", NULL),
  (4, "Mrs", "Aoife", "Halsey", "JG497017B", "1984-12-04", 4, 4, "2022-09-01", NULL),
  (5, "Mrs", "Afua", "Nairne", "JG497717B", "1978-03-10", 5, 7, "2015-09-01", NULL),
  (6, "Mrs", "Natalie", "Jones", "N8694617B", "1975-07-15", 6, 9, "2012-09-01", NULL),
  (7, "Mr", "Rob", "Mussels", "JG697817B", "1985-02-19", 7, 8, "2020-09-01", NULL),
  (8, "Mr", "Clark", "Jackson", "JG459617D", "1989-05-12", 8, 3, "2021-09-01", NULL),
  (9, "Ms", "Isabella", "Mabeka", "JG974377D", "1991-06-24", 8, 4, "2020-09-01", NULL),
  (10, "Mrs", "Gina", "Clarkson", "JF448617B", "1974-02-18", 9, 10, "2014-04-01", NULL),
  (11, "Ms", "Sumra", "Hussain", "JF588657B", "1984-12-18", 10, 5, "2022-01-01", NULL),
  (12, "Mrs", "Brian", "Thomas", "JF557717B", "1980-02-27", 11, 6, "2022-09-01", NULL),
  (13, "Mr", "Clive", "Hudson", "JF449757B", "1988-04-15", 12, 5, "2018-09-01", NULL),
  (14, "Mrs", "Phoebe", "Lile", "JF423447B", "1986-7-11", 13, 7, "2017-09-01", NULL),
  (15, "Mr", "Joshua", "Smith", "JF455597B", "1990-4-10", 11, 6, "2023-01-01", NULL);



CREATE TABLE salary (
  id INT NOT NULL PRIMARY KEY,
  employee_id INT,
  salary DECIMAL (10,2),
    CONSTRAINT fk_salary_employee_id
    FOREIGN KEY (employee_id)
    REFERENCES employee(id)
);

INSERT INTO salary
VALUES
  (1, 1, 35990.00),
  (2, 2, 40320.00),
  (3, 3, 28500.00),
  (4, 4, 48614.00),
  (5, 5, 43188.00),
  (6, 6, 22400.20),
  (7, 7,  46000.00),
  (8, 8, 50122.00),
  (9, 9, 45639.00),
  (10, 10, 24400.40),
  (11, 11, 35990.00),
  (12, 12, 38810.00),
  (13, 13, 39290.00),
  (14, 14, 40625.00),
  (15, 15, 48625.00),
  (16, 7, 1800.00),
  (17, 7, 2975.00),
  (18, 7, 600.00),
  (19, 5, 2563.00),
  (20, 13, 900.00),
  (21, 13, 1200.00),
  (22, 13, 1200.00);

CREATE TABLE employee_class (
  id INT NOT NULL PRIMARY KEY,
  employee_id INT NOT NULL,
  class_id INT NOT NULL,
    CONSTRAINT fk_employee_class_employee_id
    FOREIGN KEY (employee_id)
    REFERENCES employee(id),
    CONSTRAINT fk_employee_class_id
    FOREIGN KEY (class_id)
    REFERENCES class(id)
);

INSERT INTO  employee_class
VALUES
  (1, 1, 1),
  (2, 2, 2),
  (3, 3, 2),
  (4, 4, 3),
  (5, 5, 4),
  (6, 7, 5),
  (7, 8, 6),
  (8, 9, 7),
  (9, 10, 7),
  (10, 11, 8),
  (11, 12, 9),
  (12, 13, 10),
  (13, 14, 11),
  (14, 15, 12);

 
CREATE TABLE subject (
  id INT NOT NULL PRIMARY KEY,
  subject_name VARCHAR(50) NOT NULL
);

INSERT INTO subject
VALUES
  (1, "Reading"),
  (2, "Writing"),
  (3, "Spelling"),
  (4, "Arithmatic"),
  (5, "Verbal Reasoning"),
  (6, "Non-Verbal Reasoning"),
  (7, "Science"),
  (8, "Geography");


CREATE TABLE subject_lead (
  id INT NOT NULL PRIMARY KEY,
  subject_id INT NOT NULL,
  employee_id INT,
  start_date DATE,
  end_date DATE,
    CONSTRAINT fk_subject_lead_employee_id
    FOREIGN KEY (employee_id)
    REFERENCES employee(id),
    CONSTRAINT fk_subject_lead_subject_id
    FOREIGN KEY (subject_id)
    REFERENCES subject(id)
);

INSERT INTO subject_lead
VALUES
  (1, 1, 7, "2020-09-01", NULL),
  (2, 2, 7, "2020-09-01", NULL),
  (3, 3, 7, "2020-09-01", NULL),
  (4, 7, 5, "2019-09-01", NULL),
  (5, 4, 13, "2020-09-01", NULL),
  (6, 5, 13, "2020-09-01", NULL),
  (7, 6, 13, "2020-09-01", NULL);

CREATE TABLE attainment_level (
  id INT NOT NULL PRIMARY KEY,
  level_name VARCHAR(50) NOT NULL
);

INSERT INTO attainment_level
VALUES
  (1, "Working Above"),
  (2, "Working At"),
  (3, "Working Towards");


CREATE TABLE term (
  id INT NOT NULL PRIMARY KEY,
  term VARCHAR(50) NOT NULL,
  year YEAR
  );
  
  INSERT INTO term
  VALUES
    (1, "Autumn Term", 2020),
    (2, "Spring Term", 2020),
    (3, "Summer Term", 2020),
    (4, "Autumn Term", 2021),
    (5, "Spring Term", 2021),
    (6, "Summer Term", 2021),
    (7, "Autumn Term", 2022),
    (8, "Spring Term", 2022),
    (9, "Summer Term", 2022);

CREATE TABLE attainment (
  id INT NOT NULL PRIMARY KEY,
  pupil_id INT NOT NULL,
  subject_id INT NOT NULL,
  term_id INT NOT NULL,
  attainment_level_id INT NOT NULL,
    CONSTRAINT fk_attainment_pupil_id
    FOREIGN KEY (pupil_id)
    REFERENCES pupil(id),
    CONSTRAINT fk_attainment_subject_id
    FOREIGN KEY (subject_id)
    REFERENCES subject(id),
    CONSTRAINT fk_attainment_term_id
    FOREIGN KEY (term_id)
    REFERENCES term(id),
    CONSTRAINT fk_attainment_attainment_level_id
    FOREIGN KEY (attainment_level_id)
    REFERENCES attainment_level(id)
);

INSERT INTO attainment
VALUES
  (1, 1, 1, 7, 1),
  (2, 1, 2, 7, 1),
  (3, 1, 3, 7, 1),
  (4, 2, 1, 7, 2),
  (5, 2, 2, 7, 3),
  (6, 2, 3, 7, 3),
  (7, 3, 1, 7, 2),
  (8, 3, 2, 7, 2),
  (9, 3, 3, 7, 3),
  (10, 4, 1, 7, 3),
  (11, 4, 2, 7, 3),
  (12, 4, 3, 7, 3),
  (13, 5, 1, 7, 1),
  (14, 5, 2, 7, 2),
  (15, 5, 3, 7, 3),
  (16, 6, 1, 7, 2),
  (17, 6, 2, 7, 3),
  (18, 6, 3, 7, 3),
  (19, 1, 1, 8, 3),
  (20, 1, 2, 8, 3),
  (21, 1, 3, 8, 3),
  (22, 2, 1, 8, 2),
  (23, 2, 2, 8, 3),
  (24, 2, 3, 8, 2),
  (25, 3, 1, 8, 2),
  (26, 3, 2, 8, 2),
  (27, 3, 3, 8, 2),
  (28, 4, 1, 8, 2),
  (29, 4, 2, 8, 3),
  (30, 4, 3, 8, 1),
  (31, 5, 1, 8, 2),
  (32, 5, 2, 8, 3),
  (33, 5, 3, 8, 2),
  (34, 6, 1, 8, 2),
  (35, 6, 2, 8, 3),
  (36, 6, 3, 8, 2),
  (37, 7, 2, 7, 2),
  (38, 8, 2, 7, 2),
  (39, 9, 2, 7, 2),
  (40, 10, 2, 7, 1),
  (41, 7, 2, 8, 2),
  (42, 8, 2, 8, 3),
  (43, 9, 2, 8, 2),
  (44, 10, 2, 8, 1),
  (45, 14, 2, 7, 1),
  (46, 14, 2, 8, 3);

CREATE TABLE intervention_type (
  id INT NOT NULL PRIMARY KEY,
  intervention_name VARCHAR(50)
);

INSERT INTO intervention_type
VALUES
  (1, "play_therapy"),
  (2, "social_worker"),
  (3, "writing_group"),
  (4, "phonics"),
  (5, "SLT"),
  (6, "maths_group"),
  (7, "one-to-one");
  
CREATE TABLE intervention (
  id INT NOT NULL PRIMARY KEY,
  pupil_id INT NOT NULL,
  intervention_type_id INT NOT NULL,
    CONSTRAINT fk_intervention_pupil_id
    FOREIGN KEY (pupil_id)
    REFERENCES pupil(id),
    CONSTRAINT fk_intervention_intervention_type_id
    FOREIGN KEY (intervention_type_id)
    REFERENCES intervention_type(id)
  );
  
  INSERT INTO intervention
  VALUES
    (1, 1, 1),
    (2, 1, 2),
    (3, 4, 3),
    (4, 6, 4),
    (5, 6, 3),
    (6, 8, 5),
    (7, 8, 4),
    (8, 8, 6),
    (9, 8, 1),
    (10, 5, 5),
    (11, 9, 5),
    (12, 9, 4),
    (13, 9, 3),
    (14, 2, 7);
    

CREATE TABLE attendance_code (
  acode_id VARCHAR(50) NOT NULL PRIMARY KEY,
  description VARCHAR(50) NOT NULL
);

INSERT INTO attendance_code
VALUES
  ("/", "present"),
  ("I", "illness"),
  ("L", "late"),
  ("M", "medical/dental"),
  ("R", "religious observance"),
  ("O", "unauthorised abcence"),
  ("N", "not known");
  
CREATE TABLE attendance (
  id INT NOT NULL PRIMARY KEY,
  pupil_id INT NOT NULL,
  acode_id VARCHAR(50) NOT NULL,
	CONSTRAINT fk_attendance_acode_id
    FOREIGN KEY (acode_id)
    REFERENCES attendance_code(acode_id),
    CONSTRAINT fk_attendance_pupil_id
    FOREIGN KEY (pupil_id)
    REFERENCES pupil(id)
);

INSERT INTO attendance
VALUES
  (1, 1, "N"),
  (2, 2, "/"),
  (3, 3, "N"),
  (4, 4, "/"), 
  (5, 5, "N"), 
  (6, 6, "/"), 
  (7, 7, "N"), 
  (8, 1, "/"), 
  (9, 2, "/"),
  (10, 3, "/"),
  (11, 1, "N"),
  (12, 2, "/"),
  (13, 1, "/"),
  (14, 1, "/"),
  (15, 1, "N"),
  (16, 2, "/"),
  (17, 1, "/"),
  (18, 1, "N");

CREATE TABLE register (
  id INTEGER NOT NULL PRIMARY KEY,
  register_date DATE NOT NULL,
  attendance_id INT,
    CONSTRAINT fk_attendance_id
    FOREIGN KEY (attendance_id)
    REFERENCES attendance(id)
);

INSERT INTO register
VALUES
  (1, "2022-01-02", 1),
  (2, "2022-01-02", 2),
  (3, "2022-01-02", 3),
  (4, "2022-01-02", 4), 
  (5, "2022-01-02", 5), 
  (6, "2022-01-02", 6), 
  (7, "2022-01-02", 7), 
  (8, "2022-01-03", 8), 
  (9, "2022-01-03", 9),
  (10, "2022-01-03", 10),
  (11, "2022-01-09", 11),
  (12, "2022-01-09", 12),
  (13, "2022-01-10", 13),
  (14, "2022-01-11", 14),
  (15, "2022-01-016", 15),
  (16, "2022-01-016", 16),
  (17, "2022-01-017", 17),
  (18, "2022-01-23", 18);
  

CREATE TABLE gp (
  id INT NOT NULL PRIMARY KEY,
  gp_name VARCHAR(50) NOT NULL,
  gp_street VARCHAR(50) NOT NULL,
  post_code_id INT NOT NULL,
  country_id INT,
  gp_telephone_number VARCHAR(50) NOT NULL,
    CONSTRAINT fk_gp_post_code_id
    FOREIGN KEY (post_code_id)
    REFERENCES post_code(id),
	CONSTRAINT fk_gp_country_id
    FOREIGN KEY (country_id)
    REFERENCES country(id)
);

INSERT INTO gp 
VALUES
  (1, "Handsworth Medical Practice", "Castle Avenue", 23, 1, "02056789076"),
  (2, "Leyton Medical Practice", "Main Street", 24, 1, "02081234567"),
  (3, "Chingford Medical Practice", "Chingford Avenue", 25, 1, "02084567890");
  
CREATE TABLE medical_condition (
  id INT NOT NULL PRIMARY KEY,
  condition_name VARCHAR(50)
);

INSERT INTO medical_condition
VALUES
  (1, "asthma"),
  (2, "eczema"),
  (3, "nut allergy"),
  (4, "dairy allergy"),
  (5, "febrile convulsions");
  
CREATE TABLE medication (
  id INT NOT NULL PRIMARY KEY,
  medication_name VARCHAR(50)
);

INSERT INTO medication 
VALUES
  (1, "blue pump"),
  (2, "Steroid Cream"),
  (3, "epipen"),
  (4, "calopol"),
  (5, "none");

CREATE TABLE medical (
    id INT NOT NULL PRIMARY KEY,
    pupil_id INT NOT NULL,
    medical_condition_id INT,
    medication_id INT,
    gp_id INT NOT NULL,
      CONSTRAINT fk_medical_pupil_id
      FOREIGN KEY (pupil_id)
      REFERENCES pupil(id),
      CONSTRAINT fk_medical_medical_condition_id
      FOREIGN KEY (medical_condition_id)
      REFERENCES medical_condition(id),
      CONSTRAINT fk_medical_medication_id
      FOREIGN KEY (medication_id)
      REFERENCES medication(id),
	  CONSTRAINT fk_gp_id
      FOREIGN KEY (gp_id)
      REFERENCES gp(id)
  );
  
  INSERT INTO medical
  VALUES
    (1, 1, 5, 5, 1),
    (2, 2, 3, 3, 1),
    (3, 3, 2, 2, 2),
    (4, 4, 5, 4, 1);
    
CREATE TABLE attendance_percentage (
  id INT NOT NULL PRIMARY KEY,
  pupil_id INT NOT NULL,
  term_id INT NOT NULL,
  attendance_percentage INT NOT NULL,
    CONSTRAINT fk_attendance_percentage_pupil_id
    FOREIGN KEY (pupil_id)
    REFEReNCES pupil(id),
    CONSTRAINT fk_attendance_percentage_term_id
    FOREIGN KEY (term_id)
    REFEReNCES term(id)
);

INSERT INTO attendance_percentage
VALUES
  (1, 1, 8, 65),
  (2, 2, 8, 90),
  (3, 3, 8, 90),
  (4, 4, 8, 100),
  (5, 5, 8, 85),
  (6, 6, 8, 95),
  (7, 7, 8, 100),
  (8, 8, 8, 100),
  (9, 1, 7, 70),
  (10, 2, 7, 100),
  (11, 3, 7, 98),
  (12, 4, 7, 100),
  (13, 5, 7, 100),
  (14, 6, 7, 98),
  (15, 7, 7, 99),
  (16, 8, 7, 100);
  

