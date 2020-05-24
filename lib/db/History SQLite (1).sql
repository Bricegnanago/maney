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

--- 23-05-2020 04:01:43
--- sqlite.3
/***** ERROR ******
near "#create": syntax error
 ----- 
#create table compte(compte_id, owner_id, createdAat timestamp, amount)

create operation(operation_id integer PRIMARY KEY AUTOINCREMENT not null, title text, description TEXT)
#CREATE TABLE story(customers_id, user_id, amount, operation_id);
*****/

--- 23-05-2020 04:02:37
--- sqlite.3
/***** ERROR ******
near "operation": syntax error
 ----- 
create operation(operation_id integer PRIMARY KEY AUTOINCREMENT not null, title text, description TEXT);
*****/

--- 23-05-2020 04:03:26
--- sqlite.3
create TABLE operation(operation_id integer PRIMARY KEY AUTOINCREMENT not null, title text, description TEXT);

--- 23-05-2020 04:15:34
--- sqlite.3
/***** ERROR ******
unknown column "customers" in foreign key definition
 ----- 
CREATE TABLE story(story_id integer PRIMARY KEY AUTOINCREMENT not null, 
                   customers_id integer, 
                   user_id integer, 
                   amount real,
                   operation_id integer,
                   dateOfCredit TIMESTAMP,
                   cancelCredit timestamp NULL,
                   FOREIGN KEY(operation_id) REFERENCES operation(operation_id),
                   FOREIGN KEY(customers) REFERENCES customers(customers_id),                   
                  );
*****/

--- 23-05-2020 04:16:09
--- sqlite.3
ALTER TABLE customers RENAME COLUMN client_id TO customer_id;

--- 23-05-2020 04:16:35
--- sqlite.3
/***** ERROR ******
near ")": syntax error
 ----- 
CREATE TABLE story(story_id integer PRIMARY KEY AUTOINCREMENT not null, 
                   customer_id integer, 
                   user_id integer, 
                   amount real,
                   operation_id integer,
                   dateOfCredit TIMESTAMP,
                   cancelCredit timestamp NULL,
                   FOREIGN KEY(operation_id) REFERENCES operation(operation_id),
                   FOREIGN KEY(customer_id) REFERENCES customers(customer_id),                   
                  );
*****/

--- 23-05-2020 04:16:44
--- sqlite.3
CREATE TABLE story(story_id integer PRIMARY KEY AUTOINCREMENT not null, 
                   customer_id integer, 
                   user_id integer, 
                   amount real,
                   operation_id integer,
                   dateOfCredit TIMESTAMP,
                   cancelCredit timestamp NULL,
                   FOREIGN KEY(operation_id) REFERENCES operation(operation_id),
                   FOREIGN KEY(customer_id) REFERENCES customers(customer_id)                  
                  );

--- 23-05-2020 04:19:45
--- sqlite.5
insert into operation VALUES(null, "CREDIT", "On credite le compte d'un montant positif");

--- 23-05-2020 04:20:16
--- sqlite.5
insert into operation VALUES(null, "DEBIT", "On débite le compte d'un montant négatif");

--- 23-05-2020 04:20:48
--- sqlite.2
select * from operation;

--- 23-05-2020 04:24:55
--- sqlite.6
select * from customers;

--- 23-05-2020 04:27:15
--- sqlite.5
/***** ERROR ******
no such column: dateOfCredit
 ----- 
insert into story VALUES(null, 1, 1, 3000.0, 1, dateOfCredit, null);
*****/

--- 23-05-2020 04:28:10
--- sqlite.5
insert into story VALUES(null, 1, 1, 3000.0, 1,strftime('%d-%m-%Y %H:%M:%S', datetime('now')) , null);

--- 23-05-2020 04:28:27
--- sqlite.6
select * from story;

