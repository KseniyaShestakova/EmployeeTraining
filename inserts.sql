TRUNCATE TABLE contract_status_ref CASCADE;
TRUNCATE TABLE program_type_ref CASCADE;
TRUNCATE TABLE payer_ref CASCADE;


---заполнение справочника статуса договора---
INSERT INTO contract_status_ref VALUES (0, 'Отчислен(а)');
INSERT INTO contract_status_ref VALUES (1, 'Учится');
INSERT INTO contract_status_ref VALUES (2, 'Обучение завершено');

---заполнение справочника типа программы---
INSERT INTO program_type_ref VALUES (0, 'Повышение квалификации');
INSERT INTO program_type_ref VALUES (1, 'Переподготовка');
INSERT INTO program_type_ref VALUES (2, 'Курсы для начинающих и стажеров');

---заполнения справочника плательщиков---
INSERT INTO payer_ref VALUES (0, 'Физическое лицо');
INSERT INTO payer_ref VALUES (1, 'Юридическое лицо');


---заполнение таблицы с предметами---
INSERT INTO course VALUES
		(0, 'Анализ финансовой отчетности',
		'Бухгалтерский учет', 
		'Продвинутый курс по финансовой отчетности для профбухгалтеров',
		0);
INSERT INTO course VALUES
		(1, 'Бухгалтерский управленческий учет',
		'Бухгалтерский учет', 
		'Составление основных плановых документов на примере условной организации',
		0);
INSERT INTO course VALUES
		(2, 'Бухгалтерский учет и налогооблажение в строительных организациях',
		'Бухгалтерский учет', 
		'Вопросы налогооблажения, правового регулирования и бухучета в строительных организациях',
		1);
INSERT INTO course VALUES
		(3, 'Основы бухгалтерского учета в бюджетных организациях',
		'Бухгалтерский учет', 
		'Особенности ведения бухучета на бюджетных предприятиях на примере реальной компании',
		2);





