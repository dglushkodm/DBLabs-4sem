DECLARE @char CHAR(10) = 'AMERICA YAAA'

DECLARE @varchar VARCHAR(20) = 'HALLLOOOO:3'
select @varchar as [rty]

DECLARE @datetime DATETIME
SET @datetime = GETDATE()

DECLARE @time TIME(0)
SET @time = GETDATE()

DECLARE @int INT
SET @int = 123

DECLARE @smallint SMALLINT
SET @smallint = 456

DECLARE @tinyint TINYINT
SET @tinyint = 7

DECLARE @numeric NUMERIC(12, 5)
SET @numeric = 123.45678

SELECT 'char' AS Name, @char AS Value
SELECT 'varchar' AS Name, @varchar AS Value
SELECT 'datetime' AS Name, @datetime AS Value
SELECT 'time' AS Name, @time AS Value
SELECT 'int' AS Name, @int AS Value
SELECT 'smallint' AS Name, @smallint AS Value
SELECT 'tinyint' AS Name, @tinyint AS Value
PRINT 'numeric = ' + CAST(@numeric AS VARCHAR(20))


DECLARE @TABLE TABLE(
				ID INT identity(1,1),
				CAPACITY INT);
INSERT INTO @TABLE (CAPACITY)
VALUES (50), (100), (150), (200), (250), (300)

DECLARE @TotalCapacity INT
DECLARE @TotalRooms INT
SELECT @TotalCapacity = SUM(CAPACITY) FROM @TABLE
SELECT @TotalRooms = COUNT(*) FROM @TABLE
IF @TotalCapacity > 200
BEGIN
    DECLARE @BelowAvg INT 
    DECLARE @AvgCapacity FLOAT
    DECLARE @Percent FLOAT

    SELECT @BelowAvg = COUNT(*) FROM @TABLE WHERE CAPACITY < (SELECT AVG(CAPACITY) FROM @TABLE)
    SELECT @AvgCapacity = AVG(CAPACITY) FROM @TABLE
    SELECT @Percent = (@BelowAvg * 100.0) / COUNT(*) FROM @TABLE
	DECLARE @TABLE2 TABLE(
				NAME VARCHAR(100),
				VALUE VARCHAR(20));
INSERT INTO @TABLE2 (NAME,VALUE)
VALUES ('���������� ���������', CAST(@TotalRooms AS VARCHAR(20))),
	   ('����� �����������',@TotalCapacity ),
	   ('������� �����������', @AvgCapacity),
	   ('��������� ������ ������� �����������', @BelowAvg),
	   ('������� ��������� ������� ������� �����������', @Percent);
SELECT * FROM @TABLE2
END
ELSE IF @TotalCapacity = 200
BEGIN
    PRINT '����� ����������� ����� 200'
END
ELSE
BEGIN
    PRINT '����� ����������� ������ 200'
END


PRINT '@@ROWCOUNT: ' + CAST(@@ROWCOUNT AS VARCHAR(10))
PRINT '@@VERSION: ' + @@VERSION
PRINT '@@SPID: ' + CAST(@@SPID AS VARCHAR(10))
PRINT '@@ERROR: ' + CAST(@@ERROR AS VARCHAR(10))
PRINT '@@SERVERNAME: ' + @@SERVERNAME
PRINT '@@TRANCOUNT: ' + CAST(@@TRANCOUNT AS VARCHAR(10))
PRINT '@@FETCH_STATUS: ' + CAST(@@FETCH_STATUS AS VARCHAR(10))
PRINT '@@NESTLEVEL: ' + CAST(@@NESTLEVEL AS VARCHAR(10))

DECLARE @t FLOAT
DECLARE @x FLOAT
DECLARE @z FLOAT

SET @t = 6
SET @x = 7
IF @t > @x
BEGIN
    SET @z = POWER(SIN(@t), 2)
END
ELSE IF @t < @x
BEGIN
    SET @z = 4 * (@t + @x)
END
ELSE
BEGIN
    SET @z = 1 - EXP(@x - 2)
END
PRINT '�������� ���������� z: ' + CAST(@z AS VARCHAR(10))

DECLARE @Full VARCHAR(100)
DECLARE @Short VARCHAR(100)

SET @Full = '�������� ������� ����������'

SET @Short = SUBSTRING(@Full, 1, CHARINDEX(' ', @Full)) +
             SUBSTRING(@Full, CHARINDEX(' ', @Full) + 1, 1) +'.' +
             SUBSTRING(@Full, CHARINDEX(' ', @Full, CHARINDEX(' ', @Full) + 1) + 1, 1) +'.'
PRINT '������ ���: ' + @Full
PRINT '����������� ���: ' + @Short

SELECT STUDENT.NAME, STUDENT.BDAY, DATEDIFF(YEAR, STUDENT.BDAY, GETDATE()) AS Age
FROM Student
WHERE MONTH(STUDENT.BDAY) = MONTH(DATEADD(MONTH, 1, GETDATE()))

DECLARE @GroupName VARCHAR(50)
SET @GroupName = '11'

SELECT DISTINCT DATEPART(WEEKDAY, PROGRESS.PDATE) AS ����_������
FROM PROGRESS join STUDENT
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
WHERE STUDENT.IDGROUP = @GroupName AND PROGRESS.SUBJECT LIKE '��%'

DECLARE @Count INT;
SELECT @Count = COUNT(*) FROM GROUPS;

IF @Count > 10
BEGIN
    PRINT '����� ������ 10';
END
ELSE
BEGIN
    PRINT '����� ������ 10';
END

SELECT *
FROM (select Case
when NOTE between 1 and 4 then '����'
when NOTE between 5and 7 then '����'
when NOTE between 8and 10then '�������'
end [������� ���], COUNT (*) [����������]
FROM PROGRESS join STUDENT
on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
join GROUPS
on STUDENT.IDGROUP = GROUPS.IDGROUP
where GROUPS.FACULTY like '����%'
Group by Case
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


DECLARE @i INT = 1
CREATE TABLE #TempTable (
    Col1 INT,
    Col2 INT,
    Col3 INT)
WHILE @i <= 10
BEGIN
    INSERT INTO #TempTable (Col1, Col2, Col3)
    VALUES (1+@i,2+@i,3+@i)
    SET @i = @i + 1
END
SELECT * FROM #TempTable


DECLARE @A INT = 4
DECLARE @B INT = 5
PRINT @A + @B
RETURN
PRINT @A+4

BEGIN TRY
    SELECT 1/0 AS �������;
END TRY
BEGIN CATCH
    PRINT '������ �����: ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
    PRINT '��������� �� ������: ' + ERROR_MESSAGE();
    PRINT '����� ������ � �������: ' + CAST(ERROR_LINE() AS VARCHAR(10));
    PRINT '��� ��������� ��� NULL: ' + ISNULL(ERROR_PROCEDURE(), 'NULL');
    PRINT '������� ����������� ������: ' + CAST(ERROR_SEVERITY() AS VARCHAR(10));
    PRINT '����� ������: ' + CAST(ERROR_STATE() AS VARCHAR(10));
END CATCH;