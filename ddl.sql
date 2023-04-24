---удаление таблиц на случай, если они существут---
DROP TABLE IF EXISTS contract CASCADE;
DROP TABLE IF EXISTS payment  CASCADE;
DROP TABLE IF EXISTS program CASCADE;
DROP TABLE IF EXISTS course CASCADE;
DROP TABLE IF EXISTS person CASCADE;
DROP TABLE IF EXISTS company CASCADE;
DROP TABLE IF EXISTS instructor CASCADE;
DROP TABLE IF EXISTS program_course CASCADE;
DROP TABLE IF EXISTS contract_status_ref CASCADE;
DROP TABLE IF EXISTS program_type_ref CASCADE;
DROP TABLE IF EXISTS payer_ref CASCADE;



---справочник типа программы-----
CREATE TABLE IF NOT EXISTS program_type_ref(
	type_id 	 INTEGER 	  NOT NULL,
	program_type VARCHAR(200) NOT NULL,
	
	CONSTRAINT type_pk PRIMARY KEY (type_id)
);

---справочник плательщиков-----
CREATE TABLE IF NOT EXISTS payer_ref(
	payer_id	INTEGER 	 NOT NULL,
	payer_type  VARCHAR(200) NOT NULL,
	
	CONSTRAINT payer_pk PRIMARY KEY (payer_id)
);

---справочник статуса договора-----
CREATE TABLE IF NOT EXISTS contract_status_ref(
	status_id 	 INTEGER 	  NOT NULL,
	status		 VARCHAR(200) NOT NULL,
	
	CONSTRAINT status_pk PRIMARY KEY (status_id)
);

---физическое лицо---
CREATE TABLE IF NOT EXISTS person(
	person_id 	INTEGER 	 NOT NULL,
	firstname 	VARCHAR(100) NOT NULL,
	secondname 	VARCHAR(100),
	surname 	VARCHAR(100) NOT NULL,
	pass_num	VARCHAR(100) NOT NULL,
	birthdate 	TIMESTAMP 	 NOT NULL,
	
	CONSTRAINT person_pk PRIMARY KEY (person_id)
);

---юридическое лицо----
CREATE TABLE IF NOT EXISTS company(
	company_id 	INTEGER		 NOT NULL,
	name		VARCHAR(250) NOT NULL,
	inn			VARCHAR(30)  NOT NULL,
	kpp 		VARCHAR(30)  NOT NULL,
	
	CONSTRAINT company_pk PRIMARY KEY (company_id)
);

---инструктор---
CREATE TABLE IF NOT EXISTS instructor(
	instr_id	 	INTEGER 	 NOT NULL,
	person_id 		INTEGER		 NOT NULL,
	company_id 		INTEGER		 NOT NULL,
	specialization  VARCHAR(200),
	department		VARCHAR(200),
	starttime 		TIMESTAMP	 NOT NULL,
	endtime			TIMESTAMP,
	is_current		INTEGER		 NOT NULL,
	
	CONSTRAINT instr_pk PRIMARY KEY (instr_id),
	CONSTRAINT fk_instr_person FOREIGN KEY (person_id)
		REFERENCES person ON DELETE SET NULL,
	CONSTRAINT fk_instr_company FOREIGN KEY (company_id)
		REFERENCES company ON DELETE SET NULL
);

---учебный предмет--------
CREATE TABLE IF NOT EXISTS course(
	course_id 	INTEGER 	 NOT NULL,
	course_nm 	VARCHAR(100) NOT NULL,
	direction	VARCHAR(100) NOT NULL,
	description VARCHAR(200) NOT NULL,
	duration 	INTEGER		 NOT NULL,
	
	instructor_id INTEGER NOT NULL,
	starttime 		TIMESTAMP	 NOT NULL,
	endtime			TIMESTAMP,
	is_current		INTEGER		 NOT NULL,
	
	CONSTRAINT course_pk PRIMARY KEY (course_id),
	CONSTRAINT fk_course_instr FOREIGN KEY (instructor_id)
		REFERENCES instructor ON DELETE SET NULL
);

---программа---
CREATE TABLE IF NOT EXISTS program(
	program_id 	INTEGER		 NOT NULL,
	program_nm 	VARCHAR(100) NOT NULL,
	direction	VARCHAR(100) NOT NULL,
	description VARCHAR(200) NOT NULL,
	type 		INTEGER		 NOT NULL,
	
	CONSTRAINT program_pk PRIMARY KEY (program_id),
	CONSTRAINT fk_program_type FOREIGN KEY (type)
		REFERENCES program_type_ref ON DELETE SET NULL	
);

---связь предмета и программы---
CREATE TABLE IF NOT EXISTS program_course(
	id 			INTEGER		NOT NULL,
	program_id  INTEGER		NOT NULL,
	course_id	INTEGER		NOT NULL,
	starttime	TIMESTAMP	NOT NULL,
	endttime	TIMESTAMP,
	is_current	INTEGER		NOT NULL,
	
	CONSTRAINT program_course_pk PRIMARY KEY (id),
	CONSTRAINT fk_program_course_program FOREIGN KEY (program_id)
		REFERENCES program ON DELETE SET NULL,
	CONSTRAINT fk_program_course_course FOREIGN KEY (course_id)
		REFERENCES course ON DELETE SET NULL
);

---договор---
CREATE TABLE IF NOT EXISTS contract(
	contract_id INTEGER		NOT NULL,
	person_id   INTEGER   	NOT NULL,
	company_id  INTEGER   	NOT NULL,
	starttime 	INTEGER 	NOT NULL,
	program_id	INTEGER		NOT NULL,
	status		INTEGER		NOT NULL,
	
	CONSTRAINT contract_pk PRIMARY KEY (contract_id),
	CONSTRAINT fk_contract_person FOREIGN KEY (person_id)
		REFERENCES person ON DELETE SET NULL,
	CONSTRAINT fk_contract_program FOREIGN KEY (program_id)
		REFERENCES program ON DELETE SET NULL,
	CONSTRAINT fk_contract_company FOREIGN KEY (company_id)
		REFERENCES company ON DELETE SET NULL,
	CONSTRAINT fk_contract_status FOREIGN KEY (status)
		REFERENCES contract_status_ref ON DELETE SET NULL
);

---квитанция об оплате договора---
CREATE TABLE IF NOT EXISTS payment(
	payment_id		INTEGER		NOT NULL,
	starttime		TIMESTAMP 	NOT NULL,
	endtime			TIMESTAMP	NOT NULL,
	contract_id		INTEGER		NOT NULL,
	payer			INTEGER		NOT NULL,
	date 			TIMESTAMP	NOT NULL,
	sum				INTEGER		NOT NULL,
	
	CONSTRAINT payment_pk	PRIMARY KEY (payment_id),
	CONSTRAINT fk_payment_contract FOREIGN KEY (contract_id)
		REFERENCES contract ON DELETE SET NULL,
	CONSTRAINT fk_payment_payer FOREIGN KEY (payer)
		REFERENCES payer_ref ON DELETE SET NULL
);

