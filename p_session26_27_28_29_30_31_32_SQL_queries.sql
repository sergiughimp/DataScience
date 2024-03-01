-- ********************************************************************************
-- 26
-- Recap:
-- 1. Installation of MySQL Workbench
-- 2. Introduction to database
-- 3. Loading dataset into MySQL Workbench


-- Program -> Corect -> Executed
-- 		-> Incorect -> Not Executed
--         
-- Queries -> Corect -> fired
-- 		-> Incorect -> not fired
-- Queries = set of logical lines in SQL
-- clause = a special keyword in SQL such as "where", "from". it has a predifined purpose such as filtering, grouping 

use moviesdb;
-- 1. I want to see everything from movies table
select * from movies;
-- 2. I want to see title and studio from movies table
select title, studio from movies; 
-- 3. No records, only the industry that have 'Bollywood' 
-- where
select * from movies where industry = 'Bollywood';
-- 4. Count the records, only the indus try that have 'Bollywood' 
select count(*) from movies where industry = 'Bollywood';
-- count() 
select count(title) from movies where industry = 'Bollywood';
-- 5. select the unique industry
-- distrinct = filter only unique values
select distinct(industry) from movies;
select distinct industry, title from movies;
-- wildcard search: like %A%

-- 6. select the records for which title should be THOR
select * from movies where title like "%Thor%";
select movie_id, title from movies;

-- 7. Need the records where studio has messing values
select * from movies where studio ="";
-- 8. showing the records where imdb_rating is null
select * from movies where imdb_rating is null;
-- 9. showing the records for which imdb_rating is not null
select count(*) from movies where imdb_rating is not null;
-- ********************************************************************************
-- 27_SQL
-- all the movies that have the imdb_rating >= 9 
select * from movies where imdb_rating >= 9;

-- between operator
select * from movies where imdb_rating between 6 and 9;
select * from movies where imdb_rating >= 6 and imdb_rating <=9;

-- in  operator = replacement of or operator
select * from movies where release_year = 2022 or release_year = 2017 or release_year = 1975;
select * from movies where release_year in (2022, 2017, 1975);

select * from movies where studio = "Marvel Studios" or studio = "Zee Studios";
select * from movies where studio in ("Marvel Studios", "Zee Studios");

-- order by: ascending, descending
select * from movies order by imdb_rating asc;
select * from movies order by imdb_rating desc;
select * from movies where industry = "Bollywood" order by imdb_rating desc;

-- limit: it will restrict number of rows of records
-- top 5 movies
select * from movies order by imdb_rating desc limit 5;
-- offset: helps to skip a certain number of rows from the result 
select * from movies order by imdb_rating desc limit 5 offset 1;

-- aggregate function: count(), min(), max(), avg()
select count(*) from movies where industry = "Bollywood";
select max(imdb_rating) from movies where industry = "Bollywood";
select min(imdb_rating) from movies where industry = "Bollywood";
-- round() 
select round(avg(imdb_rating), 2) as average_rating from movies where industry = "Bollywood";

select round(min(imdb_rating), 2) as min_rating, round(avg(imdb_rating), 2) as average_rating, round(max(imdb_rating), 2) as max_rating from movies;

-- ********************************************************************************
-- 27 Homework
select * from movies;
-- 1. Print all movie titles and release year for all Marvel Studios movies
select title, release_year from movies where studio = "Marvel Studios";
-- 2. Print all movies that have Avenger in their name
select * from movies where title like "Avenger%";
-- 3. Print the year in which "The Godfather" movie was released
select release_year from movies where title="The Godfather";
-- 4. Print all distinct movie studios in the Bollywood industry
select distinct(studio) from movies where industry="Bollywood";

-- ********************************************************************************
-- 28
-- Agenda
-- 1. group by
-- 2. join in SQL

-- Queries
-- where = to give the condition
use moviesdb;
-- count the Bollywood movies
select industry, count(*) as count from movies where industry = "Bollywood";
-- count the Hollywood movies
select industry, count(*) as count from movies where industry = "Hollywood";
-- count the Bollywood and Hollywood movies
select industry, count(*) as count from movies group by industry;

-- flow of query execution: from -> where -> group by -> having -> select -> distinct -> order by
-- group by = create a summary of metrices such as average, count for selected columns

select studio, count(studio) as count from movies group by studio order by count desc;

-- having = use 'having' clause with 'group by'
-- only studios with count more than 2
select studio, count(*) as count from movies group by studio having count > 2 order by count desc;

-- release_year and movies_count and count should be more than 2
select release_year, count(*) as movies_count from movies group by release_year having movies_count > 2;


-- joins in SQL = helps to connect multiple tables together (Keywords: join, on, and)
-- Types of jon:
-- 1. inner join: common in both the tables
select m.movie_id, title, budget, revenue, currency, unit from movies m join financials f on m.movie_id = f.movie_id;
-- same
select m.movie_id, title, budget, revenue, currency, unit from movies m inner join financials f on m.movie_id = f.movie_id;
-- same
select m.movie_id, title, budget, revenue, currency, unit from movies m inner join financials f using(movie_id);


-- 29
-- database
-- data mark
-- data lake

create database assingment;
use assingment;
show tables;

CREATE TABLE EMPLOYEE
(EMP_ID INT PRIMARY KEY, 
	FIRST_NAME varchar(20),
	LAST_NAME varchar(20),
	SALARY INT,
	JOINING_DATE DATETIME,
	DEPARTMENT varchar(20));
-- drop table employee;
select * from employee;
insert into EMPLOYEE(EMP_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT)
values  (001,'Anika', 'Arora', 100000, '2020-02-14', 'HR'),
(002,'Veena', 'Verma', 80000, '2011-06-15', 'Admin'),
(003,'Vishal', 'Singhal', 300000, '2020-02-16', 'HR'),
(004,'Sushanth', 'Singh', 500000, '2020-02-17', 'Admin'),
(005,'Bhupal', 'Bhati', 500000, '2011-06-18', 'Admin'),
(006,'Dheeraj', 'Diwan', 200000, '2011-06-19', 'Account'),
(007,'Karan', 'Kumar', 75000, '2020-01-14', 'Account'),
(008,'Chandrika', 'Chauhan', 90000, '2011-04-15','Admin');

select * from employee;
-- display the 'first_name' and the 'last_name' from employee table using the alias name as employee_first_name, and employee_last_name 
select first_name as employee_first_name, last_name as employee_last_name from employee;

-- display last_name from employee table in upper case
select upper(last_name) from employee;
-- display the distinct departments from employee
select distinct(department) from employee;

-- display the full name as first_name with last_name
select concat(first_name, ' ', last_name) as "Full Name" from employee;


-- 30
-- join concept
-- database and table creation

use moviesdb;
-- inner join
select m.movie_id, title, budget, revenue, currency, unit from movies m inner join financials f on m.movie_id = f.movie_id;
-- left join
select m.movie_id, title, budget, revenue, currency, unit from movies m left join financials f  on m.movie_id = f.movie_id;
select budget, name from financials f left join actors a on f.movie_id = a.actor_id; 

-- right join
select m.movie_id, title, budget, revenue, currency, unit from movies m right join financials f on m.movie_id = f.movie_id;
-- union (combine left join and right join) = full join
select m.movie_id, title, budget, revenue, currency, unit from movies m left join financials f on m.movie_id = f.movie_id
UNION
select m.movie_id, title, budget, revenue, currency, unit from movies m right join financials f on m.movie_id = f.movie_id;
-- cross join = used to combine each row of one table with each row of another table, giving
select * from movies cross join financials;

use food_db;
select * from items;
select * from variants;

select * from items cross join variants;
select name, price, variant_name, variant_price, price+variant_price as total_price from items cross join variants;
-- same
select *, price+variant_price as total_price from items cross join variants;

-- Database Creation
create database myDatabaseTest;
use myDatabaseTest;
show tables;
drop database myDatabaseTest;

show databases;

-- 31
-- creating tables
-- inserting values in tables

-- datatypes
-- 1. string: char, varchar (variable character), text
-- 2. numeric: int
-- 3. date: yyyy-mm-dd 2023-06-04
-- 4. Enum: 
-- 5. Gender: (M/F)
-- 6. Users: -> Null accept

-- signed (-20, +20) and unsigned [0, ...]
create database my_database;
use my_database;
drop table users;
create table users 
	(id int unsigned, 
	name varchar(255),
	email varchar(255),
	password  varchar(255),
	contact varchar(20),
	address text,
	dob date, 
	gender enum("M", "F", "O"));

select * from users;

INSERT into users (id, name, email, password, contact, address, dob, gender)
VALUES 
(1, "Govind", "govid@gmail.com", "Govind@hello1", 8083423222, "Noida, Uttar Pradesh India", "1990-11-25", "M"),
(2, "Neha", "neha@gmail.com", "Neha@hello1", 91877654, "Gurugram, Uttar Pradesh India", "2000-02-25", "F"),
(3, "Victoria", "victoria@gmail.com", "Victoria@hello1", 50577654, "Nigeria", "2004-09-13", "F");

INSERT into users (id, name, email, contact, address, dob, gender)
VALUES 
(4, "Michael", "michael@gmail.com", 50577654, "England", "2003-02-22", "F");

select * from users;

-- update command: to update the existing record
update users set name = "Swetha" where id = 3;
-- delete & truncate -> clear only record
delete from users where id = 1;
truncate table users;
-- drop = it delete the skeleton as well
drop table users;
-- primary key = a column or set of columns that use in most visual queries. the column should not have the null values

-- 32
-- primary key = to uniquely identify the record in a table. the column has unique values. the column should not have the null values
-- foreing key = is used to link to tables together
-- parent table (primary key). child table(foreing key)
-- advantages: integrity (if you change the data in table 1 is no need to change in table 2), data consistency (you can't have the foreing key different that primary key)
drop database country;
create database country;
use country;
show tables;

create table table1 
(c_id int not null unique,
country varchar(155),
primary key(c_id));

describe table1;
select * from table1;
insert into table1(c_id, country) values
(1, 'America'),
(2, 'China'),
(3, 'India'),
(4, 'Pakistan'),
(5, 'South Africa');

select * from table1;

create table table2
(id int not null unique,
name varchar(255),
c_id int,
primary key (id),
foreign key(c_id) references table1(c_id));


select * from table2;

insert into table2 (id, name, c_id) values
(1, "Govind", 1),
(2, "Rahul", 2),
(3, "Victoria", 3),
(4, "Sibi", 4), 
(5, "Diana", 5);

-- primary key and foreign key together -> keeps maintains the data integrity and data consistency
-- insert into table2 (id, name, c_id) values  (10, "Mani",6); -- fail. it is not keeping the data integrity and data consistency

insert into table2(id, name) values (11, "Shiva");
select * from table2;

use test_database;
select * from new_table;