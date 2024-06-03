use UNIVER
SELECT AUDITORIUM_TYPE.AUDITORIUM_TYPE,  
          max(AUDITORIUM_CAPACITY)  [Максимальная вместимость],  
		  min(AUDITORIUM_CAPACITY)  [Минимальная вместимость], 
		  avg(AUDITORIUM_CAPACITY)  [Средняя вместимость],
		  sum(AUDITORIUM_CAPACITY)  [Суммарная вместимость], 
          count(*)  [Количество]
    From  AUDITORIUM  Inner Join  AUDITORIUM_TYPE
              On   AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
                Group by AUDITORIUM_TYPE.AUDITORIUM_TYPE

SELECT *
FROM (select Case
when NOTE between 1 and 4 then 'неуд'
when NOTE between 5and 7 then 'удов'
when NOTE between 8and 10then 'отлично'
end [Пределы цен], COUNT (*) [Количество]
FROM PROGRESS Group by Case
when NOTE between 1 and 4 then 'неуд'
when NOTE between 5and 7 then 'удов'
when NOTE between 8and 10then 'отлично'
end) as T
ORDER BY Case [Пределы цен]
when 'неуд' then 1
when 'удов' then 2
when 'отлично' then 3
else 0
end
 
 SELECT g.YEAR_FIRST,
g.PROFESSION,
f.FACULTY,
round(avg(cast(p.NOTE as float(4))),2)[средняя оценка]
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
round(avg(cast(p.NOTE as float(4))),2)[средняя оценка]
From FACULTY f inner join GROUPS g
on f.FACULTY = g.FACULTY
inner join STUDENT s
on g.IDGROUP = s.IDGROUP
inner join PROGRESS p
on s.IDSTUDENT = p.IDSTUDENT
Where p.SUBJECT in ('КГ','ОАиП')
GROUP BY g.YEAR_FIRST,
g.PROFESSION,
f.FACULTY

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



select PROGRESS.SUBJECT, count(*)[кол-во студентов] from PROGRESS
group by PROGRESS.SUBJECT, PROGRESS.NOTE
having PROGRESS.NOTE LIKE '8' or PROGRESS.NOTE LIKE '9'

use Glushko_MyBase
SELECT ПРЕДМЕТЫ.Тип_занятия,  
          max(ПРЕДМЕТЫ.Оплата)  [Максимальная вместимость],  
		  min(ПРЕДМЕТЫ.Оплата)  [Минимальная вместимость], 
		  avg(ПРЕДМЕТЫ.Оплата)  [Средняя вместимость],
		  sum(ПРЕДМЕТЫ.Оплата)  [Суммарная вместимость], 
          count(*)  [Количество]
    From  ПРЕДМЕТЫ
    Group by ПРЕДМЕТЫ.Тип_занятия

SELECT *
FROM (select Case
when Количество_студентов between 1 and 10 then 'мало'
when Количество_студентов between 11and 50 then 'средне'
when Количество_студентов between 51and 100then 'много'
end [Пределы цен], COUNT (*) [Количество]
FROM ГРУППЫ Group by Case
when Количество_студентов between 1 and 10 then 'мало'
when Количество_студентов between 11and 50 then 'средне'
when Количество_студентов between 51and 100then 'много'
end) as T
ORDER BY Case [Пределы цен]
when 'мало' then 3
when 'средне' then 2
when 'много' then 1
else 0
end

 SELECT 
 f.Специальность,f.Отделение,
round(avg(cast(Оплата as float(4))),2)[средняя оплата]
From ГРУППЫ f inner join ПРЕДМЕТЫ g
on f.Номер_группы = g.Номер_группы
where f.Отделение in ('ИП')
GROUP BY  f.Специальность, f.Отделение


select ГРУППЫ.Специальность, count(*)[кол-во групп с студентов > 50] from ГРУППЫ
group by ГРУППЫ.Количество_студентов, ГРУППЫ.Специальность
having ГРУППЫ.Количество_студентов > 50