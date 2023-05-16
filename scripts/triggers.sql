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
---в предположении того, что одновременно можно быть инструктором только на одном курсе

SELECT * FROM instructor

DROP SEQUENCE IF EXISTS person_id_seq;
CREATE SEQUENCE person_id_seq START 11;
