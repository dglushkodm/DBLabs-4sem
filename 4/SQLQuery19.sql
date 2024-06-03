use UNIVER
SELECT AUDITORIUM_TYPE.AUDITORIUM_TYPE,  
          max(AUDITORIUM_CAPACITY)  [������������ �����������],  
		  min(AUDITORIUM_CAPACITY)  [����������� �����������], 
		  avg(AUDITORIUM_CAPACITY)  [������� �����������],
		  sum(AUDITORIUM_CAPACITY)  [��������� �����������], 
          count(*)  [����������]
    From  AUDITORIUM  Inner Join  AUDITORIUM_TYPE
              On   AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
                Group by AUDITORIUM_TYPE.AUDITORIUM_TYPE

SELECT *
FROM (select Case
when NOTE between 1 and 4 then '����'
when NOTE between 5and 7 then '����'
when NOTE between 8and 10then '�������'
end [������� ���], COUNT (*) [����������]
FROM PROGRESS Group by Case
when NOTE between 1 and 4 then '����'
when NOTE between 5and 7 then '����'
when NOTE between 8and 10then '�������'
end) as T
ORDER BY Case [������� ���]
when '����' then 1
when '����' then 2
when '�������' then 3
else 0
end
 
 SELECT g.YEAR_FIRST,
g.PROFESSION,
f.FACULTY,
round(avg(cast(p.NOTE as float(4))),2)[������� ������]
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
GROUP BY g.YEAR_FIRST,
g.PROFESSION,
f.FACULTY


 SELECT g.YEAR_FIRST,
g.PROFESSION,
f.FACULTY,
round(avg(cast(p.NOTE as float(4))),2)[������� ������]
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
Where p.SUBJECT in ('��','����')
GROUP BY g.YEAR_FIRST,
g.PROFESSION,
f.FACULTY

 SELECT
g.PROFESSION,
p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[������� ������]
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
Where g.FACULTY in ('����')
GROUP BY g.PROFESSION,
p.SUBJECT



select PROGRESS.SUBJECT, count(*)[���-�� ���������] from PROGRESS
group by PROGRESS.SUBJECT, PROGRESS.NOTE
having PROGRESS.NOTE LIKE '8' or PROGRESS.NOTE LIKE '9'

use Glushko_MyBase
SELECT ��������.���_�������,  
          max(��������.������)  [������������ �����������],  
		  min(��������.������)  [����������� �����������], 
		  avg(��������.������)  [������� �����������],
		  sum(��������.������)  [��������� �����������], 
          count(*)  [����������]
    From  ��������
    Group by ��������.���_�������

SELECT *
FROM (select Case
when ����������_��������� between 1 and 10 then '����'
when ����������_��������� between 11and 50 then '������'
when ����������_��������� between 51and 100then '�����'
end [������� ���], COUNT (*) [����������]
FROM ������ Group by Case
when ����������_��������� between 1 and 10 then '����'
when ����������_��������� between 11and 50 then '������'
when ����������_��������� between 51and 100then '�����'
end) as T
ORDER BY Case [������� ���]
when '����' then 3
when '������' then 2
when '�����' then 1
else 0
end

 SELECT 
 f.�������������,f.���������,
round(avg(cast(������ as float(4))),2)[������� ������]
From ������ f inner join �������� g
on f.�����_������ = g.�����_������
where f.��������� in ('��')
GROUP BY  f.�������������, f.���������


select ������.�������������, count(*)[���-�� ����� � ��������� > 50] from ������
group by ������.����������_���������, ������.�������������
having ������.����������_��������� > 50