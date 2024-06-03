--1
use UNIVER
exec sp_helpindex 'AUDITORIUM'
exec sp_helpindex 'AUDITORIUM_TYPE'
exec sp_helpindex 'FACULTY'
exec sp_helpindex 'GROUPS'
exec sp_helpindex 'PROFESSION'
exec sp_helpindex 'PROGRESS'
exec sp_helpindex 'PULPIT'
exec sp_helpindex 'STUDENT'
exec sp_helpindex 'SUBJECT'
exec sp_helpindex 'TEACHER'

create table #testtable
(
	id int,
	smth varchar(100)
	);
SET nocount on;
declare @i int = 0;
while @i < 1000
	begin
INSERT #testtable(id, smth) VALUES(floor(10000*rand()), replicate('строка',1));
if(@i % 100 = 0)
print @i ;
SET @i = @i + 1;
end;
SELECT * FROM #testtable where id between 1500 and 2500 order by id 
checkpoint; 
DBCC DROPCLEANBUFFERS;  
CREATE clustered index #testtable_CL on #testtable(id asc)

drop table #testtable
--2
CREATE table #testtable2
(	  id int, 
      num int identity(1, 1),
      string varchar(100)
);
  set nocount on;           
  declare @i1 int = 0;
  while   @i1 < 20000      
  begin
       INSERT #testtable2(id, string) values(floor(30000*RAND()), replicate('строка ', 2));
        set @i1 = @i1 + 1; 
  end;
  SELECT count(*)[количество строк] from #testtable2;
  SELECT * from #testtable2
--drop table #testtable2
CREATE index #tt2_NONCLU on #testtable2(id, num)
drop index #tt2_NONCLU on #testtable2
    SELECT * from  #testtable2 where  id > 1500 and  num < 4500;  
    SELECT * from  #testtable2 order by  id, num
	SELECT * from  #testtable2 where  id = 557 and  num > 3
--3
CREATE  index #tt2_id_X on #testtable2(id) INCLUDE(num)
drop index #tt2_id_X on #testtable2
SELECT num from #testtable2 where id>15000 
--4
SELECT id from  #testtable2 where id between 5000 and 19999; 
SELECT id from  #testtable2 where id>15000 and  id < 20000  
SELECT id from  #testtable2 where id=17000
CREATE  index #tt2_WHERE on #testtable2(id) where (id>=15000 and id < 20000);  
drop index #tt2_WHERE on #testtable2
--5
CREATE index #tt2_id ON #testtable2(id); 
drop index #tt2_id ON #testtable2;
SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'tempdb'), 
OBJECT_ID(N'#testtable2'), NULL, NULL, NULL) ss  JOIN sys.indexes ii
on ss.object_id = ii.object_id and ss.index_id = ii.index_id  WHERE name is not null;

INSERT top(10000) #testtable2(id, string) select id, string from #testtable2;

ALTER index #tt2_id on #testtable2 reorganize;

ALTER index #tt2_id on #testtable2 rebuild with (online = off);

--6

DROP index #tt2_id on #testtable2;
CREATE index #tt2_id on #testtable2(id) with (fillfactor = 65);





