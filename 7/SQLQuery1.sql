use UNIVER
 SELECT
g.PROFESSION,
p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[средняя оценка]
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
Where g.FACULTY in ('ИДиП')
GROUP BY ROLLUP(g.PROFESSION,
p.SUBJECT)

 SELECT
g.PROFESSION,
p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[средняя оценка]
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
Where g.FACULTY in ('ИДиП')
GROUP BY CUBE(g.PROFESSION,
p.SUBJECT)

 SELECT
g.PROFESSION,
p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[средняя оценка]
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
Where g.FACULTY in ('ИДиП')
GROUP BY g.PROFESSION,
p.SUBJECT
UNION
 SELECT
g.PROFESSION,
p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[средняя оценка]
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
Where g.FACULTY in ('ХТиТ')
GROUP BY g.PROFESSION,
p.SUBJECT

 SELECT
g.PROFESSION,
p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[средняя оценка]
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
Where g.FACULTY in ('ИДиП')
GROUP BY g.PROFESSION,
p.SUBJECT
UNION ALL
 SELECT
g.PROFESSION,
p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[средняя оценка]
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
Where g.FACULTY in ('ХТиТ')
GROUP BY g.PROFESSION,
p.SUBJECT

 SELECT
g.PROFESSION,
p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[средняя оценка]
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
Where g.FACULTY in ('ИДиП')
GROUP BY g.PROFESSION,
p.SUBJECT
INTERSECT
 SELECT
g.PROFESSION,
p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[средняя оценка]
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
Where g.FACULTY in ('ХТиТ')
GROUP BY g.PROFESSION,
p.SUBJECT

 SELECT
g.PROFESSION,
p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[средняя оценка]
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
Where g.FACULTY in ('ИДиП')
GROUP BY g.PROFESSION,
p.SUBJECT
EXCEPT 
 SELECT
g.PROFESSION,
p.SUBJECT,
round(avg(cast(p.NOTE as float(4))),2)[средняя оценка]
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
Where g.FACULTY in ('ХТиТ')
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
Where g.FACULTY in ('ХТиТ')
GROUP BY 
p.SUBJECT,p.NOTE



use Glushko_MyBase
 SELECT 
 f.Специальность,f.Отделение,
round(avg(cast(Оплата as float(4))),2)[средняя оплата]
From ГРУППЫ f inner join ПРЕДМЕТЫ g
on f.Номер_группы = g.Номер_группы
where f.Отделение in ('ИП')
GROUP BY  ROLLUP(f.Специальность, f.Отделение)

 SELECT 
 f.Специальность,f.Отделение,
round(avg(cast(Оплата as float(4))),2)[средняя оплата]
From ГРУППЫ f inner join ПРЕДМЕТЫ g
on f.Номер_группы = g.Номер_группы
where f.Отделение in ('ИП')
GROUP BY  CUBE(f.Специальность, f.Отделение)


 SELECT 
 f.Специальность,f.Отделение,
round(avg(cast(Оплата as float(4))),2)[средняя оплата]
From ГРУППЫ f inner join ПРЕДМЕТЫ g
on f.Номер_группы = g.Номер_группы
where f.Отделение in ('ИП')
GROUP BY  CUBE(f.Специальность, f.Отделение)
UNION
 SELECT 
 f.Специальность,f.Отделение,
round(avg(cast(Оплата as float(4))),2)[средняя оплата]
From ГРУППЫ f inner join ПРЕДМЕТЫ g
on f.Номер_группы = g.Номер_группы
where f.Отделение in ('ИСИТ')
GROUP BY  CUBE(f.Специальность, f.Отделение)

 SELECT 
 f.Специальность,f.Отделение,
round(avg(cast(Оплата as float(4))),2)[средняя оплата]
From ГРУППЫ f inner join ПРЕДМЕТЫ g
on f.Номер_группы = g.Номер_группы
where f.Отделение in ('ИП')
GROUP BY  CUBE(f.Специальность, f.Отделение)
UNION ALL
 SELECT 
 f.Специальность,f.Отделение,
round(avg(cast(Оплата as float(4))),2)[средняя оплата]
From ГРУППЫ f inner join ПРЕДМЕТЫ g
on f.Номер_группы = g.Номер_группы
where f.Отделение in ('ИСИТ')
GROUP BY  CUBE(f.Специальность, f.Отделение)

 SELECT 
 f.Специальность,f.Отделение,
round(avg(cast(Оплата as float(4))),2)[средняя оплата]
From ГРУППЫ f inner join ПРЕДМЕТЫ g
on f.Номер_группы = g.Номер_группы
where f.Отделение in ('ИП')
GROUP BY  CUBE(f.Специальность, f.Отделение)
INTERSECT 
 SELECT 
 f.Специальность,f.Отделение,
round(avg(cast(Оплата as float(4))),2)[средняя оплата]
From ГРУППЫ f inner join ПРЕДМЕТЫ g
on f.Номер_группы = g.Номер_группы
where f.Отделение in ('ИСИТ')
GROUP BY  CUBE(f.Специальность, f.Отделение)

 SELECT 
 f.Специальность,f.Отделение,
round(avg(cast(Оплата as float(4))),2)[средняя оплата]
From ГРУППЫ f inner join ПРЕДМЕТЫ g
on f.Номер_группы = g.Номер_группы
where f.Отделение in ('ИП')
GROUP BY  CUBE(f.Специальность, f.Отделение)
EXCEPT 
 SELECT 
 f.Специальность,f.Отделение,
round(avg(cast(Оплата as float(4))),2)[средняя оплата]
From ГРУППЫ f inner join ПРЕДМЕТЫ g
on f.Номер_группы = g.Номер_группы
where f.Отделение in ('ИСИТ')
GROUP BY  CUBE(f.Специальность, f.Отделение)