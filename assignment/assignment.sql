/* Part 1:
 SECTION A: 
 Building the Nairobi Academy Database:
 */

create schema if not exists nairobi_academy;

set search_path = nairobi_academy;

-- Students table:

create table students(
student_id INT primary key,
first_name VARCHAR(50) not null,
last_name VARCHAR(50) not null,
gender VARCHAR(1),
date_of_birth DATE,
class VARCHAR(10),
city VARCHAR(50)
);

-- Subjects table:

create table subjects (
subject_id INT primary key,
subject_name VARCHAR(100) not null unique,
department VARCHAR(50),
teacher_name VARCHAR(100),
credits INT
);

-- Exam results table:

create table exam_results (
result_id INT primary key,
student_id INT not null,
subject_id INT not null,
marks INT not null,
exam_date DATE,
grade VARCHAR(2)
);


-- Addition of a phone number column:

alter table students
add column phone_number VARCHAR(20)
;

select * from students;


-- Renaming column 'credits'

alter table subjects 
rename credits to credit_hours;

select * from subjects;


-- Phone number column is no longer needed:

alter table students
drop column phone_number;

select * from students;



/* SECTION B: 
 Filling the Database:
 */

-- inserting 10 students into the students table:

insert into students (student_id, first_name, last_name, gender, date_of_birth, class, city)
values 
(1, 'Amina', 'Wanjiku', 'F', '2008-03-12', 'Form 3', 'Nairobi'),
(2, 'Brian', 'Ochieng', 'M', '2007-07-25', 'Form 4', 'Mombasa'),
(3, 'Cynthia', 'Mutua', 'F', '2008-11-05', 'Form 3', 'Kisumu'),
(4, 'David', 'Kamau', 'M', '2007-02-18', 'Form 4', 'Nairobi'),
(5, 'Esther', 'Akinyi', 'F', '2009-06-30', 'Form 2', 'Nakuru'),
(6, 'Felix', 'Otieno', 'M', '2009-09-14', 'Form 2', 'Eldoret'),
(7, 'Grace', 'Mwangi', 'F', '2008-01-22', 'Form 3', 'Nairobi'),
(8, 'Hassan', 'Abdi', 'M', '2007-04-09', 'Form 4', 'Mombasa'),
(9, 'Ivy', 'Chebet', 'F', '2009-12-01', 'Form 2', 'Nakuru'),
(10, 'James', 'Kariuki', 'M', '2008-08-17', 'Form 3', 'Nairobi');

select * from students;


-- inserting 10 subjects into the subjects table:

insert into subjects (subject_id, subject_name, department, teacher_name, credit_hours)
values
(1, 'Mathematics', 'Sciences', 'Mr. Njoroge', 4),
(2, 'English', 'Languages', 'Ms. Adhiambo', 3),
(3, 'Biology', 'Sciences', 'Ms. Otieno', 4),
(4, 'History', 'Humanities', 'Mr. Waweru', 3),
(5, 'Kiswahili', 'Languages', 'Ms. Nduta', 3),
(6, 'Physics', 'Sciences', 'Mr. Kamande', 4),
(7, 'Geography', 'Humanities', 'Ms. Chebet', 3),
(8, 'Chemistry', 'Sciences', 'Ms. Muthoni', 4),
(9, 'Computer Studies', 'Sciences', 'Mr. Oduya', 3),
(10, 'Business Studies', 'Humanities', 'Ms. Wangari', 3);

select * from subjects;


-- inserting 10 results into the exam results table:

insert into exam_results (result_id, student_id, subject_id, marks, exam_date, grade)
values
(1, 1, 1, 78, '2024-03-15', 'B'),
(2, 1, 2, 85, '2024-03-16', 'A'),
(3, 2, 1, 92, '2024-03-15', 'A'),
(4, 2, 3, 55, '2024-03-17', 'C'),
(5, 3, 2, 49, '2024-03-16', 'D'),
(6, 3, 4, 71, '2024-03-18', 'B'),
(7, 4, 1, 88, '2024-03-15', 'A'),
(8, 4, 6, 63, '2024-03-19', 'C'),
(9, 5, 5, 39, '2024-03-20', 'F'),
(10, 6, 9, 95, '2024-03-21', 'A');

select * from exam_results;


-- Esther Akinyi (student id = 5) has moved from Nakuru to Nairobi


update students 
set city = 'Nairobi'
where student_id = 5;

select * from students;


-- The marks for result_id 5 were entered incorrectly - the correct marks are 59, not 49

update exam_results 
set marks = 59
where result_id = 5;

select * from exam_results;


-- The exam result with result_id 9 has been cancelled by the school. 
delete from exam_results
where result_id = 9;



/* SECTION C: 
 Querrying the Date:
 */

-- All form 4 students 

select * 
from students
where class = 'Form 4';


-- All subjects in the Sciences department

select subject_name 
from subjects
where department = 'Sciences';


-- All female students 

select * 
from students
where gender = 'F';


-- All students who are in Form 3 AND from Nairobi

select * 
from students
where class = 'Form 3' and city = 'Nairobi';


-- All students who are in Form 2 OR Form 4

select * 
from students
where class = 'Form 2' or class = 'Form 4';



/* Part 2:
 SECTION A: 
 Range, Membership & Search Operators:
 */

-- Exam results where marks are between 50 and 80 (inclusive)

select *
from exam_results
where marks between 50 and 80;


-- Exams that took place between 15th March 2024 and 18th March 2024

select *
from exam_results
where exam_date between '2024-03-15' and '2024-03-18';


-- Students who live in Nairobi, Mombasa, or Kisumu

select * 
from students
where city in ('Nairobi','Mombasa','Kisumu');


-- Students who are NOT in Form 2 or Form 3 

select * 
from students
where class not in ('Form 2','Form 3');


-- Students whose first name starts with the letter 'A' or 'E' 

select * 
from students
where first_name like 'A%' or first_name like 'E%';


-- Subjects whose subject name contains the word 'Studies'

select * 
from subjects
where subject_name like '%Studies%';



-- SECTION B - COUNT

-- How many students are currently in Form 3? 

select count (*)
from students
where class = 'Form 3'

-- Four students are currently in form 3.


-- How many exam results have a mark of 70 or above? 

select count (*)
from exam_results
where marks >= 70;

-- 6 exam results are 70 and above.


-- Section C - Case When
-- Exam results labelling:

select *,
    case
        when marks >= 80 THEN 'Distinction'
        when marks >= 60 THEN 'Merit'
        when marks >= 40 THEN 'Pass'
        else 'Fail'
    end as performance
from exam_results;


-- Students labeling:

select first_name, last_name, class,
	case
		when class in ('Form 3', 'Form 4') then 'Senior'
		when class in ('Form 1', 'Form 2') then 'Junior'
	end as student_level
	from students; 
	


