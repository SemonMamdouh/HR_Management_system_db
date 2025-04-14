
Create database HR_Management

use HR_Management

create table Employee (
    ID int primary key,
    Birth_Date date,
    First_name varchar(50),
    Last_name varchar(50),
    Address varchar(255),
    Gender varchar(10) check (Gender in ('Male' , 'Female')),
    Job_title varchar(100),
    Hire_date date,
    Super_id int )

create table Employee_Email (
    Emp_id int,
    Emp_email varchar(100) unique,
    primary key (Emp_id, Emp_email) )

create table Employee_Phone (
    Emp_id int,
    Emp_phone char(11) unique,
    primary key (Emp_id, Emp_phone) )

create table Department (
    Dep_id int primary key,
    Dep_name varchar(100) unique,
    Mng_id int )

create table Project (
    Project_id int primary key,
    Project_name varchar(100),
    Start_date date,
    End_date date,
    Dep_id int )


create table emp_work_on_dept(
emp_id int  foreign key references Employee(ID) ,

dept_id int  foreign key references Department(Dep_id)

)


create table project_assign_to_emp(
emp_id int  foreign key references Employee(ID) ,

proj_id int  foreign key references Project(Project_id)

)



create table Attendance (
    Attendance_id int primary key,
    Emp_id int,
    status varchar(20),
    Overtime_hours int,
    Check_in_time time,
    Check_out_time time,
    Date date default getdate())

create table Payroll (
    Payroll_id int primary key,
    Emp_id int,
    Deduction decimal(10,2),
    Payroll_date date,
    Bonus decimal(10,2),
    Basic_salary decimal(10,2) )

create table Training (
    Id int primary key,
    Date date,
    Duration int,
    Training_Name varchar(100),
    Trainer_Name varchar(100) )

create table Employee_Training (
    Training_id int,
    Emp_id int,
    primary key (Training_id, Emp_id) )

create table Performance (
    Evaluation_id int primary key,
    Emp_id int,
    Super_id int,
    Evaluation_date date,
    Collaboration_score int ,
    Productivity_grade int )

create table Requests (
    Request_id int primary key,
    Emp_id int,
    Request_status varchar(50),
    Request_type varchar(100),
    Request_date date default getdate())

create table Account (
    Account_id int primary key,
    Emp_id int,
    Username varchar(50) unique,
    Password varchar(255) unique not null,
    Role varchar(50) not null check(Role in ('manager' ,'employee' ,'admin')) )

create table Candidate (
    Candidate_id int primary key,
    Full_name varchar(100),
    Phone char(11) unique,
    Email varchar(100) unique,
    Job_applied_for varchar(100) )

create table Recruitment_process (
    Recruitment_id int primary key,
    Candidate_id int,
    Interview_date date,
    Interview_score int,
    Hiring_status varchar(50),
    Job_title varchar(100),
    Interviewer_id int )


alter table employee
    add foreign key (super_id) references employee(ID)

alter table employee_email
    add foreign key (emp_id) references employee(ID)

alter table employee_phone
    add foreign key (emp_id) references employee(ID)

alter table department
    add foreign key (mng_id) references employee(ID) 

alter table project
    add foreign key (dep_id) references department(dep_id)

alter table attendance
    add foreign key (emp_id) references employee(ID)

alter table payroll
    add foreign key (emp_id) references employee(ID)

alter table employee_training
    add foreign key (training_id) references training(id)

alter table employee_training
    add foreign key (emp_id) references employee(ID)

alter table performance
    add foreign key (emp_id) references employee(ID)

alter table performance
    add foreign key (super_id) references employee(ID)

alter table requests
    add foreign key (Emp_id) references employee(ID)

alter table account
    add foreign key (emp_id) references employee(ID)

alter table recruitment_process
    add foreign key (candidate_id) references candidate(candidate_id)

alter table recruitment_process
    add foreign key (interviewer_id) references employee(ID)


insert into Employee (ID, Birth_Date, First_name, Last_name, Address, Gender, Job_title, Hire_date, Super_id)
values
(1, '1985-05-20', 'John', 'Doe', '123 Main St, Cairo', 'Male', 'Software Engineer', '2022-01-01',3),
(2, '1990-08-15', 'Jane', 'Smith', '456 Elm St, Cairo', 'Female', 'HR Manager', '2021-03-10', 1),
(3, '1987-07-25', 'Michael', 'Brown', '789 Oak St, Cairo', 'Male', 'Project Manager', '2020-06-01', 1),
(4, '1992-12-10', 'Emily', 'White', '101 Pine St, Cairo', 'Female', 'Software Engineer', '2022-02-15', 1),
(5, '1980-03-30', 'David', 'Green', '202 Maple St, Cairo', 'Male', 'Senior Developer', '2019-09-25', 3),
(6, '1988-05-14', 'Laura', 'Black', '303 Birch St, Cairo', 'Female', 'HR Assistant', '2021-12-10', 2),
(7, '1995-04-05', 'Chris', 'Johnson', '404 Cedar St, Cairo', 'Male', 'Intern', '2023-01-01', 3),
(8, '1991-11-30', 'Sarah', 'Martinez', '505 Walnut St, Cairo', 'Female', 'Marketing Specialist', '2022-04-05', 1),
(9, '1984-06-22', 'James', 'Davis', '606 Chestnut St, Cairo', 'Male', 'Software Engineer', '2018-11-10', 2),
(10, '1989-10-17', 'Patricia', 'Miller', '707 Ash St, Cairo', 'Female', 'QA Engineer', '2022-01-20', 3),
(11, '1993-09-12', 'Paul', 'Wilson', '808 Fir St, Cairo', 'Male', 'DevOps Engineer', '2021-04-07', 1),
(12, '1990-02-25', 'Linda', 'Taylor', '909 Elm St, Cairo', 'Female', 'Business Analyst', '2019-07-15', 4),
(13, '1985-08-01', 'Steven', 'Anderson', '1011 Oak St, Cairo', 'Male', 'IT Support', '2020-11-20', 4),
(14, '1994-03-11', 'Angela', 'Thomas', '1112 Pine St, Cairo', 'Female', 'Software Developer', '2021-02-10', 3),
(15, '1992-05-17', 'Mark', 'Jackson', '1213 Cedar St, Cairo', 'Male', 'Web Developer', '2021-09-13', 2);



insert into Employee_Email (Emp_id, Emp_email)values
(1, 'john.doe@example.com'),
(2, 'jane.smith@example.com'),
(3, 'michael.brown@example.com'),
(4, 'emily.white@example.com'),
(5, 'david.green@example.com'),
(6, 'laura.black@example.com'),
(7, 'chris.johnson@example.com'),
(8, 'sarah.martinez@example.com'),
(9, 'james.davis@example.com'),
(10, 'patricia.miller@example.com'),
(11, 'paul.wilson@example.com'),
(12, 'linda.taylor@example.com'),
(13, 'steven.anderson@example.com'),
(14, 'angela.thomas@example.com'),
(15, 'mark.jackson@example.com');


insert into Employee_Phone (Emp_id, Emp_phone) values
(1, '01012345678'),
(2, '01123456789'),
(3, '01234567890'),
(4, '01098765432'),
(5, '01187654321'),
(6, '01276543210'),
(7, '01013579246'),
(8, '01124681357'),
(9, '01235792468'),
(10, '01086420975'),
(11, '01197563482'),
(12, '01268245791'),
(13, '01045798213'),
(14, '01138973645'),
(15, '01234895672');

insert into Department (Dep_id, Dep_name, Mng_id) values
(3001, 'IT Department', 2),
(3002, 'HR Department', 3),
(3003, 'Marketing', 4),
(3004, 'Sales', 5),
(3005, 'Finance', 6),
(3006, 'Admin', 7),
(3007, 'Legal', 8),
(3008, 'Operations', 9),
(3009, 'Support', 10),
(3010, 'Training', 11),
(3011, 'Research and Development', 12),
(3012, 'Design', 13),
(3013, 'Product Management', 14),
(3014, 'Logistics', 15),
(3015, 'Customer Service', 1);

insert into Project (Project_id, Project_name, Start_date, End_date, Dep_id) values
(4001, 'Software Development', '2023-01-01', '2023-12-31', 3001),
(4002, 'HR System Implementation', '2023-02-01', '2023-11-30', 3002),
(4003, 'Website Redesign', '2023-03-15', '2023-09-30', 3003),
(4004, 'Sales Strategy', '2023-04-01', '2023-12-15', 3004),
(4005, 'Finance Reporting Tool', '2023-05-01', '2023-08-31', 3005),
(4006, 'Employee Training', '2023-06-10', '2023-10-15', 3010),
(4007, 'Market Research', '2023-07-01', '2023-12-31', 3003),
(4008, 'Client Management System', '2023-08-01', '2023-12-01', 3007),
(4009, 'Internal Audit', '2023-09-01', '2023-11-15', 3005),
(4010, 'Legal Framework Update', '2023-10-01', '2023-12-31', 3007),
(4011, 'Customer Experience Improvement', '2023-11-01', '2024-05-15', 3012),
(4012, 'Business Expansion Plan', '2023-12-01', '2024-06-30', 3015),
(4013, 'Procurement Management', '2024-01-15', '2024-07-15', 3014),
(4014, 'Software Testing', '2024-02-01', '2024-03-31', 3001),
(4015, 'Product Launch Campaign', '2024-03-01', '2024-05-15', 3013);



insert into Attendance (Attendance_id, Emp_id, status, Overtime_hours, Check_in_time, Check_out_time, Date) values
(5001, 1, 'Present', 2, '09:00:00', '17:00:00', '2023-01-01'),
(5002, 2, 'Present', 0, '08:45:00', '16:45:00', '2023-01-01'),
(5003, 3, 'Present', 1, '09:15:00', '17:15:00', '2023-01-01'),
(5004, 4, 'Late', 3, '10:00:00', '18:00:00', '2023-01-01'),
(5005, 5, 'Present', 2, '08:30:00', '16:30:00', '2023-01-01'),
(5006, 6, 'Present', 0, '09:00:00', '17:00:00', '2023-01-01'),
(5007, 7, 'Present', 0, '08:30:00', '16:30:00', '2023-01-01'),
(5008, 8, 'Absent', 0, '09:00:00', '17:00:00', '2023-01-01'),
(5009, 9, 'Present', 1, '09:00:00', '17:00:00', '2023-01-01'),
(5010, 10, 'Late', 2, '09:30:00', '17:30:00', '2023-01-01'),
(5011, 11, 'Present', 0, '08:45:00', '16:45:00', '2023-01-01'),
(5012, 12, 'Present', 1, '09:00:00', '17:00:00', '2023-01-01'),
(5013, 13, 'Present', 2, '09:15:00', '17:15:00', '2023-01-01'),
(5014, 14, 'Present', 0, '09:00:00', '17:00:00', '2023-01-01'),
(5015, 15, 'Present', 1, '08:50:00', '16:50:00', '2023-01-01');


insert into Payroll (Payroll_id, Emp_id, Deduction, Payroll_date, Bonus, Basic_salary) values
(6001, 1, 100.00, '2023-01-31', 500.00, 3000.00),
(6002, 2, 120.00, '2023-01-31', 450.00, 3200.00),
(6003, 3, 110.00, '2023-01-31', 550.00, 3100.00),
(6004, 4, 130.00, '2023-01-31', 600.00, 3300.00),
(6005, 5, 100.00, '2023-01-31', 500.00, 2800.00),
(6006, 6, 90.00, '2023-01-31', 400.00, 2700.00),
(6007, 7, 80.00, '2023-01-31', 350.00, 2500.00),
(6008, 8, 110.00, '2023-01-31', 600.00, 3100.00),
(6009, 9, 95.00, '2023-01-31', 450.00, 2800.00),
(6010, 10, 120.00, '2023-01-31', 550.00, 3000.00),
(6011, 11, 100.00, '2023-01-31', 500.00, 2900.00),
(6012, 12, 110.00, '2023-01-31', 550.00, 3100.00),
(6013, 13, 105.00, '2023-01-31', 520.00, 3000.00),
(6014, 14, 115.00, '2023-01-31', 570.00, 3200.00),
(6015, 15, 100.00, '2023-01-31', 490.00, 2900.00);



insert into Training (Id, Date, Duration, Training_Name, Trainer_Name)
values
(7001, '2023-01-15', 3, 'Leadership Development', 'John Smith'),
(7002, '2023-02-10', 2, 'Software Development Best Practices', 'Emily White'),
(7003, '2023-03-20', 4, 'Project Management Essentials', 'Michael Brown'),
(7004, '2023-04-01', 5, 'HR Management and Ethics', 'Sarah Martinez'),
(7005, '2023-05-10', 3, 'Effective Communication Skills', 'David Green'),
(7006, '2023-06-15', 2, 'Time Management', 'Rebecca Clark'),
(7007, '2023-07-10', 4, 'Conflict Resolution', 'Paul Wright'),
(7008, '2023-08-01', 3, 'Sales Techniques', 'Lisa Miller'),
(7009, '2023-09-05', 3, 'Customer Service Excellence', 'Chris Johnson'),
(7010, '2023-10-15', 5, 'Financial Management', 'Rachel Adams'),
(7011, '2023-11-02', 4, 'Negotiation Skills', 'Steven Lee'),
(7012, '2023-12-10', 2, 'Productivity Hacks', 'James Walker'),
(7013, '2024-01-15', 3, 'Team Building', 'Olivia Brown'),
(7014, '2024-02-01', 4, 'Business Intelligence', 'Sophie Taylor'),
(7015, '2024-03-20', 2, 'Crisis Management', 'Henry Thomas');


insert into Employee_Training (Training_id, Emp_id)values
(7001, 1), (7002, 2), (7003, 3), (7004, 4), (7005, 5),
(7006, 6), (7007, 7), (7008, 8), (7009, 9), (7010, 10),
(7011, 11), (7012, 12), (7013, 13), (7014, 14), (7015, 15);



insert into Performance (Evaluation_id, Emp_id, Super_id, Evaluation_date, Collaboration_score, Productivity_grade)
values
(8001, 1, 2, '2023-01-15', 9, 8),
(8002, 2, 1, '2023-01-15', 7, 6),
(8003, 3, 1, '2023-01-15', 8, 9),
(8004, 4, 3, '2023-01-15', 10, 10),
(8005, 5, 3, '2023-01-15', 6, 5),
(8006, 6, 2, '2023-01-15', 7, 8),
(8007, 7, 1, '2023-01-15', 6, 7),
(8008, 8, 2, '2023-01-15', 5, 5),
(8009, 9, 4, '2023-01-15', 10, 10),
(8010, 10, 4, '2023-01-15', 7, 6),
(8011, 11, 1, '2023-01-15', 8, 8),
(8012, 12, 2, '2023-01-15', 6, 6),
(8013, 13, 3, '2023-01-15', 9, 7),
(8014, 14, 4, '2023-01-15', 5, 6),
(8015, 15, 2, '2023-01-15', 6, 5);



insert into Requests (Request_id, Emp_id, Request_status, Request_type, Request_date)
values
(9001, 1, 'Approved', 'Sick Leave', '2023-01-05'),
(9002, 2, 'Pending', 'Vacation', '2023-01-07'),
(9003, 3, 'Approved', 'Personal Leave', '2023-01-09'),
(9004, 4, 'Denied', 'Sick Leave', '2023-01-10'),
(9005, 5, 'Approved', 'Vacation', '2023-01-11'),
(9006, 6, 'Approved', 'Personal Leave', '2023-01-12'),
(9007, 7, 'Pending', 'Sick Leave', '2023-01-13'),
(9008, 8, 'Denied', 'Vacation', '2023-01-14'),
(9009, 9, 'Approved', 'Personal Leave', '2023-01-15'),
(9010, 10, 'Pending', 'Vacation', '2023-01-16'),
(9011, 11, 'Approved', 'Sick Leave', '2023-01-17'),
(9012, 12, 'Denied', 'Personal Leave', '2023-01-18'),
(9013, 13, 'Approved', 'Vacation', '2023-01-19'),
(9014, 14, 'Pending', 'Sick Leave', '2023-01-20'),
(9015, 15, 'Denied', 'Personal Leave', '2023-01-21');



insert into Account (Account_id, Emp_id, Username, Password, Role)
values
(10001, 1, 'john.doe', 'password123', 'manager'),
(10002, 2, 'jane.smith', 'password456', 'manager'),
(10003, 3, 'michael.brown', 'password789', 'manager'),
(10004, 4, 'emily.white', 'password101', 'employee'),
(10005, 5, 'david.green', 'password202', 'employee'),
(10006, 6, 'laura.black', 'password303', 'employee'),
(10007, 7, 'chris.johnson', 'password404', 'admin'),
(10008, 8, 'sarah.martinez', 'password505', 'employee'),
(10009, 9, 'james.davis', 'password606', 'employee'),
(10010, 10, 'patricia.miller', 'password707', 'employee'),
(10011, 11, 'paul.wilson', 'password808', 'employee'),
(10012, 12, 'linda.taylor', 'password909', 'admin'),
(10013, 13, 'steven.anderson', 'password010', 'employee'),
(10014, 14, 'angela.thomas', 'password111', 'employee'),
(10015, 15, 'mark.jackson', 'password121', 'employee');



insert into Candidate (Candidate_id, Full_name, Phone, Email, Job_applied_for)
values
(11001, 'Alice Johnson', '01012345679', 'alice.johnson@example.com', 'Software Engineer'),
(11002, 'Bob Lee', '01123456780', 'bob.lee@example.com', 'HR Manager'),
(11003, 'Charlie Brown', '01234567891', 'charlie.brown@example.com', 'Project Manager'),
(11004, 'Diana Smith', '01098765433', 'diana.smith@example.com', 'Marketing Specialist'),
(11005, 'Eve Taylor', '01187654322', 'eve.taylor@example.com', 'Business Analyst'),
(11006, 'Frank Moore', '01056473829', 'frank.moore@example.com', 'Data Scientist'),
(11007, 'Grace Lee', '01123123456', 'grace.lee@example.com', 'Sales Manager'),
(11008, 'Hannah Clark', '01234123457', 'hannah.clark@example.com', 'Product Manager'),
(11009, 'Ian Davis', '01065748392', 'ian.davis@example.com', 'Software Tester'),
(11010, 'Jack Miller', '01187563421', 'jack.miller@example.com', 'UX/UI Designer'),
(11011, 'Kathy Allen', '01036547891', 'kathy.allen@example.com', 'Marketing Manager'),
(11012, 'Louis Scott', '01123412345', 'louis.scott@example.com', 'HR Assistant'),
(11013, 'Maria King', '01238765432', 'maria.king@example.com', 'Operations Manager'),
(11014, 'Nina Scott', '01045612389', 'nina.scott@example.com', 'Customer Support'),
(11015, 'Oliver Lee', '01112987654', 'oliver.lee@example.com', 'IT Support');



insert into Recruitment_process (Recruitment_id, Candidate_id, Interview_date, Interview_score, Hiring_status, Job_title, Interviewer_id)
values
(12001, 11001, '2023-01-20', 85, 'Hired', 'Software Engineer', 2),
(12002, 11002, '2023-02-10', 78, 'Rejected', 'HR Manager', 1),
(12003, 11003, '2023-03-01', 92, 'Hired', 'Project Manager', 3),
(12004, 11004, '2023-04-10', 80, 'Rejected', 'Marketing Specialist', 2),
(12005, 11005, '2023-05-15', 88, 'Hired', 'Business Analyst', 1),
(12006, 11006, '2023-06-25', 90, 'Hired', 'Data Scientist', 4),
(12007, 11007, '2023-07-20', 70, 'Rejected', 'Sales Manager', 3),
(12008, 11008, '2023-08-01', 95, 'Hired', 'Product Manager', 1),
(12009, 11009, '2023-09-05', 82, 'Hired', 'Software Tester', 4),
(12010, 11010, '2023-10-15', 75, 'Rejected', 'UX/UI Designer', 2),
(12011, 11011, '2023-11-10', 78, 'Hired', 'Marketing Manager', 1),
(12012, 11012, '2023-12-15', 85, 'Hired', 'HR Assistant', 3),
(12013, 11013, '2024-01-05', 90, 'Hired', 'Operations Manager', 4),
(12014, 11014, '2024-02-01', 65, 'Rejected', 'Customer Support', 2),
(12015, 11015, '2024-03-01', 89, 'Hired', 'IT Support', 1);

insert into [dbo].[emp_work_on_dept] (emp_id, dept_id) values
(1, 3001),
(2, 3002),
(3, 3003),
(4, 3004),
(5, 3005),
(6, 3006),
(7, 3007),
(8, 3008),
(9, 3009),
(10, 3010),
(11, 3011),
(12, 3012),
(13, 3013),
(14, 3014),
(15, 3015);

insert into [dbo].[project_assign_to_emp] (emp_id, proj_id) values
(1, 4001),
(2, 4002),
(3, 4003),
(4, 4004),
(5, 4005),
(6, 4006),
(7, 4007),
(8, 4008),
(9, 4009),
(10, 4010),
(11, 4011),
(12, 4012),
(13, 4013),
(14, 4014),
(15, 4015);


backup database HR_Management

to disk = 'G:\iti_powe_bi\sql\project\HR_Management.bak' 
with format, name = 'full backup'

