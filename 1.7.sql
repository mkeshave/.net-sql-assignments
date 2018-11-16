/* 1. Write a procedure that accept Staff_Code and updates the salary and store the old
salary details in Staff_Master_Back (Staff_Master_Back has the same structure
without any constraint) table. The procedure should return the updated salary as the
return value
Exp< 2 then no Update
Exp>= 2 and <= 5 then 20% of salary
Exp> 5 then 25% of salary */

 
create procedure updateSalarynew @staff_c integer 
as
Declare @updatedSalary integer, @oldSalary integer,@exp integer
Begin
	select @Exp = (2018 - datename(year,Hiredate)) from staff_master where staff_code = @staff_c
	select @oldSalary = salary from staff_master where staff_code = @staff_c
	
	If @Exp<2
	Begin
		SET @updatedSalary = @oldSalary;
	End
	Else if @Exp between 1 and 6 
	Begin	
		SET @updatedSalary = @oldSalary +( @oldSalary *20)/100;
		Update Staff_Master set Salary = @updatedSalary where staff_code = @staff_c ;
		Update Staff_Master_Back set Salary = @oldSalary where staff_code = @staff_c ;
	End
	Else if @Exp > 5
	Begin
		SET @updatedSalary = @oldSalary + (@oldSalary*25)/100;
		Update Staff_Master set Salary = @updatedSalary where staff_code = @staff_c;
		Update Staff_Master_Back set Salary = @oldSalary where staff_code = @staff_c ;
	End
	return @updatedSalary
End  
DECLARE @result int;  
EXECUTE @result = updateSalarynewupdateSalarynew100001; 
print @result
		  
/*2. Write a procedure to insert details into Book_Transaction table. Procedure should
accept the book code and staff/student code. Date of issue is current date and the
expected return date should be 10 days from the current date. If the expected return
date falls on Saturday or Sunday, then it should be the next working day. Suitable
exceptions should be handled.*/

CREATE PROCEDURE updateDetailsss @b_code integer , @st_code integer 
AS 
BEGIN
	BEGIN TRY
		IF ((datename(day,(getdate()+10))) ='Saturday')
		BEGIN
			insert into Book_Transaction (Book_code,Stud_code,Issue_date,Exp_Return_date) values(@b_code,@st_code,getdate(),getdate()+12)
		END
		ELSE IF ((datename(day,getdate()+10)) ='Sunday')
		BEGIN
			insert into Book_Transaction (Book_code,Stud_code,Issue_date,Exp_Return_date) values(@b_code,@st_code,getdate(),getdate()+11)
		END
		ELSE
		BEGIN
			insert into Book_Transaction (Book_code,Stud_code,Issue_date,Exp_Return_date) values(@b_code,@st_code,getdate(),getdate()+10)
		END
	END TRY
	BEGIN CATCH
		PRINT 'Exception occured : MESSAGE FROM SYSTEM :  ' ;
		THROW	;
	END CATCH
END

exec updateDetailsss 5555 , 45545

select * from  Book_transaction


select * from  Book_Master
select * from staff_master
select * from student_marks
select * from student_master
select * from Desig_master

--3. Modify question 1 and display the results by specifying With result sets
create procedure updateSalary0111 @staff_c integer 
as
Declare @updatedSalary integer, @oldSalary integer,@exp integer
Begin
	select @Exp = (2018 - datename(year,Hiredate)) from staff_master where staff_code = @staff_c
	select @oldSalary = salary from staff_master where staff_code = @staff_c
	
	If @Exp<2
	Begin
		SET @updatedSalary = @oldSalary;
	End
	Else if @Exp between 1 and 6 
	Begin	
		SET @updatedSalary = @oldSalary +( @oldSalary *20)/100;
		Update Staff_Master set Salary = @updatedSalary where staff_code = @staff_c ;
		Update Staff_Master_Back set Salary = @oldSalary where staff_code = @staff_c ;
	End
	Else if @Exp > 5
	Begin
		SET @updatedSalary = @oldSalary + (@oldSalary*25)/100;
		Update Staff_Master set Salary = @updatedSalary where staff_code = @staff_c;
		Update Staff_Master_Back set Salary = @oldSalary where staff_code = @staff_c ;
	End
	select a.staff_code, a.Salary , b.salary  from Staff_master a inner join Staff_master_back b on (a.staff_code = b.staff_code )
	return @updatedSalary
End  

execute updateSalary0111 100006
with result sets
 (
	(
		[Staff Code] INT,
		[New Salary] INT,
		[Old Salary] INT
	)
 )



select * from staff_master




/*4. Create a procedure that accepts the book code as parameter from the user. Display
the details of the students/staff that have borrowed that book and has not returned
the same. The following details should be displayed
Student/StaffCode Student/StaffName IssueDate Designation ExpectedRet_Date*/
select * from book_transaction
select * from staff_master
create proc usp_book_detailss (
@bukcdee int
) 
as begin
select * from staff_master sm full join book_transaction bt on(sm.staff_code=bt.staff_code)
where bt.book_actual_return_date is null and bt.book_code=@bukcdee;
end
exec usp_book_detailss 101


/*5. Write a procedure to update the marks details in the Student_marks table. The
following is the logic.
• The procedure should accept student code , and marks as input parameter
• Year should be the current year.
• Student code cannot be null, but marks can be null.
• Student code should exist in the student master.
• The entering record should be unique ,i.e. no previous record should exist
• Suitable exceptions should be raised and procedure should return -1.
• IF the data is correct, it should be added in the Student marks table and a
success value of 0 should be returned.*/
CREATE PROCEDURE updateStudDetailsssss @stud_code integer , @subject1 integer = NULL ,@subject2 integer = NULL, @subject3 integer = NULL
AS 
BEGIN
		BEGIN TRY
			IF ((select Stud_Code from Student_master where stud_code = @stud_code) is not null )
				and ( (select Stud_Code from Student_marks where stud_code = @stud_code) is null)
				BEGIN
					update Student_marks set subject1 = @subject1 ,subject2 = @subject2 , subject3 = @subject3 where stud_code = @stud_code
						return 0;
					print 'Update Successful'
				END
				print 'Details not updated'
				return -1;
		END TRY

		BEGIN CATCH
			THROW;
			return -1;
		END CATCH
END

exec updateStudDetailsssss 1025 , 55 ,22 , 66

	   		