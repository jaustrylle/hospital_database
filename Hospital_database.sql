CREATE TABLE specialization(
	field_id	VARCHAR(10) PRIMARY KEY,
    occupation	varchar(10)
);

CREATE TABLE staff(
	staff_id		INT PRIMARY KEY,
	name			VARCHAR(30),
    field_id		VARCHAR(10),
    office_no       VARCHAR(20),
    Foreign Key (field_id) references specialization(field_id)
);

CREATE TABLE patient (
  patient_id    INT PRIMARY KEY,
  name          VARCHAR(30) NOT NULL,
  age           INT,
  gender        ENUM('M','F'),
  weight		float(5, 2),
  phone_number  VARCHAR(20)
);

CREATE TABLE prescriptions (
  prescription_id INT PRIMARY KEY,
  name            VARCHAR(30),
  type            VARCHAR(20),
  price           float(10, 2)
);

CREATE TABLE treatments(
  prescription_id  INT PRIMARY KEY,
  staff_id         INT NOT NULL,
  patient_id       INT NOT NULL,
  date_received    DATETIME,
  FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescription_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE appointments (
  appointment_id	INT PRIMARY KEY,
  patient_id        INT NOT NULL,
  staff_id          INT NOT NULL,
  appointment_date  DATETIME NOT NULL,
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE bills (
  bill_id			INT PRIMARY KEY,
  prescription_id 	INT NOT NULL, 
  patient_id   		INT NOT NULL,
  total_amount 		DECIMAL(14,2) NOT NULL DEFAULT 0,
  quantity			INT,
  FOREIGN KEY (prescription_id) REFERENCES prescriptions(prescription_id) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id) ON DELETE CASCADE ON UPDATE CASCADE,
  CHECK (total_amount >= 0)
);

CREATE TABLE schedules (
    staff_id		INT,                      
    appointment_id 	INT,                
    date_scheduled 	DATETIME NOT NULL,
    PRIMARY KEY (staff_id, appointment_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE CASCADE ON UPDATE CASCADE
);
