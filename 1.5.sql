--1. Write a query which displays Staff Name, Department Code, Department Name, and
-- Salary for all staff who earns more than 20000
exec sp_tables
select * from Department_master
select * from staff_master

select s.staff_name, d.dept_name, d.dept_code,s.salary from staff_master s inner join department_master d on (s.dept_code=d.dept_code)
where s.salary> 20000;

--2. Write a query to display Staff Name, Department Code, and Department Name for all
--staff who do not work in Department code 10

select s.staff_name, d.dept_name, d.dept_code from staff_master s inner join department_master d on (s.dept_code=d.dept_code)
where s.dept_code <> 10;

-- 3. Print out a report like this
select * from dbo.book_transaction
select * from dbo.book_master
select ms.book_name, count(*) as NO_of_times_issued
from dbo.book_transaction tr inner join dbo.book_master ms on(tr.book_code=ms.book_code) 
group by ms.book_name

--4. List out number of students joined each department last year. The report should be displayed like this
select * from dbo.student_master
select * from dbo.department_master
select dm.dept_name, count(*)  from dbo.student_master sm inner join dbo.department_master dm on(sm.dept_code=dm.dept_code)
where sm.doj =datename(year,getdate()-1)
group by dm.dept_name


--5. List out a report like this
-- Staff Code Staff Name Manager Code Manager Name
select * from staff_master
select * from manager
select s.staff_code,s.staff_name,m.manager_code,m.manager_name from staff_master s inner join manager m on (s.mgr_code=m.manager_code) 

/*6. Display the Staff Name, Hire date and day of the week on which staff was hired.
Label the column as DAY. Order the result by the day of the week starting with
Monday.*/

select staff_name , hire_date, datename(dw,hire_date) as DAY from staff_master order by day desc

--7. Display Staff Code, Staff Name, and Department Name for those who have taken
--more than one book.
select * from staff
select * from department
select * from book_transaction
select * from book_master
select staff_code,staff_name,dm.dept_name from department_master dm inner join(select sm1.staff_code,sm1.staff_name,sm1.dept_name from department_master dm inner join(
select bt.book_code,bt.staff_code,count(*) as total from staff_master sm1 inner join book_transaction bt
on (sm1.staff_code=bt.staff_code)
group by bt.book_code,bt.staff_code having count(*)>1
)as new_table
on(new_table.staff_code=sm1.staff_code)) as result
on(result.dept_code=dm.dept_code);


--8. List out the names of all student code whose score in subject1 is equal to the highest score.
select * from student_marks
select * from student
select s.student_name from student s inner join
(
select student_code from  student_marks where (subject1>subject2 and subject1>subject3) 
) as result_table on (result_table.student_code=s.student_code)

--9 Modify the above query to display student names along with the codes.
select s.student_name from student s inner join
(
select student_code from  student_marks where (subject1>subject2 and subject1>subject3) 
) as result_table on (result_table.student_code=s.student_code)


--11. List out the code and names of all staff and students belonging to department 20.
select * from staff
select * from Student
select staff_name,staff_code from staff where dep=20
union 
select student_name,student_code from students where dep=20

--12.List out all the students who have not appeared for exams this year.
select * from student_master
select * from student_marks
select st.student_name from student_master st inner join student_marks stm on (st.student_code=stm.student_code) where student_year <> datename(year,getdate())

--13. List out all the student codes who have never taken books
select * from student_master
select * from book_transaction
select student_code from student_master where student_code not in (
select student_code
from
book_transaction
)

--14. Insert into Sutomer Table
select * from customer_164362
insert into customer_164362 (customerId,customerName,address1,address,phoneno,postalcode,customers_region,gendar) values

('ALFKI','AlfredsFutterkiste', 'Obere Strf.57','Berlin,Germany',030-0074321,12209, NULL,NULL) 

--15. Replace the contact number of Customer id ANATR to (604) 3332345.
update customer_164362 set phoneno='(604) 3332345' where Customerid='ANATR'

/*16. Update the Address and Region of Customer BOTTM to the following
19/2 12th Block, Spring Fields.
Ireland - UK
Region - EU*/
update customer_164362
set address1='19/2 12th Block, Spring Fields'
address='Ireland - UK'
region='EU'
where customerid='bottm'

