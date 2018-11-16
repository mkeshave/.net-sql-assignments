6--1.4
--1
use training
select student_code, student_name, department_code from university.student

--2.for staff
select staff_code, staff_name, department_code from university.staff

--3. Retrieve the details (Name, Salary and dept code) of the employees who are working in department 20, 30 and 40.
select employee_name, salary, department_code from employees where department_code in(20,30,40)

/*4. Display Student_Code, Subjects and Total_Marks for every student. Total_Marks will
 calculate as Subject1 + Subject2 + Subject3 from Student_Marks. The records 
should be displayed in the descending order of Total Score */
 
select Student_Code, Subject1, subject2, subject3, Subject1+Subject2+Subject3 as Total_Marks 
from Student_Marks
order by Total_marks desc;

--5.List out all the books which starts with ‘An’, along with price
select book_name, bookprice from book_master where book_name like 'an%'

--6. List out all the department codes in which students have joined this year
select department_code from student where datename(yy,student_joining)=datename(yy,getdate())

/*7. Display name and date of birth of students where date of birth must be displayed in
the format similar to “January, 12 1981” for those who were born on Saturday or
Sunday.*/
select * from student
select student_name,datename(month,student_dob)+','+Format(student_dob,'dd yyyy') as Date_of_birth from student
where (datename(dw,student_dob)='saturday ' or datename(dw,student_dob)='sunday')

/*8. List out a report like this
StaffCode StaffName Dept Code Date of Joining No of years in the Company*/
select staff_name,department_code,dateofjoining, NoOfYearinCompany  from staff

--9. List out all staffs who have joined before Jan 2000
select * from staffs
select * from staffs where  datename(year,hire_date)<2018 

/*10. Write a query which will display Student_Name, Departmnet_Code and DOB of all
students who born between January 1, 1981 and March 31, 1983.*/

select student_name, department_code,student_dob from student where student_dob in ('January 1, 1981' , 'March 31, 1983')
select * from student

--11.List out all student codes who did not appear in the exam subject2
select student_code from student_marks where subject2 is null

