--ex.8
use UNIVER;
go
create trigger TR_TEACHER_INSTEAD_OF on TEACHER instead of delete
as raiserror('Удалять заборонено', 10, 1)
return;

go
set nocount on
delete from TEACHER where TEACHER = 'ГДД'
select * from TEACHER
select * from TR_AUDIT order by ID