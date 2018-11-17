--1.7.1
create procedure university.revis @staff_name varchar(20) as
 begin
    declare @experience int;
	set @experience=(select experience from university.staff_master where staff_name=@staff_name);
	if(@experience<2)
	begin
	update university.staff_master set staff_sal=(staff_sal*1) where staff_name=@staff_name;
	end
	else 
	begin
	if(@experience between 1 and 6)
	begin
	update university.staff_master set staff_sal=(staff_sal+staff_sal*0.2) 
	where staff_name=@staff_name;
	end
	else
	begin
	update university.staff_master set staff_sal=(staff_sal+staff_sal*0.25)
	where staff_name=@staff_name;
	end
	end
 end;


 select * from  university.staff_master;
 exec university.revi 'kirti';
 exec university.revi 'marcus';


 --1.7.2

 alter table university.book_transaction alter column book_issue_date date;
 alter table university.book_transaction alter column book_expected_return_date date;
 create procedure ins_booksr @book_code int, @student_code int as
 begin
	if exists(select book_code from university.book_transaction where book_code=@book_code)
	begin
	raiserror('Book is unavailable',12,1,@book_code);
	end
	else
	begin try
	begin
	insert into university.book_transaction(book_code,student_code,Book_issue_date,Book_expected_return_date)
	values (@book_code,@student_code,getdate(),dateadd(day,10,getdate()));
	end
	begin
	update university.book_transaction set book_expected_return_date=(dateadd(day,12,getdate()))
	where datename(dw,book_expected_return_date)='saturday';
	end
	begin
	update university.book_transaction set book_expected_return_date=(dateadd(day,11,getdate()))
	where datename(dw,book_expected_return_date)='sunday'
	end
	end try
	begin catch
	throw
	end catch
 end 

 exec ins_booksr 5,478;

 --1.7.3
  create procedure university.rev @staff_name varchar(20) as
 begin
    declare @experience int;
	set @experience=(select experience from university.staff_master where staff_name=@staff_name);
	if(@experience<2)
	begin
	update university.staff_master set staff_sal=(staff_sal*1) where staff_name=@staff_name;
	end
	else 
	begin
	if(@experience between 1 and 6)
	begin
	update university.staff_master set staff_sal=(staff_sal+staff_sal*0.2) 
	where staff_name=@staff_name;
	end
	else
	begin
	update university.staff_master set staff_sal=(staff_sal+staff_sal*0.25)
	where staff_name=@staff_name;
	end
	end
 end;

 exec university.rev 'kirti'
 with result sets
 (
 (staff_code int not null,
 staff_sal int not null)
 )


 --1.7.4
 create procedure book_detail @book_code int
 as
 begin
	select * from university.staff_master sm full join university.book_transaction bt
	on(sm.staff_code=bt.staff_code)
	where bt.book_code=@book_code;
end 

exec book_details 3;


--1.7.5
create procedure stud_s1 @student_code int, @subject1 int
as
declare @year int
begin
set @year=(select student_year from university.student_marks as sm 
		   where sm.student_code=@student_code);
if(@year!=2018)
	begin
		raiserror('invalid year',12,1,@year);
	end
else
	begin
		if(@student_code is null)
			begin
				raiserror('Student code can not be null',12,1);
			end
		else
			begin
				if(not exists(select * from university.student_master where student_code=@student_code))
					begin
						raiserror('Student does not exist in records',11,1);
					end
				else
					begin
						update university.student_marks set subject1=@subject1 where student_code=@student_code;
					end 
			end
	end
end;

exec stud_s1 438,79;
exec stud_s1 null,79;
exec stud_s1 103,89;
