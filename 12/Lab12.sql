--1
use master;
set nocount on					
if exists (select * from  SYS.OBJECTS where OBJECT_ID = object_id (N'DBO.NewTable') )
begin
	drop table NewTable;
end;

declare @c int, @flag char = 'r';	
SET IMPLICIT_TRANSACTIONS  ON		
create table NewTable		
(
	i int identity(1,1),
	word varchar(50) not null
);
declare @tableName NVARCHAR(128)
set @tableName = 'NewTable'
insert newTable (word) values ('1'), ('2'), ('3'), ('4');
set @c = (select count(*) from NewTable);
print 'Количество строк в таблице NewTable: ' + cast( @c as varchar(4));
if @flag = 'c'
begin
	commit;							
end;
else
begin
rollback;					
end;
SET IMPLICIT_TRANSACTIONS  OFF		
if exists (select * from  SYS.OBJECTS where OBJECT_ID = object_id (N'DBO.NewTable') )
begin
	print 'Таблица с названием ' + @tableName + ' существует'
end;
else
begin
	print 'Таблица с названием ' + @tableName + ' не существует'
end;


use UNIVER;
begin try
	begin tran					
		--delete AUDITORIUM where AUDITORIUM_NAME = '301-1';
		insert into AUDITORIUM values('301-1','ЛБ-К', '1', '301-1');
		--update AUDITORIUM set AUDITORIUM_CAPACITY = '1000' where AUDITORIUM_NAME='301-1';
	commit tran;
end try
begin catch
	print 'Ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0 rollback tran;
end catch


declare @savepoint varchar(30);
begin try
	begin tran
		delete AUDITORIUM where AUDITORIUM_NAME = '301-1';									
		set @savepoint = 'save1'; save transaction @savepoint; -- КТ - 1
		insert into AUDITORIUM values('301-1','ЛБ-К', '10', '301-1');							
		set @savepoint = 'save2'; save transaction @savepoint; -- КТ - 2
		update AUDITORIUM set AUDITORIUM_CAPACITY = '15' where AUDITORIUM_NAME='301-1';		
		set @savepoint = 'save3'; save transaction @savepoint; -- КТ - 3
	commit tran;
end try

begin catch
	print 'Ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0
		begin
			print 'Контрольная точка: ' + @savepoint;
			rollback tran @savepoint;
			commit tran;
		end;
end catch;

insert into AUDITORIUM values('301-1','ЛБ-К', '15', '301-1');

--ex.4
use UNIVER;

-- Таблица A
	set transaction isolation level READ COMMITTED --допускает неподтвержденное, неповторяющееся и фантомное чтение
	begin transaction
	
	-------------------------- t1 ------------------
	select @@SPID 'SID', 'insert AUDITORIUM' 'результат', * from SUBJECT where SUBJECT = 'ДПИ';
																	             
	select @@SPID 'SID', 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM   where  AUDITORIUM_NAME='301-1';
	commit; 
	-------------------------- t2 -----------------

--- Таблица B	
	begin transaction 
	select @@SPID 'SID'; -- SPID - возвращает системный идентификатор процесса, назначенный сервером текущему подключению
	INSERT into SUBJECT values('ДПИ','Дизайн пользовательских интерфейсов','ИСиТ');   
	update AUDITORIUM set AUDITORIUM_CAPACITY = '20' where AUDITORIUM_NAME = '301-1';	
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;

	delete SUBJECT where SUBJECT = 'ДПИ';

--ex.5
use UNIVER;

-- Таблица A
    set transaction isolation level  READ COMMITTED	-- не допускает неподтвержденного чтения, 
													-- но при этом возможно неповторяющееся и фантом-ное чтение
	begin transaction 
	select count(*) from AUDITORIUM where AUDITORIUM_CAPACITY = '50';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select @@SPID 'SID', 'update AUDITORIUM'  'результат',  AUDITORIUM_NAME, 
                      AUDITORIUM_TYPE,AUDITORIUM_CAPACITY from AUDITORIUM   where  AUDITORIUM='324-1';
	commit; 

	--- Таблица B	
	begin transaction 	

	-------------------------- t1 --------------------
    select @@SPID 'SID'
	update AUDITORIUM set AUDITORIUM_CAPACITY = '40' where AUDITORIUM='324-1';	
	commit; 
     
	-------------------------- t2 --------------------	
	 
--ex.6
use UNIVER;
-- Таблица А
    set transaction isolation level  REPEATABLE READ	-- не допускает неподтвержденного чтения и неповторяющегося чтения, 
														-- но при этом возможно фантомное чтение
	begin transaction 
	select SUBJECT_NAME from SUBJECT where PULPIT = 'ИСиТ';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  case
          when SUBJECT = 'ДПИ' then 'insert  SUBJECT' 
		  else ' ' 
		  end 'результат', SUBJECT_NAME from SUBJECT  where PULPIT = 'ИСиТ';
	commit; 

	--- Таблица B	
	begin transaction 	  
	-------------------------- t1 --------------------
          	INSERT into SUBJECT values('ДПИ','Дизайн пользовательских интерфейсов','ИСиТ');   
          commit; 
	-------------------------- t2 --------------------

delete SUBJECT where SUBJECT = 'ДПИ';

--ex.7
-- Таблица A
set transaction isolation level SERIALIZABLE	-- отсутствие фантомного, неподтвержденного и неповторяющегося чтения
	begin transaction 
		delete SUBJECT where SUBJECT = 'ДПИ';
		INSERT into SUBJECT values('ДПИ', 'Дизайн пользовательских интерфейсов', 'ИСиТ');
        update SUBJECT set SUBJECT_NAME = 'Дизайн пользовательских interface' where  SUBJECT = 'ДПИ';
	    select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = 'ИСиТ';
	-------------------------- t1 -----------------
	 select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = 'ИСиТ';
	-------------------------- t2 ------------------ 
	commit; 	

--- Таблица B	
set transaction isolation level SERIALIZABLE	
	begin transaction 	  
		delete SUBJECT where SUBJECT = 'ДПИ';
		INSERT into SUBJECT values('ДПИ', 'Дизайн пользовательских интерфейсов','ИСиТ');
        update SUBJECT set SUBJECT_NAME = 'Дизайн пользовательских интерфейсовВ' where  SUBJECT = 'ДПИ';
	    select SUBJECT_NAME from SUBJECT where PULPIT = 'ИСиТ';
     -------------------------- t1 --------------------
     commit; 
     select SUBJECT_NAME,PULPIT from SUBJECT where PULPIT = 'ИСиТ';
     -------------------------- t2 --------------------
	 		
	delete SUBJECT where SUBJECT = 'ДПИ';

--ex.8
delete SUBJECT where SUBJECT = 'ДПИ';

select * from PULPIT

begin tran
update PULPIT set PULPIT_NAME = 'Лесных и технологии лесозаготовок' where PULPIT.FACULTY = 'ТТЛП'
	begin tran 
	update PULPIT set PULPIT_NAME = 'Лес' where PULPIT.FACULTY = 'ТТЛП'
	commit;
	select * from PULPIT

rollback
select * from PULPIT









use Glushko_MyBase;
begin try
	begin tran					
		delete ГРУППЫ where Номер_группы = '4';
		insert into ГРУППЫ values('4','ПОИТ', 'ИП', '12');
		update ГРУППЫ set Количество_студентов = '1000' where Специальность='ПОИТ';
	commit tran;
end try
begin catch
	print 'Ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0 rollback tran;
end catch


declare @savepoint varchar(30);
begin try
	begin tran
		delete ГРУППЫ where Номер_группы = '4';							
		set @savepoint = 'save1'; save transaction @savepoint; -- КТ - 1
		insert into ГРУППЫ values('4','ПОИТ', 'ИП', '12');					
		set @savepoint = 'save2'; save transaction @savepoint; -- КТ - 2
		update ГРУППЫ set Количество_студентов = '1000' where Специальность='ПОИТ';	
		set @savepoint = 'save3'; save transaction @savepoint; -- КТ - 3
	commit tran;
end try

begin catch
	print 'Ошибка: ' + cast(error_number() as varchar(5)) + ' ' + error_message()
	if @@TRANCOUNT > 0
		begin
			print 'Контрольная точка: ' + @savepoint;
			rollback tran @savepoint;
			commit tran;
		end;
end catch;

insert into ГРУППЫ values('4','ПОИТ', 'ИП', '12');	

--ex.4


-- Таблица A
	set transaction isolation level READ UNCOMMITTED --допускает неподтвержденное, неповторяющееся и фантомное чтение
	begin transaction
	
	-------------------------- t1 ------------------
	select @@SPID 'SID', 'insert AUDITORIUM' 'результат', * from ГРУППЫ where Номер_группы = '4';
																	             
	select @@SPID 'SID', 'update AUDITORIUM'  'результат',  Номер_группы, 
                      Специальность,Количество_студентов from ГРУППЫ  where  Номер_группы='4';
	commit; 
	-------------------------- t2 -----------------

--- Таблица B	
	begin transaction 
	select @@SPID 'SID'; -- SPID - возвращает системный идентификатор процесса, назначенный сервером текущему подключению
	insert into ГРУППЫ values('4','ПОИТ', 'ИП', '12');	
	update ГРУППЫ set Количество_студентов = '1000' where Специальность='ПОИТ';		
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;

	delete ГРУППЫ where Номер_группы = '4';

--ex.5


-- Таблица A
    set transaction isolation level  READ COMMITTED	-- не допускает неподтвержденного чтения, 
													-- но при этом возможно неповторяющееся и фантом-ное чтение
	begin transaction 
	select count(*) from ГРУППЫ where Номер_группы = '4';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select @@SPID 'SID', 'update AUDITORIUM'  'результат',  Номер_группы, 
                      Специальность,Количество_студентов from ГРУППЫ  where  Номер_группы='4';
	commit; 

	--- Таблица B	
	begin transaction 	

	-------------------------- t1 --------------------
    select @@SPID 'SID' update ГРУППЫ set Количество_студентов = '1000' where Специальность='ПОИТ';	

      commit; 
	-------------------------- t2 --------------------	

--ex.6

-- Таблица А
    set transaction isolation level  REPEATABLE READ	-- не допускает неподтвержденного чтения и неповторяющегося чтения, 
														-- но при этом возможно фантомное чтение
	begin transaction 
	select Специальность from ГРУППЫ where Номер_группы = '4';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  case
          when Номер_группы = '4' then 'insert  Group' 
		  else ' ' 
		  end 'результат', Специальность from ГРУППЫ where Номер_группы = '4';
	commit; 

	--- Таблица B	
	begin transaction 	  
	-------------------------- t1 --------------------
          	insert into ГРУППЫ values('4','ПОИТ', 'ИП', '12');	 
          commit; 
	-------------------------- t2 --------------------

delete ГРУППЫ where Номер_группы = '4';


-- Таблица A
set transaction isolation level SERIALIZABLE	-- отсутствие фантомного, неподтвержденного и неповторяющегося чтения
	begin transaction 
		delete ГРУППЫ where Номер_группы = '4';
		insert into ГРУППЫ values('4','ПОИТ', 'ИП', '12');	
        update ГРУППЫ set Количество_студентов = '1000' where Специальность='ПОИТ';	
	    select Специальность from ГРУППЫ where Номер_группы = '4';
	-------------------------- t1 -----------------
	 select Специальность from ГРУППЫ where Номер_группы = '4';
	-------------------------- t2 ------------------ 
	commit; 	

--- Таблица B	
	begin transaction 	  
		delete ГРУППЫ where Номер_группы = '4';
		insert into ГРУППЫ values('4','ПОИТ', 'ИП', '12');	
        update ГРУППЫ set Количество_студентов = '1000' where Специальность='ПОИТ';	
	    select Специальность from ГРУППЫ where Номер_группы = '4';
     -------------------------- t1 --------------------
     commit; 
     select Специальность from ГРУППЫ where Номер_группы = '4';
     -------------------------- t2 --------------------
	 		
	delete ГРУППЫ where Номер_группы = '4';


delete ГРУППЫ where Номер_группы = '4';

select * from ГРУППЫ

begin tran
update ГРУППЫ set Количество_студентов = '1000' where Специальность='ПОИТ';	
	begin tran 
	update ГРУППЫ set Количество_студентов = '4000' where Специальность='ПОИТ';	
	commit;
	select * from ГРУППЫ

rollback
select * from ГРУППЫ