--ex.1
use UNIVER
go
create procedure PSUBJECT1	
as
begin
	set nocount on;
	declare @count int = (select count(*) from SUBJECT)
	select s.SUBJECT Код, s.SUBJECT_NAME Дисциплина, s.PULPIT Кафедра from SUBJECT s order by Код
	return @count
end

go
declare @COUNT_OUTPUT int = 0
exec @COUNT_OUTPUT = PSUBJECT1
print 'Количество дисциплин: ' + cast(@COUNT_OUTPUT as varchar(10))

drop proc PSUBJECT1


ALTER procedure PSUBJECT1 @p varchar(20), @c int output	
as
begin
	set nocount on;
	select s.SUBJECT Код, s.SUBJECT_NAME Дисциплина, s.PULPIT Кафедра from SUBJECT s where s.PULPIT = @p
	set @c = (select count(*) from SUBJECT where SUBJECT.PULPIT = @p);

	print 'параметры: @p = ' + @p + ',@c = ' + cast(@c as varchar(3));
	declare @k int = (select count(*) from SUBJECT);
	return @k ;
end
declare @k int = 0, @r int = 0, @p varchar(20);
exec @k = PSUBJECT1 @p = 'ИСиТ', @c = @r output;
print 'Кол-во дисциплин всего: ' + cast(@k as varchar(3))
print 'Кол-во дисциплин на кафедре ' + cast(@p as varchar(3)) + ' = ' + cast(@r as varchar(3))


--3
alter proc PSUBJECT @PULPIT varchar(20)
as 
begin
	select * from SUBJECT where SUBJECT.PULPIT != @PULPIT
end

create table #SUBJECTS
(
	Код varchar(10) primary key,
	Дисциплина varchar(50) not null,
	Кафедра varchar(10) not null
);
insert #SUBJECTS exec PSUBJECT @PULPIT = 'ИСиТ'
select * from #SUBJECTS

drop table #SUBJECTS


go
create proc PAUDITORIUM_INSERT @AUD char(20), @NAME varchar(50), @CAPACITY int = 0, @TYPE char(10)
as
begin
	begin try
		insert into AUDITORIUM (AUDITORIUM, AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE)
		values (@AUD, @NAME, @CAPACITY, @TYPE)
		return 1
	end try
	begin catch
		print 'Номер ошибки:  ' + cast(ERROR_NUMBER() as varchar(6))
		print 'Уровень ошибки: ' + cast(ERROR_SEVERITY() as varchar(6))
		print 'Сообщение ошибки:   ' + ERROR_MESSAGE()
		return -1
	end catch
end

go
declare @RETURN int
delete AUDITORIUM where AUDITORIUM = '100-3'
exec @RETURN = PAUDITORIUM_INSERT @AUD = '100-3', @NAME = '100-3', @CAPACITY = 1, @TYPE = 'ЛК'
print 'Процедура завершилась. Код: ' + cast(@RETURN as varchar)
select * from AUDITORIUM
--select * from AUDITORIUM_TYPE


go
create proc SUBJECT_REPORT @PULPIT varchar(20)
as
begin try
	declare @SUBJ_OUT varchar(200) = ''
	declare @SUBJ_ONE varchar(20) = ''
	declare @ROWCOUNT int = 0
	declare cur cursor local static
	for (select SUBJECT from SUBJECT where SUBJECT.PULPIT = @PULPIT)
	if not exists (select SUBJECT from SUBJECT where SUBJECT.PULPIT = @PULPIT)
		raiserror('Ошибка! ', 11, 1)
	else
	open cur
		fetch cur into @SUBJ_ONE
		while @@FETCH_STATUS = 0
		begin
			set @SUBJ_OUT += rtrim(@SUBJ_ONE) + ', '
			set @ROWCOUNT = @ROWCOUNT + 1
			fetch cur into @SUBJ_ONE
		end
	print @SUBJ_OUT
	close cur
	return @ROWCOUNT
end try
begin catch
	print 'Ошибка в параметрах!'
	print 'Сообщение: ' + cast(ERROR_MESSAGE() as varchar(max))
	print 'Номер строки: ' + cast(@ROWCOUNT as varchar) 
end catch
go

declare @COUNT int = 0
exec @COUNT = SUBJECT_REPORT @PULPIT = 'ИиТ'
print 'Количество дисциплин: ' + cast(@COUNT as varchar)

drop proc SUBJECT_REPORT


use UNIVER
go
create proc PAUDITORIUM_INSERTX 
@AUD char(20), @NAME varchar(50), @CAPACITY int = 0, @AUD_TYPE char(10), @AUD_TYPENAME varchar(70)
as 
begin try
	set transaction isolation level SERIALIZABLE
	begin tran
		insert into AUDITORIUM_TYPE (AUDITORIUM_TYPE, AUDITORIUM_TYPENAME)
		values (@AUD_TYPE, @AUD_TYPENAME)
		exec PAUDITORIUM_INSERT @AUD, @NAME, @CAPACITY, @AUD_TYPE
	commit tran
end try
begin catch
	print 'Код ошибки:  ' + cast(ERROR_NUMBER() as varchar)
	print 'Серьёзность: ' + cast(ERROR_SEVERITY() as varchar)
	print 'Сообщение:   ' + cast(ERROR_MESSAGE() as varchar)
	if @@TRANCOUNT > 0 
		rollback tran
	return -1
end catch

go
exec PAUDITORIUM_INSERTX @AUD = '325-1', @NAME = '325-1', @CAPACITY = 50, @AUD_TYPE = 'ЛР-К', @AUD_TYPENAME = 'Лабораторный кабинет'

select * from AUDITORIUM
select * from AUDITORIUM_TYPE

delete AUDITORIUM where AUDITORIUM = '325-1'
delete AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ЛР-К'

drop proc PAUDITORIUM_INSERTX 