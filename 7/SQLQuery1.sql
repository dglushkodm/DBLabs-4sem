use UNIVER
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
GROUP BY ROLLUP(g.PROFESSION,
p.SUBJECT)

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
GROUP BY CUBE(g.PROFESSION,
p.SUBJECT)

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
UNION
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
UNION ALL
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
INTERSECT
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
EXCEPT 
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

 SELECT
p.SUBJECT,
p.NOTE
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
Where g.FACULTY in ('����')
GROUP BY 
p.SUBJECT,p.NOTE



use Glushko_MyBase
 SELECT 
 f.�������������,f.���������,
round(avg(cast(������ as float(4))),2)[������� ������]
From ������ f inner join �������� g
on f.�����_������ = g.�����_������
where f.��������� in ('��')
GROUP BY  ROLLUP(f.�������������, f.���������)

 SELECT 
 f.�������������,f.���������,
round(avg(cast(������ as float(4))),2)[������� ������]
From ������ f inner join �������� g
on f.�����_������ = g.�����_������
where f.��������� in ('��')
GROUP BY  CUBE(f.�������������, f.���������)


 SELECT 
 f.�������������,f.���������,
round(avg(cast(������ as float(4))),2)[������� ������]
From ������ f inner join �������� g
on f.�����_������ = g.�����_������
where f.��������� in ('��')
GROUP BY  CUBE(f.�������������, f.���������)
UNION
 SELECT 
 f.�������������,f.���������,
round(avg(cast(������ as float(4))),2)[������� ������]
From ������ f inner join �������� g
on f.�����_������ = g.�����_������
where f.��������� in ('����')
GROUP BY  CUBE(f.�������������, f.���������)

 SELECT 
 f.�������������,f.���������,
round(avg(cast(������ as float(4))),2)[������� ������]
From ������ f inner join �������� g
on f.�����_������ = g.�����_������
where f.��������� in ('��')
GROUP BY  CUBE(f.�������������, f.���������)
UNION ALL
 SELECT 
 f.�������������,f.���������,
round(avg(cast(������ as float(4))),2)[������� ������]
From ������ f inner join �������� g
on f.�����_������ = g.�����_������
where f.��������� in ('����')
GROUP BY  CUBE(f.�������������, f.���������)

 SELECT 
 f.�������������,f.���������,
round(avg(cast(������ as float(4))),2)[������� ������]
From ������ f inner join �������� g
on f.�����_������ = g.�����_������
where f.��������� in ('��')
GROUP BY  CUBE(f.�������������, f.���������)
INTERSECT 
 SELECT 
 f.�������������,f.���������,
round(avg(cast(������ as float(4))),2)[������� ������]
From ������ f inner join �������� g
on f.�����_������ = g.�����_������
where f.��������� in ('����')
GROUP BY  CUBE(f.�������������, f.���������)

 SELECT 
 f.�������������,f.���������,
round(avg(cast(������ as float(4))),2)[������� ������]
From ������ f inner join �������� g
on f.�����_������ = g.�����_������
where f.��������� in ('��')
GROUP BY  CUBE(f.�������������, f.���������)
EXCEPT 
 SELECT 
 f.�������������,f.���������,
round(avg(cast(������ as float(4))),2)[������� ������]
From ������ f inner join �������� g
on f.�����_������ = g.�����_������
where f.��������� in ('����')
GROUP BY  CUBE(f.�������������, f.���������)