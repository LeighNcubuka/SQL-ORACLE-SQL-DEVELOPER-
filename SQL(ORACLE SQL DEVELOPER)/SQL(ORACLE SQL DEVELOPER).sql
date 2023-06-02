create table CUSTOMERS
(
    customer_id     number(4)            not null      primary key,
    first_name      varchar2(10)         not null,
    surname         varchar2(10)         not null,
    email           varchar2(50)         not null
);

create table VENUE
(
    venue_id         		number(3)     	 not null    primary key,
    venue_type       		varchar2(20)     not null,
    venue_price      		number(8,2)      not null,
    venue_availability      varchar2(20)     not null
);

create table VENUE_HIRING
(
    hire_id           varchar(10)     not null    primary key,
    hire_date         date            not null,
    number_of_guests  number(5,2)     not null,
    venue_id          number(3)       not null,
                      CONSTRAINT venue_id
                      FOREIGN KEY (venue_id)
                      REFERENCES VENUE(venue_id),
    customer_id       number(4)       not null,
                      CONSTRAINT cust_id
                      FOREIGN KEY (customer_id)
                      REFERENCES CUSTOMERS(customer_id)
);

insert all
  into CUSTOMERS(customer_id, first_name, surname, email)
    values(1001, 'Patrick', 'Smith', 'ps@yahoo.com')
  into CUSTOMERS(customer_id, first_name, surname, email)
   values(1002, 'Ellenor', 'Johnson', 'ej@gmail.com')
  into CUSTOMERS(customer_id, first_name, surname, email)
   values(1003, 'Janice', 'Goodwin', 'jan_andre@isat.co.za')
  Select * from dual;
  Commit;
  
insert all
  into VENUE(venue_id, venue_type, venue_price, venue_availability)
    values(111, 'Wedding Hall', 5900, 'available')
  into VENUE(venue_id, venue_type, venue_price, venue_availability)
   values(112, 'Ballrooom Hall', 5700, 'not available')
  into VENUE(venue_id, venue_type, venue_price, venue_availability)
   values(113, 'Outdoor Arena', 7900, 'available')
  Select * from dual;
  Commit;
  
insert all
  into VENUE_HIRING(hire_id, hire_date, number_of_guests, venue_id, customer_id)
    values('hire_101', '15 March 2022', 200, 111, 1003)
  into VENUE_HIRING(hire_id, hire_date, number_of_guests, venue_id, customer_id)
   values('hire_102', '17 March 2022', 100, 112, 1003)
  into VENUE_HIRING(hire_id, hire_date, number_of_guests, venue_id, customer_id)
   values('hire_103', '19 March 2022', 100, 112, 1001)
  into VENUE_HIRING(hire_id, hire_date, number_of_guests, venue_id, customer_id)
    values('hire_104', '20 March 2022', 300, 113, 1002)
  Select * from dual;
  Commit;
  
  
  
  --question 1--
  
SELECT Concat(Concat(C.First_Name,' '),C.Surname) as CUSTOMER, v.venue_price as PRICE, vhs.hire_date as HIRE_DATE
From venue_hiring vhs
INNER JOIN customers c on vhs.customer_id = c.customer_id
INNER JOIN venue v on v.venue_id = vhs.venue_id;



-- question 2 --
SELECT c.customer_id as CUSTOMER_ID,vhs.venue_id as VENUE_ID, v.venue_price AS PRICE,(v.venue_price*0.10) as INCREASE,(v.venue_price+(v.venue_price*0.10)) as INCREASED_PRICE
From venue_hiring vhs
INNER JOIN customers c on vhs.customer_id = c.customer_id
INNER JOIN venue v on v.venue_id = vhs.venue_id;

--question 3--

SET SERVEROUTPUT ON
DECLARE
EMAIL customers.EMAIL%TYPE;
VENUE venue.venue_type%TYPE;
NUMBER_OF_GUESTS VENUE_HIRING.number_of_guests%TYPE;
CURSOR INFO IS
SELECT c.email,v.venue_type,vh.number_of_guests
From  venue_hiring vhs
INNER JOIN customers C on vhs.customer_id= c.customer_id
where vh.number_of_guests>300;
BEGIN
FOR REC IN INFO
LOOP
        EMAIL:=REC.email;
        VENUE:=REC.rent_date;
        NUMBER_OF_GUESTS:=REC.number_of_guests;
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('CUSTOMER EMAIL:      '||EMAIL);
        DBMS_OUTPUT.PUT_LINE('VENUE:         '||VENUE);
        DBMS_OUTPUT.PUT_LINE('NUMBER_OF_GUESTS:         '||NUMBER_OF_GUESTS);
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------');
END LOOP;
END;
 
 
--QUESTION 4--

SET SERVEROUTPUT ON
DECLARE
CUSTOMER customers.customer_id%TYPE;
AVERAGE venue.venue_price%TYPE;

CURSOR INFO IS
SELECT c.customer_id , v.venue_price
From  venue_hiring vhs
INNER JOIN customers c on vhs.customer_id = c.customer_id;
BEGIN
FOR REC IN INFO
LOOP
        CUSTOMER:=REC.customer_id;
        AVERAGE:=REC.venue_price;
        
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('CUSTOMER_ID:      '||CUSTOMER);
        DBMS_OUTPUT.PUT_LINE('AVERAGE_PRICE:         '||AVERAGE);
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------');
END LOOP;
END;

--question 5--

Create or replace view vwVenueHireDetails
as
SELECT c.customer_id, v.venue_type, v.venue_price, vhs.number_of_guests, vhs.hire_date
From VENUE_HIRING vhs
INNER JOIN customers c on vhs.customer_id = c.customer_id
INNER JOIN venue v on v.venue_id = vhs.venue_id
Where vhs.hire_date Between '15-March-2022' and '18-March-2022';


 

