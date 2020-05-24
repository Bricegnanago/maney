--- 23-05-2020 03:35:07
--- SQLite
/***** ERROR ******
near "customers": syntax error
 ----- 
CREATE customers(client_id integer autoincrement primary key not NULL, fullname Text, email_address Text, createdAt timestamp);
*****/

--- 23-05-2020 03:35:21
--- SQLite
/***** ERROR ******
near "autoincrement": syntax error
 ----- 
CREATE table customers(client_id integer autoincrement primary key not NULL, fullname Text, email_address Text, createdAt timestamp);
*****/

--- 23-05-2020 03:35:41
--- SQLite
CREATE table customers(client_id integer primary key autoincrement not NULL, fullname Text, email_address Text, createdAt timestamp);

--- 23-05-2020 03:40:11
--- sqlite.1
insert into customers VALUES(null, "Gnanago Aimé Brice César", "gnanagobrice@gmail.com", strftime('YYYY-MM-DD HH:MM:SS','now'));

--- 23-05-2020 03:40:39
--- sqlite.2
select * from customers;

--- 23-05-2020 03:42:44
--- sqlite.1
/***** ERROR ******
near "now": syntax error
 ----- 
insert into customers VALUES(null, "Gnanago Aimé Brice César", "gnanagobrice@gmail.com", strftime('strftime("%d-%m-y% HH:MM:SS",'now'));
*****/

--- 23-05-2020 03:44:50
--- sqlite.1
insert into customers VALUES(null, "Gnanago Aimé Brice César", "gnanagobrice@gmail.com", strftime('%d/%m/%Y', date('now')));

--- 23-05-2020 03:44:57
--- sqlite.2
select * from customers;

--- 23-05-2020 03:46:23
--- sqlite.1
insert into customers VALUES(null, "Gnanago Aimé Brice César", "gnanagobrice@gmail.com", strftime('%d/%m/%Y HH:mm:ss', date('now')));

--- 23-05-2020 03:46:32
--- sqlite.2
select * from customers;

--- 23-05-2020 03:46:59
--- sqlite.1
insert into customers VALUES(null, "Gnanago Aimé Brice César", "gnanagobrice@gmail.com", strftime('%d/%m/%Y HH:mm:ss', 'now'));

--- 23-05-2020 03:47:03
--- sqlite.2
select * from customers;

--- 23-05-2020 03:49:02
--- sqlite.1
/***** ERROR ******
incomplete input
 ----- 
insert into customers VALUES(null, "Gnanago Aimé Brice César", "gnanagobrice@gmail.com", strftime('%d-%m-%Y %H:%M:%S', datetime('now'));
*****/

--- 23-05-2020 03:49:10
--- sqlite.1
insert into customers VALUES(null, "Gnanago Aimé Brice César", "gnanagobrice@gmail.com", strftime('%d-%m-%Y %H:%M:%S', datetime('now')));

--- 23-05-2020 03:49:14
--- sqlite.2
select * from customers;

--- 23-05-2020 03:49:39
--- sqlite.2
select * from customers;

--- 23-05-2020 03:49:41
--- sqlite.2
select * from customers;

