CREATE VIEW [ПРЕПОДАВАТЕЛИ]
	AS SELECT TEACHER.TEACHER, TEACHER.TEACHER_NAME, TEACHER.GENDER, TEACHER.PULPIT
		FROM TEACHER;

CREATE VIEW [КОЛИЧЕСТВО_КАФЕДР]
	AS SELECT FACULTY.FACULTY, COUNT(*)[количество_кафедр]
		FROM FACULTY JOIN PULPIT
			ON FACULTY.FACULTY = PULPIT.FACULTY
			GROUP BY FACULTY.FACULTY;

ALTER VIEW [Аудитории](Код, Тип, Аудитория)
	AS SELECT AUDITORIUM.AUDITORIUM,AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_NAME
		FROM AUDITORIUM
			WHERE AUDITORIUM.AUDITORIUM_TYPE LIKE 'ЛК%' WITH CHECK OPTION
DROP VIEW [Аудитории]; 
INSERT Аудитории values('107-3','ЛБ-К', '107-3')
DELETE from Аудитории where Код like '236-1%'
UPDATE Аудитории set Код = '10000' where Аудитория like '313-1%'


ALTER VIEW [Дисциплины]
	AS SELECT TOP 10 SUBJECT.SUBJECT, SUBJECT.SUBJECT_NAME, SUBJECT.PULPIT
		FROM SUBJECT
			order by SUBJECT.SUBJECT_NAME

CREATE VIEW [КОЛИЧЕСТВО_КАФЕДР2]
WITH SCHEMABINDING
AS
SELECT FACULTY.FACULTY, COUNT(*)[количество_кафедр]
FROM dbo.FACULTY
JOIN dbo.PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY
GROUP BY FACULTY.FACULTY;

use Glushko_MyBase
CREATE VIEW [ПРЕПОДАВАТЕЛИ_моя_бд]
	AS SELECT *
		FROM ПРЕПОДАВАТЕЛИ a;

CREATE VIEW [ЛК_ЗАНЯТИЯ]
	AS SELECT ГРУППЫ.Номер_группы, COUNT(*)[количество_предметов]
		FROM ГРУППЫ JOIN ПРЕДМЕТЫ
			ON ГРУППЫ.Номер_группы = ПРЕДМЕТЫ.Номер_группы
			GROUP BY ГРУППЫ.Номер_группы;

ALTER VIEW [ПредметыЛК](Код, Тип, Количество_часов)
	AS SELECT ПРЕДМЕТЫ.Предмет,ПРЕДМЕТЫ.Тип_занятия, ПРЕДМЕТЫ.Количество_часов
		FROM ПРЕДМЕТЫ
			WHERE ПРЕДМЕТЫ.Тип_занятия LIKE 'лк%'
INSERT ПредметыЛК values('Белорусский','лк', 128)
DELETE from ПредметыЛК where Код like 'Белорусский%'
UPDATE ПредметыЛК set Код = 'Русский' where Код like 'Белорусский%'



CREATE VIEW [ПредметыАЛФ]
	AS SELECT TOP 3 ПРЕДМЕТЫ.Предмет,ПРЕДМЕТЫ.Тип_занятия, ПРЕДМЕТЫ.Количество_часов
		FROM ПРЕДМЕТЫ
			order by ПРЕДМЕТЫ.Предмет

CREATE VIEW [ЛК_ЗАНЯТИЯ2]
WITH SCHEMABINDING
	AS SELECT ГРУППЫ.Номер_группы, COUNT(*)[количество_предметов]
		FROM dbo.ГРУППЫ JOIN dbo.ПРЕДМЕТЫ
			ON ГРУППЫ.Номер_группы = ПРЕДМЕТЫ.Номер_группы
			GROUP BY ГРУППЫ.Номер_группы;