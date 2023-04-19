---справочник типа программы-----
CREATE TABLE IF NOT EXISTS program_type_ref(
	type_id 	 INTEGER 	  NOT NULL,
	program_type VARCHAR(200) NOT NULL,
	
	CONSTRAINT type_pk PRIMARY KEY (type_id)
);

---справочник статуса договора-----
CREATE TABLE IF NOT EXISTS contract_status_ref(
	status_id 	 INTEGER 	  NOT NULL,
	status		 VARCHAR(200) NOT NULL,
	
	CONSTRAINT status_pk PRIMARY KEY (status_id)
);

---учебный предмет--------
CREATE TABLE IF NOT EXISTS course(
	course_id 	INTEGER 	 NOT NULL,
	course_nm 	VARCHAR(100) NOT NULL,
	direction	VARCHAR(100) NOT NULL,
	description VARCHAR(200) NOT NULL,
	type 		INTEGER		 NOT NULL,
	
	
	CONSTRAINT course_pk PRIMARY KEY (course_id),
	CONSTRAINT fk_course_type FOREIGN KEY (type)
		REFERENCES program_type_ref ON DELETE SET NULL
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
	starttime 		TIMESTAMP	 NOT NULL,
	endtime			TIMESTAMP,
	is_current		INTEGER		 NOT NULL,
	department		VARCHAR(200),
	
	CONSTRAINT instr_pk PRIMARY KEY (instr_id),
	CONSTRAINT fk_instr_person FOREIGN KEY (person_id)
		REFERENCES person ON DELETE SET NULL,
	CONSTRAINT fk_instr_company FOREIGN KEY (company_id)
		REFERENCES company ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS program(
	program_id 	INTEGER		 NOT NULL,
	program_nm 	VARCHAR(100) NOT NULL,
	direction	VARCHAR(100) NOT NULL,
	description VARCHAR(200) NOT NULL,
	duration	INTEGER		 NOT NULL,
	type 		INTEGER		 NOT NULL,
	
	CONSTRAINT program_pk PRIMART KEY 
)

CREATE TABLE IF NOT EXISTS contract(
	contract_id INTEGER		NOT NULL,
	person_id   INTEGER   	NOT NULL,
	company_id  INTEGER   	NOT NULL,
	starttime 	INTEGER 	NOT NULL,
	status		INTEGER		NOT NULL,
	
	CONSTRAINT contract_pk PRIMARY KEY (contract_id),
	CONSTRAINT fk_contract_person FOREIGN KEY (person_id)
		REFERENCES 
	CONSTRAINT fk_contract_company FOREIGN KEY (company_id),
	CONSTRAINT fk_contract_status FOREIGN KEY (status)
);

