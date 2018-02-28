use mydb;

insert into event_organizer values (1,'Oraganizer1','Boston',100);
insert into event_organizer values (2,'Organizer2','Waltham',150);

insert into event_management values(1,'EventManagement1',1);
insert into event_management values(2,'EventManagement2',2);

insert into person values (1,'Vedant',"M",'1991-01-01' ,"Employee",85785587);
insert into person values (2,'Mike',"M",'1997-08-12',"Employee",617617617);
insert into person values (3,'John',"M",'1992-07-10',"Employee",915915915);
insert into person values (4,'Jennifer',"F",'1992-07-10',"Employee",778567);
insert into person values (5,'Mitch',"M",'1992-11-01',"Employee",61217347);
insert into person values (6,'Johnny',"M",'1989-10-10',"Employee",91354915);
insert into person values (7,'Bella',"F",'1990-12-12',"Customer",6778678);
insert into person values (8,'Emma',"F",'1995-11-16',"Customer",4556456);
insert into person values (9,'Emma',"F",'1992-07-26',"Customer",4562256);
insert into person values (11,'Emma',"F",'1992-04-17',"Employee",45642326);
insert into person values (12,'Emma',"F",'1992-07-10',"Customer",4564326);

SELECT * FROM person;
insert into employee values (12341234,200000,"Security",1,1);
insert into employee values (12346234,200000,"Food",2,1);
insert into employee values (12654234,200000,"Decor_and_Stage",3,1);
insert into employee values (12341784,200000,"Security",4,2);
insert into employee values (12346564,200000,"Food",5,2);
insert into employee values (16765234,200000,"Decor_and_Stage",6,2);

insert into event values (1,'Event1','Charity','Bolyston','Boston','Massachusetts',12345,1,100);
insert into event value (2,'Event2','Fun','PeterBorough', 'Boston','Massachusetts',123456,2,150);

insert into customer value (7);
insert into customer value (8);
insert into customer value (9);
insert into customer value (12);

insert into customer_has_event values (7,1);
insert into customer_has_event values (8,2);
insert into customer_has_event values (9,1);
insert into customer_has_event values (12,2);

insert into band value (1,'Band1','Pop',1);
insert into band value(2,'Band2','Rock',2);

insert into event_has_band value (1,1);
insert into event_has_band value (2,2);

insert into sponsor value (1,'Sponsor1',10000);
insert into sponsor value (2,'Sponsor2',1000);
insert into sponsor value (3,'Sponsor3',15000);
insert into sponsor value (4,'Sposnsor4',1800);

insert into event_organizer_has_sponsor value (1,1);
insert into event_organizer_has_sponsor value (1,2);
insert into event_organizer_has_sponsor value (2,3);
insert into event_organizer_has_sponsor value (2,4);

insert into finance value (1,'Bank',500,1);
insert into finance value (2,'Self',200,2);
insert into finance value (3,'Bank',300,3);
insert into finance value (4,'Self',400,4);

insert into advertising value (1,'Advertising1','Social');
insert into advertising value (2,'Advertising1','Paper');
insert into advertising value (3,'Advertising3','Social');
insert into advertising value (4,'Advertising4','Paper');

insert into event_organizer_has_advertising value (1,1);
insert into event_organizer_has_advertising value (1,2);
insert into event_organizer_has_advertising value (2,3);
insert into event_organizer_has_advertising value (2,4);

insert into ticket value (1,100,'A1',7,1);
insert into ticket value(2,150,'A2',8,2);
insert into ticket value (3,200,'B4',9,1);
insert into ticket value (4,200,'B5',12,2);


Delimiter $$
Create procedure proc_customers(IN id INT)
begin
SELECT Event_Organizer_idEvent_Organizer as EventID,Person.Name as Customer, Person.Gender, Person.Contact,PERSON.DOB, idTicket
FROM Customer
INNER JOIN person ON Person_idPerson=Person.idPerson
INNER JOIN ticket ON Person_idPerson=Customer_Person_idPerson 
WHERE ticket.Event_Organizer_idEvent_Organizer = id;
 end $$
 Delimiter ;
 
call proc_customers(2);



 drop procedure proc_customers;
 
Delimiter $$
Create procedure proc_event(IN id INT)
begin
SELECT event_organizer.idEvent_Organizer as EventID,advertising.Name, event_management.Name, sponsor.Name
FROM event_organizer
INNER JOIN event_organizer_has_advertising ON event_organizer_has_advertising.Event_Organizer_idEvent_Organizer=event_organizer.idEvent_Organizer
INNER JOIN advertising ON advertising.idAdvertising=event_organizer_has_advertising.Advertising_idAdvertising
INNER JOIN event_management ON event_management.Event_Organizer_idEvent_Organizer=event_organizer.idEvent_Organizer
INNER JOIN event_organizer_has_sponsor ON event_organizer_has_sponsor.Event_Organizer_idEvent_Organizer=event_organizer.idEvent_Organizer
INNER JOIN sponsor ON sponsor.idSponsor=event_organizer_has_sponsor.Sponsor_idSponsor
WHERE event_organizer.idEvent_Organizer = id;
 end $$
 Delimiter ;
 
 call proc_event(1);
 
 
 
Delimiter $$
Create procedure proc_customerticket (IN id INT)
begin
SELECT customer.Person_idPerson, event.Name, event.Street, event.City, event.state,event.Zipcode, ticket.Seat_Allocated
From customer
INNER JOIN customer_has_event ON customer.Person_idPerson=customer_has_event.Customer_Person_idPerson
INNER JOIN event ON event.idEvent=customer_has_event.Event_idEvent
INNER JOIN ticket ON ticket.Customer_Person_idPerson=customer.Person_idPerson
WHERE customer.Person_idPerson =id;
end $$
Delimiter ;

call proc_customerticket(7);
 
 
 
 Delimiter $$
 Create procedure proc_band (IN name VARCHAR(45), id INT)
 begin
 SELECT band.Name, event.Name, event.purpose,event.Street, event.City, event.state,event.Zipcode
 From band
 INNER JOIN event_has_band ON band.idBand=event_has_band.Band_idBand
 INNER JOIN event ON event.idEvent=event_has_band.Event_idEvent
 WHERE band.Name= name && band.idBand= id;
 end $$
 Delimiter ;

call proc_band('Band2',2);
 
 
 
Delimiter $$
Create procedure proc_employee (IN name VARCHAR(45))
BEGIN
SELECT event_management.Name, employee.Person_idPerson, employee.employeeType
from event_management
INNER JOIN employee ON event_management.idEvent_Management=employee.Event_Management_idEvent_Management
INNER JOIN person ON employee.Person_idPerson=person.idPerson
WHERE event_management.Name= name;
end $$
Delimiter ;

call proc_employee('EventManagement1');



Delimiter $$
Create procedure proc_employeetype (IN id INT, employeeType VARCHAR(45))
BEGIN
SELECT event_management.Name, employee.employeeType, employee.Work_Hours, person.Name
from event_management
INNER JOIN employee ON event_management.idEvent_Management=employee.Event_Management_idEvent_Management
INNER JOIN person ON employee.Person_idPerson=person.idPerson
WHERE event_management.idEvent_Management=id && employee.employeeType=employeeType;
end $$
Delimiter ;

call proc_employeetype(1,'food');


 
Delimiter $$
Create procedure proc_revenue (IN id INT)
BEGIN
 select ticket.Event_Organizer_idEvent_Organizer, SUM(ticket.Price)  as 'Total revenue'
 from ticket
 where ticket.Event_Organizer_idEvent_Organizer=id
 group by ticket.Event_Organizer_idEvent_Organizer;
end $$
Delimiter ;

call proc_revenue (2);


 
 delimiter %
 create trigger updateOrganizerTicket
 after insert 
 on Ticket
 for each row
 begin
update event_organizer
set event_organizer.Ticekts_number=event_organizer.Ticekts_number-1
where event_organizer.idEvent_Organizer=New.Event_Organizer_idEvent_Organizer;
 end %
delimiter ;


create view employeeDetails as
select person.Name, person.Gender,person.DOB,person.Type,person.Contact,employee.SSN, employee.Work_Hours
from person
inner join employee on person.idPerson=employee.Person_idPerson;


create view financeDetails as
select finance.Type, finance.Amount, sponsor.Name
from finance
inner join sponsor on finance.Sponsor_idSponsor=sponsor.idSponsor;


