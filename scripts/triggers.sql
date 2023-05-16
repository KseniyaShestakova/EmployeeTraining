DROP SEQUENCE IF EXISTS person_id_seq;
CREATE SEQUENCE person_id_seq START 20;

CREATE OR REPLACE FUNCTION set_person_id()
RETURNS TRIGGER AS
$$
BEGIN
	UPDATE person SET person_id=nextval('person_id_seq')
	WHERE person_id = NEW.person_id OR person_id IS NULL;
	RETURN NULL;
END;
$$ language plpgsql;

CREATE OR REPLACE TRIGGER person_insert_trigger
AFTER INSERT ON person
FOR EACH ROW 
EXECUTE FUNCTION set_person_id();

---проверка того, что это работает, в т.ч. с множественным INSERT
INSERT INTO person VALUES
	(22, 'Алла', 'Павловна', 'Баранчикова', 'BN3111111', '2004-04-02'),
	(23, 'Анна', 'Павловна', 'Баранчикова', 'BN2111111', '2004-04-02'),
	(24, 'Вера', 'Павловна', 'Баранчикова', 'BN4111111', '2004-04-02');
	
-------------------------------------------------------------------
DROP SEQUENCE IF EXISTS company_id_seq;
CREATE SEQUENCE company_id_seq START 10;

CREATE OR REPLACE FUNCTION set_company_id()
RETURNS TRIGGER AS
$$
BEGIN
	UPDATE company_id SET company_id=nextval('company_id_seq')
	WHERE company_id = NEW.company_id OR company_id IS NULL;
	RETURN NULL;
END;
$$ language plpgsql;

CREATE OR REPLACE TRIGGER company_insert_trigger
AFTER INSERT ON company
FOR EACH ROW 
EXECUTE FUNCTION set_company_id();
--------------------------------------------------------------
---в предположении того, что одновременно можно быть инструктором только на одном курсе

SELECT * FROM instructor

DROP SEQUENCE IF EXISTS instr_id_seq;
CREATE SEQUENCE instr_id_seq START 11;

CREATE OR REPLACE FUNCTION process_instructor_insert()
RETURNS TRIGGER AS
$$
BEGIN
	---исправляем дату начала, чтобы не было добавлений "задним числом"
	UPDATE instructor SET starttime=CURRENT_TIMESTAMP
	WHERE instr_id = NEW.instr_id AND starttime < CURRENT_TIMESTAMP;
	
	---обнуляем предыдущую запись про того же человека
	UPDATE instructor SET endtime=CURRENT_TIMESTAMP, is_current=0
	WHERE person_id = NEW.person_id AND NOT(instr_id = NEW.instr_id)
		AND (endtime > CURRENT_TIMESTAMP OR endtime IS NULL);
	
	---проставляем статус актуальности
	UPDATE instructor SET is_current=1
	WHERE instr_id = NEW.instr_id OR instr_id IS NULL;

	---обновляем id записи
	UPDATE instructor SET instr_id=nextval('instr_id_seq')
	WHERE instr_id = NEW.instr_id OR instr_id IS NULL;
	
	RETURN NULL;
END;
$$ language plpgsql;

CREATE OR REPLACE TRIGGER instructor_insert_trigger
AFTER INSERT ON instructor
FOR EACH ROW
EXECUTE FUNCTION process_instructor_insert();

SELECT * FROM instructor;

INSERT INTO instructor VALUES
	(40, 5, 6, 'преподаватель английской литературы', 'ДИЯ', '2024-04-20', NULL, 0),
	(50, 0, 0, 'ответственный за информационную безопасность', 'IT-отдел', '2023-04-20', NULL, 0);
	
	
