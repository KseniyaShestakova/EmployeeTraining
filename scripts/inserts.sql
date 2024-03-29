---ВСЕ СОВПАДЕНИЯ С РЕАЛЬНЫМИ ЛЮДЬМИ И КОМПАНИЯМИ СЛУЧАЙНЫ---

TRUNCATE TABLE contract_status_ref CASCADE;
TRUNCATE TABLE program_type_ref CASCADE;
TRUNCATE TABLE payer_ref CASCADE;
TRUNCATE TABLE person CASCADE;
TRUNCATE TABLE company CASCADE;


---заполнение справочника статуса договора---
INSERT INTO contract_status_ref VALUES (0, 'Отчислен(а)');
INSERT INTO contract_status_ref VALUES (1, 'Учится');
INSERT INTO contract_status_ref VALUES (2, 'Обучение завершено');

---заполнение справочника типа программы---
INSERT INTO program_type_ref VALUES (0, 'Повышение квалификации');
INSERT INTO program_type_ref VALUES (1, 'Переподготовка');
INSERT INTO program_type_ref VALUES (2, 'Курсы для начинающих и стажеров');

---заполнени справочника плательщиков---
INSERT INTO payer_ref VALUES (0, 'Физическое лицо');
INSERT INTO payer_ref VALUES (1, 'Юридическое лицо');
	

---заполнение данных о физических лицах---
INSERT INTO person VALUES (0, 'Ксения', 'Олеговна', 'Шестакова', 'BM2222222', '2004-04-02');
INSERT INTO person VALUES (1, 'Алла', 'Викторовна', 'Иванова', 'BM2222220', '2000-04-10');
INSERT INTO person VALUES (2, 'Иван', 'Петрович', 'Смирнов', 'BM2224522', '1995-11-23');
INSERT INTO person VALUES (3, 'Дмитрий', 'Павлович', 'Корнейчук', 'BC9925222', '1970-12-29');	
INSERT INTO person VALUES (4, 'Ирина', NULL, 'Корнейчук', 'MM9925522', '1971-12-28');
INSERT INTO person VALUES (5, 'Владимир', 'Иванович', 'Снежков', 'BM9825820', '1965-07-13');
INSERT INTO person VALUES (6, 'Петр', 'Валерьевич', 'Аленькин', 'BB9005820', '1980-08-08');
INSERT INTO person VALUES (7, 'Инна', 'Игнатовна', 'Штрих', 'BB9005823', '1983-09-18');
INSERT INTO person VALUES (8, 'Павел', 'Павлович', 'Луговой', 'BB1015820', '1999-12-08');
INSERT INTO person VALUES (9, 'Арина', 'Михайловна', 'Виленькина', 'BB9011821', '2000-05-10');


---заполнение данных о юридических лицах---
---бухгалтерия---
INSERT INTO company VALUES
		(0, 'Шнайдер Групп', '7718239655', '770701001');
INSERT INTO company VALUES
		(1, '1C WiseAdvice', '7721641003', '772101001');
INSERT INTO company VALUES
		(2, 'Unicon Outsourcing', '7716021332', '772601001');
INSERT INTO company VALUES
		(3, 'Мое дело', '7701889831', '771401001');
---образовательные организации---
INSERT INTO company VALUES
		(4, 'МБОУ г.Новосибирска С(К) ШКОЛА № 14', '5404164130', '540401001');
INSERT INTO company VALUES
		(5, 'МКС(к)ОУ Школа № 67 Г. Кирова', '4349005569', '434501001');
INSERT INTO company VALUES
		(6, 'ГБПОУ Московской обл. "Колледж "ПОДМОСКОВЬЕ"', '5044000825', '504401001');
INSERT INTO company VALUES
		(7, 'ГБПОУ МО "Щелковский Колледж"', '5050047532', '505001001');
---другие организации---
INSERT INTO company VALUES
		(8, 'ООО "Организация"', '7736509061', '773601001');
INSERT INTO company VALUES
		(9, 'ООО "Инн-Огрн"', '7727718446', '772701001');		
		
---заполнение данных об инструкторов---
INSERT INTO instructor VALUES 
		(0, 0, 7, 'преподаватель химии',
		 'Кафедра химии и биологии', '2022-09-01', '2023-07-01', 0);
INSERT INTO instructor VALUES
		(1, 0, 7, 'преподаватель инструментов 1С', 'Кафедра АТП',
		'2023-09-01', NULL, 1);
INSERT INTO instructor VALUES
		(3, 1, 7, 'преподаватель английского языка', 'ДИЯ',
		'2022-10-01', NULL, 1);
INSERT INTO instructor VALUES
		(2, 1, 7, 'преподаватель французского языка',
		'ДИЯ', '2021-07-01', '2022-07-01', 0);
INSERT INTO instructor VALUES
		(4, 3, 8, 'Старший по безопасности',  'Отдел безопасности',
		'2000-09-01', NULL, 1);
INSERT INTO instructor VALUES
		(5, 7, 1, 'старший бухгалтер', 'отдел правоведения',
		'2004-10-02', NULL, 1);
INSERT INTO instructor VALUES
		(6, 0, 0, 'специалист по информационным технологиям', 'IT-отдел',
		'1995-08-20', '2005-08-20', 0);
INSERT INTO instructor VALUES
		(7, 0, 0, 'специалист по финансовой грамотности', 'отдел финансовой грамотности',
		'2005-08-20', NULL, 1);
INSERT INTO instructor VALUES
		(8, 4, 2, 'бухгалтер', 'отдел оптимизаций',
		'2010-09-01', '2014-06-15', 0);
INSERT INTO instructor VALUES
		(9, 2, 3, 'стажер, младший бухгалтер',
		'отдел маркетинга', '2022-01-01', '2022-06-01', 0);



---заполнение таблицы с предметами---
INSERT INTO course VALUES
		(0, 'Анализ финансовой отчетности',
		'Бухгалтерский учет', 
		'Продвинутый курс по финансовой отчетности для профбухгалтеров',
		40, 5, '2004-10-02', NULL, 1); ---0---
INSERT INTO course VALUES
		(1, 'Бухгалтерский управленческий учет',
		'Бухгалтерский учет', 
		'Составление основных плановых документов на примере условной организации',
		40, 5, '2005-10-02', NULL, 1); ---0---
INSERT INTO course VALUES
		(2, 'Бухгалтерский учет и налогооблажение в строительных организациях',
		'Бухгалтерский учет', 
		'Вопросы налогооблажения, правового регулирования и бухучета в строительных организациях',
		80, 8, '2011-09-01', '2012-12-12', 0); ---1---
INSERT INTO course VALUES
		(3, 'Основы бухгалтерского учета в бюджетных организациях',
		'Бухгалтерский учет', 
		'Особенности ведения бухучета на бюджетных предприятиях на примере реальной компании',
		20, 8, '2010-09-01', '2013-06-15', 0); ---2---
INSERT INTO course VALUES
		(4, 'Бухгалтерский учет с помощью инструментов 1С',
		'Бухгалтерский учет', 
		'Введение в использование инструментов ПО 1С',
		40, 1, '2023-09-01', '2024-07-01', 1);
INSERT INTO course VALUES
		(5, 'Английский язык для делового общения',
		'Иностранные языки', 
		'Написание деловых писем, составление документов и устное деловое общение на английском языке',
		30, 3, '2022-12-01', NULL, 1);
INSERT INTO course VALUES
		(6, 'Формирование финансовой грамотности обучающихся',
		'Педагогика', 
		'Подготовка к преподаванию фин.грамотности',
		36, 7, '2006-09-01', '2010-09-01', 0); --1--
INSERT INTO course VALUES
		(7, 'Прикладной анализ поведения',
		'Педагогика', 
		'Курс обучения доказательным подходам обучения, развития и коррекции поведения у детей с ОВЗ',
		72, 4, '2005-09-01', '2007-09-01', 0);
INSERT INTO course VALUES
		(8, 'Обеспечение пожарной безопасности в образовательных организациях',
		'Безопасность жизнедеятельности', 
		'Совершенствование профессиональных компетенций педагогов и иных работников ОО в области обеспечения пожарной безопасности',
		30, 4, '2022-09-01', '2023-09-01', 1);
INSERT INTO course VALUES
		(9, 'Методика обучения школьников проведению мониторинга состояния окружающей среды',
		'Преподавание химии', 
		'Анализ состояния окружающей среды для школьников',
		18, 0, '2022-09-01', '2023-07-01', 1);

---заполнение таблицы с программами---
INSERT INTO program VALUES
		(0, 'Продвинутая финансовая отчетность',
		'Бухгалтерский учет', 'Программа для проф. бухгалтеров', 0);
INSERT  INTO program VALUES
		(1, 'Бухгалтерский учет в строительных организациях',
		'Бухгалтерский учет', 'Программа переподготовки проф. бухгалтеров', 1);
INSERT  INTO program VALUES
		(2, 'Бухгалтерский учет для начинающих',
		'Бухгалтерский учет', 'Основы бухгалтерского учета', 2);
INSERT  INTO program VALUES
		(3, 'Успешный классный руководитель',
		'Пдагогика', 'Повышение компетентности классного руководителя', 0);
INSERT INTO program VALUES
		(4, 'Безопасность жизнедеятельности в образовательных организациях',
		'Педагогика', 'Программа для сотрудников школ и детских садов', 1);

---заполнение связей между программами и курсами---
INSERT INTO program_course VALUES (0, 0, 0, '2005-10-02', NULL, 1);
INSERT INTO program_course VALUES (1, 0, 1, '2005-10-02', NULL, 1);	
INSERT INTO program_course VALUES (2, 0, 4, '2023-09-01', NULL, 1);
INSERT INTO program_course VALUES (3, 0, 5, '2022-12-01', NULL, 1);
INSERT INTO program_course VALUES (4, 1, 0, '2010-09-01', '2012-12-12', 0);
INSERT INTO program_course VALUES (5, 1, 2, '2011-09-01', '2012-12-12', 0);
INSERT INTO program_course VALUES (6, 1, 3, '2010-09-01', '2012-12-12', 0);
INSERT INTO program_course VALUES (7, 1, 1, '2010-09-01', NULL, 0);
INSERT INTO program_course VALUES (8, 2, 3, '2010-09-01', '2013-06-15', 0);
INSERT INTO program_course VALUES (9, 2, 0, '2013-06-15', NULL, 1);
INSERT INTO program_course VALUES (10, 3, 6, '2006-09-01', '2010-09-01', 0);
INSERT INTO program_course VALUES (11, 3, 7, '2005-09-01', '2007-09-01', 0);
INSERT INTO program_course VALUES (12, 3, 9, '2022-09-01', NULL, 1);
INSERT INTO program_course VALUES (13, 3, 8, '2022-09-01', NULL, 1);
INSERT INTO program_course VALUES (14, 4, 8, '2022-09-01', NULL, 1);
	

---заполнение договоров---
INSERT INTO contract VALUES (0, 0, 0, '2023-09-01', 2, 1);
INSERT INTO contract VALUES (1, 1, 0, '2020-09-01', 2, 2);
INSERT INTO contract VALUES (2, 1, 0, '2023-09-01', 0, 1);
INSERT INTO contract VALUES (3, 6, 3, '2022-09-01', 4, 1);
INSERT INTO contract VALUES (4, 6, 6, '2005-09-01', 3, 0);
INSERT INTO contract VALUES (5, 6, 6, '2006-09-01', 3, 2);
INSERT INTO contract VALUES (6, 7, 3, '2006-09-01', 1, 2);
INSERT INTO contract VALUES (7, 7, 0, '2023-09-01', 0, 1);
INSERT INTO contract VALUES (8, 8, 1, '2023-09-01', 3, 2);
INSERT INTO contract VALUES (9, 8, 1, '2023-09-01', 2, 1);

---заполнение данных об оплатах договоров---
INSERT INTO payment VALUES (0, '2006-09-01', '2007-09-01', 5, 1, '2006-09-02', 60000);
INSERT INTO payment VALUES (1, '2007-09-01', '2008-09-01', 5, 1, '2007-09-07', 63000);
INSERT INTO payment VALUES (2, '2008-09-01', '2009-09-01', 5, 1, '2008-09-02', 64500);
INSERT INTO payment VALUES (3, '2006-09-01', '2007-09-01', 6, 0, '2006-09-02', 70000);
INSERT INTO payment VALUES (4, '2007-09-01', '2008-09-01', 6, 0, '2007-09-07', 73000);
INSERT INTO payment VALUES (5, '2008-09-01', '2009-09-01', 6, 0, '2008-09-02', 74500);
INSERT INTO payment VALUES (6, '2023-09-01', '2024-01-01', 0, 1, '2023-09-15', 80000);
INSERT INTO payment VALUES (7, '2020-09-01', '2021-01-01', 1, 0, '2020-09-15', 65000);
INSERT INTO payment VALUES (8, '2021-01-01', '2021-09-01', 1, 0, '2021-01-15', 65500);
INSERT INTO payment VALUES (9, '2021-09-01', '2022-01-01', 1, 0, '2021-10-15', 70000);
