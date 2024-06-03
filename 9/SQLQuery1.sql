CREATE VIEW [�������������]
	AS SELECT TEACHER.TEACHER, TEACHER.TEACHER_NAME, TEACHER.GENDER, TEACHER.PULPIT
		FROM TEACHER;

CREATE VIEW [����������_������]
	AS SELECT FACULTY.FACULTY, COUNT(*)[����������_������]
		FROM FACULTY JOIN PULPIT
			ON FACULTY.FACULTY = PULPIT.FACULTY
			GROUP BY FACULTY.FACULTY;

ALTER VIEW [���������](���, ���, ���������)
	AS SELECT AUDITORIUM.AUDITORIUM,AUDITORIUM.AUDITORIUM_TYPE, AUDITORIUM.AUDITORIUM_NAME
		FROM AUDITORIUM
			WHERE AUDITORIUM.AUDITORIUM_TYPE LIKE '��%' WITH CHECK OPTION
DROP VIEW [���������]; 
INSERT ��������� values('107-3','��-�', '107-3')
DELETE from ��������� where ��� like '236-1%'
UPDATE ��������� set ��� = '10000' where ��������� like '313-1%'


ALTER VIEW [����������]
	AS SELECT TOP 10 SUBJECT.SUBJECT, SUBJECT.SUBJECT_NAME, SUBJECT.PULPIT
		FROM SUBJECT
			order by SUBJECT.SUBJECT_NAME

CREATE VIEW [����������_������2]
WITH SCHEMABINDING
AS
SELECT FACULTY.FACULTY, COUNT(*)[����������_������]
FROM dbo.FACULTY
JOIN dbo.PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY
GROUP BY FACULTY.FACULTY;

use Glushko_MyBase
CREATE VIEW [�������������_���_��]
	AS SELECT *
		FROM ������������� a;

CREATE VIEW [��_�������]
	AS SELECT ������.�����_������, COUNT(*)[����������_���������]
		FROM ������ JOIN ��������
			ON ������.�����_������ = ��������.�����_������
			GROUP BY ������.�����_������;

ALTER VIEW [����������](���, ���, ����������_�����)
	AS SELECT ��������.�������,��������.���_�������, ��������.����������_�����
		FROM ��������
			WHERE ��������.���_������� LIKE '��%'
INSERT ���������� values('�����������','��', 128)
DELETE from ���������� where ��� like '�����������%'
UPDATE ���������� set ��� = '�������' where ��� like '�����������%'



CREATE VIEW [�����������]
	AS SELECT TOP 3 ��������.�������,��������.���_�������, ��������.����������_�����
		FROM ��������
			order by ��������.�������

CREATE VIEW [��_�������2]
WITH SCHEMABINDING
	AS SELECT ������.�����_������, COUNT(*)[����������_���������]
		FROM dbo.������ JOIN dbo.��������
			ON ������.�����_������ = ��������.�����_������
			GROUP BY ������.�����_������;