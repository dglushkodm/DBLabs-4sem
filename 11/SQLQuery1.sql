use UNIVER

declare @a char(20), @t char(300)='';
declare CURISIT cursor for
						select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT like 'ИСИТ%'
	open CURISIT;
	fetch CURISIT  into @a
	print 'дисциплины'
	while @@FETCH_STATUS =0
	begin 
	set @t = RTRIM(@a) + ', ' + @t
	fetch CURISIT into @a
	end
	print @t
	close CURISIT

DECLARE Tovary CURSOR LOCAL                            
	             for SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_CAPACITY from AUDITORIUM;
DECLARE @tv char(20), @cap real;      
	OPEN Tovary;	  
	fetch  Tovary into @tv, @cap; 	
      print '1. '+@tv+cast(@cap as varchar(6));   
      go
 DECLARE @tv char(20), @cap real;     	
	fetch  Tovary into @tv, @cap; 	
      print '2. '+@tv+cast(@cap as varchar(6));  
  go   

  DECLARE Tovary CURSOR GLOBAL                        
	             for SELECT AUDITORIUM.AUDITORIUM, AUDITORIUM.AUDITORIUM_CAPACITY from AUDITORIUM;
DECLARE @tv char(20), @cap real;      
	OPEN Tovary;	  
	fetch  Tovary into @tv, @cap; 	
      print '1. '+@tv+cast(@cap as varchar(6));   
      go
 DECLARE @tv char(20), @cap real;     	
	fetch  Tovary into @tv, @cap; 	
      print '2. '+@tv+cast(@cap as varchar(6));  
	  deallocate Tovary;
  go   


  DECLARE @tid char(10), @tnm char(40), @tgn char(1);  
	DECLARE Zakaz CURSOR LOCAL dynamic                            
		 for SELECT PROGRESS.SUBJECT, PROGRESS.NOTE, PROGRESS.IDSTUDENT 
		       FROM PROGRESS where PROGRESS.SUBJECT = 'КГ';				   
	open Zakaz;
	print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5)); 
    UPDATE PROGRESS set NOTE = 5 where IDSTUDENT = '1006';
	DELETE PROGRESS where IDSTUDENT = '1005';
	INSERT PROGRESS(SUBJECT, IDSTUDENT, NOTE, PDATE ) 
	                 values ('КГ', 1004,2, '2014-08-02'); 
	FETCH  Zakaz into @tid, @tnm, @tgn;     
	while @@fetch_status = 0                                    
      begin 
          print @tid + ' '+ @tnm + ' '+ @tgn;      
          fetch Zakaz into @tid, @tnm, @tgn; 
       end;          
   CLOSE  Zakaz;
   DELETE PROGRESS where NOTE= '2';



         DECLARE  @tc int, @rn char(50);  
         DECLARE Primer1 cursor local dynamic SCROLL                               
               for SELECT row_number() over (order by NOTE) N,
	                           NOTE FROM PROGRESS where SUBJECT = 'КГ' 
	OPEN Primer1;
	FETCH  first from  Primer1 into @tc, @rn;       
	print 'последняя строка          : ' +  cast(@tc as varchar(3))+ '. '+ rtrim(@rn);  
	FETCH  next from Primer1 into  @tc, @rn;                 
	print 'следующая строка          : ' + cast(@tc as varchar(3))+ '. '+ rtrim(@rn);   
	FETCH  absolute 3 from Primer1 into  @tc, @rn;                 
	print 'следующая строка          : ' + cast(@tc as varchar(3))+ '. '+ rtrim(@rn);   
	FETCH  relative 1 from Primer1 into  @tc, @rn;                 
	print 'следующая строка          : ' + cast(@tc as varchar(3))+ '. '+ rtrim(@rn);    
	FETCH  LAST from  Primer1 into @tc, @rn;       
	print 'последняя строка          : ' +  cast(@tc as varchar(3))+ '. '+ rtrim(@rn); 
	FETCH  prior from Primer1 into  @tc, @rn;                 
	print 'следующая строка          : ' + cast(@tc as varchar(3))+ '. '+ rtrim(@rn);  
      CLOSE Primer1;

declare @sub varchar(20), @id varchar(50), @note int;
declare Cursor1 cursor local dynamic 
  for select  STUDENT.NAME, PROGRESS.IDSTUDENT, PROGRESS.NOTE
  from PROGRESS
  join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
  where PROGRESS.NOTE<4 for update;

open Cursor1
fetch Cursor1 into @sub, @id, @note;
print @id + ' : ' + @sub + ' Оценка: '+ cast(@note as varchar(15));
delete PROGRESS where current of Cursor1
close Cursor1

declare @id1 int, @note1 int
declare Cursor2 cursor local dynamic
  for select PROGRESS.IDSTUDENT, PROGRESS.NOTE
  from PROGRESS
  where PROGRESS.IDSTUDENT = 1007 for update;

open  Cursor2
fetch Cursor2 into @id1, @note1;
print 'ID: '+cast(@id1 as varchar(15)) + ' оценка: ' + cast(@note1 as varchar(15));
update PROGRESS set NOTE = NOTE+2 where current of Cursor2;
close Cursor2
select * from PROGRESS

	select * from PROGRESS where SUBJECT = 'КГ' order by NOTE












use Glushko_MyBase

declare @a char(20), @t char(300)='';
declare CURLK cursor for
						select Предмет from ПРЕДМЕТЫ where Тип_занятия like 'лк%'
	open CURLK;
	fetch CURLK into @a
	print 'дисциплины'
	while @@FETCH_STATUS =0
	begin 
	set @t = RTRIM(@a) + ', ' + @t
	fetch CURLK into @a
	end
	print @t
	close CURLK

DECLARE Tovary CURSOR LOCAL                            
	             for SELECT Предмет, Номер_группы from ПРЕДМЕТЫ;
DECLARE @tv char(20), @cap real;      
	OPEN Tovary;	  
	fetch  Tovary into @tv, @cap; 	
      print '1. '+@tv+cast(@cap as varchar(6));   
      go
 DECLARE @tv char(20), @cap real;     	
	fetch  Tovary into @tv, @cap; 	
      print '2. '+@tv+cast(@cap as varchar(6));  
  go   


    DECLARE @tid char(40), @tnm char(40), @tgn char(1);  
	DECLARE Zakaz CURSOR LOCAL static                            
		 for select Предмет, Тип_занятия, Номер_группы from ПРЕДМЕТЫ where Тип_занятия like 'лк%'			   
	open Zakaz;
	print   'Количество строк : '+cast(@@CURSOR_ROWS as varchar(5)); 
    UPDATE ПРЕДМЕТЫ set Количество_часов = 32  where Оплата = 300.0;
	DELETE ПРЕДМЕТЫ where Оплата = 300.0;
	INSERT ПРЕДМЕТЫ(Предмет, Тип_занятия, Номер_группы) 
	                 values ('Тактика', 'лк', 4); 
	FETCH  Zakaz into @tid, @tnm, @tgn;     
	while @@fetch_status = 0                                    
      begin 
          print @tid + ' '+ @tnm + ' '+ @tgn;      
          fetch Zakaz into @tid, @tnm, @tgn; 
       end;          
   CLOSE  Zakaz;
   DELETE ПРЕДМЕТЫ where Предмет= 'Тактика';

     DECLARE  @tc int, @rn char(50);  
         DECLARE Primer1 cursor local dynamic SCROLL                               
               for SELECT row_number() over (order by Номер_группы) N,
	                           Номер_группы FROM ПРЕДМЕТЫ where Тип_занятия = 'лк' 
	OPEN Primer1;
	FETCH  first from  Primer1 into @tc, @rn;       
	print 'последняя строка          : ' +  cast(@tc as varchar(3))+ '. '+ rtrim(@rn);  
	FETCH  next from Primer1 into  @tc, @rn;                 
	print 'следующая строка          : ' + cast(@tc as varchar(3))+ '. '+ rtrim(@rn);   
	FETCH  absolute 3 from Primer1 into  @tc, @rn;                 
	print 'следующая строка          : ' + cast(@tc as varchar(3))+ '. '+ rtrim(@rn);   
	FETCH  relative 1 from Primer1 into  @tc, @rn;                 
	print 'следующая строка          : ' + cast(@tc as varchar(3))+ '. '+ rtrim(@rn);    
	FETCH  LAST from  Primer1 into @tc, @rn;       
	print 'последняя строка          : ' +  cast(@tc as varchar(3))+ '. '+ rtrim(@rn); 
	FETCH  prior from Primer1 into  @tc, @rn;                 
	print 'следующая строка          : ' + cast(@tc as varchar(3))+ '. '+ rtrim(@rn);  
      CLOSE Primer1;

	  	declare @tn char(20), @tc real, @tk int;
	declare Primer5 cursor local dynamic
		for select Предмет, Тип_занятия, Номер_группы from ПРЕДМЕТЫ for update
	open Primer5
	fetch Primer5 into @tn, @tc, @tk
	delete ПРЕДМЕТЫ where current of Primer5
	fetch Primer5 into @tn, @tc, @tk
	update ПРЕДМЕТЫ set Номер_группы = Номер_группы + 1 where current of Primer5
	close Primer5