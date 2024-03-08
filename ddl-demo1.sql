create database if not exists samplef1;
drop database samplef1;
create schema if not exists sales;
use sales;
CREATE TABLE sales (
    purchase_no INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    date_purchase DATE NOT NULL,
    customer_id INT,
    item_id VARCHAR(10) NOT NULL
);
alter table sales add foreign key(customer_id) references customers(customer_id) on delete cascade;

CREATE TABLE customers (
    customer_id INT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_id VARCHAR(255),
    no_of_complaints INT
);

select * from sales.sales;
drop table sales;

DROP TABLE customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    mail_id VARCHAR(255) unique key,
    no_of_complaints INT
);

alter table customers drop index mail_id;

CREATE TABLE items (
    item_code VARCHAR(255) PRIMARY KEY,
    item VARCHAR(255),
    unitprice NUMERIC(10 , 2 ),
    company_id VARCHAR(255)
);

CREATE TABLE companies (
    company_id VARCHAR(255) PRIMARY KEY,
    company_name VARCHAR(255),
    headquaters_pno INT(12)
);

drop table sales;
drop table customers;
drop table items;
drop table companies;

create table customers(
customer_id int auto_increment primary key,
first_name varchar(255),
last_name varchar(255),
mail_id varchar(255),
no_of_complaints int
);

alter table customers add column gender enum('M','F') after last_name;

insert into sales.customers(first_name,last_name,gender,mail_id,no_of_complaints) values('John','Gallagher','M','johngallagherp1@gmail.com',0);

select * from sales.customers;

alter table customers change column  no_of_complaints no_of_complaints int default 0;


CREATE TABLE companies (
    company_id int PRIMARY KEY auto_increment,
    company_name VARCHAR(255) not null default 'X' ,
    headquaters_pno INT unique key
);

alter table companies modify company_name varchar(255) null;
alter table companies change company_name company_name varchar(255) not null;
drop table companies;

insert into companies(headquaters_pno) values ('98765');

select * from sales.companies;




