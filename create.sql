-- Drop statements so that the create statements can start fresh
DROP TABLE reservations;
DROP TABLE rooms;
DROP TABLE locations;
DROP TABLE customers;

DROP SEQUENCE customer_id_seq;
DROP SEQUENCE location_id_seq;
DROP SEQUENCE room_id_seq;
DROP SEQUENCE reservation_id_seq;

-- Begin create statements

CREATE TABLE customers
(
    customer_id number(11) NOT NULL,
    first varchar2(20) NOT NULL,
    last varchar2(30) NOT NULL,
    card_no char(19) NOT NULL,
    card_type varchar2(20),
    CONSTRAINT customers_pk PRIMARY KEY (customer_id),
    -- Constraint to only allow the types of cards we accept
    CONSTRAINT card_type_ck CHECK (card_type in ('Visa', 'MasterCard', 'Discover', 'American Express'))
);

CREATE TABLE locations
(
    location_id number(11) NOT NULL,
    address_line varchar2(50) NOT NULL,
    city varchar2(35),
    state_province varchar2(35),
    zip varchar2(10),
    country varchar2(40),
    CONSTRAINT locations_pk PRIMARY KEY (location_id)
);

CREATE TABLE rooms
(
    room_id number(11) NOT NULL,
    location_id number(11) NOT NULL,
    room_no varchar2(10) NOT NULL,
    fits_no_adults number(2),
    fits_no_kids number(2),
    is_smoking char(1),
    price number(6),
    CONSTRAINT rooms_pk PRIMARY KEY (room_id),
    CONSTRAINT rooms_locations_fk FOREIGN KEY (location_id) REFERENCES locations(location_id),
    -- Constraint to make sure is_smoking is either 'T' or 'F'
    CONSTRAINT is_smoking_CK CHECK (is_smoking in ('T', 'F'))
);

CREATE TABLE reservations
(
    reservation_id number(11) NOT NULL,
    room_id number(11) NOT NULL,
    customer_id number(11) NOT NULL,
    arrive_date date,
    depart_date date,
    adults number(2),
    kids number(2),
    CONSTRAINT reservations_pk PRIMARY KEY (reservation_id),
    CONSTRAINT reservations_rooms_fk FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    CONSTRAINT reservations_customers_fk FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Sequences for each table's primary key to use
CREATE SEQUENCE customer_id_seq;
CREATE SEQUENCE location_id_seq;
CREATE SEQUENCE room_id_seq;
CREATE SEQUENCE reservation_id_seq;

-- NOTE: At work. Untested script. Will test this afternoon.

-- This script assumes all sequences are starting at 1

-- Customers Table


INSERT INTO customers (customer_id, first, last, card_no, card_type)
    VALUES(customer_id_seq.nextval, 'John', 'Doe', '1234 5678 9102 3456', 'Visa');
INSERT INTO customers (customer_id, first, last, card_no, card_type)
    VALUES(customer_id_seq.nextval, 'Jane', 'Buck', '5555 0987 6543 2109', 'American Express');
INSERT INTO customers (customer_id, first, last, card_no, card_type)
    VALUES(customer_id_seq.nextval, 'Frank', 'Caliendo', '2323 4578 9191 6666', 'Discover');
INSERT INTO customers (customer_id, first, last, card_no, card_type)
    VALUES(customer_id_seq.nextval, 'Jeff', 'Smith', '1111 7878 6699 3535', 'MasterCard');
INSERT INTO customers (customer_id, first, last, card_no, card_type)
    VALUES(customer_id_seq.nextval, 'Tory', 'Lane', '1234 6677 4455 3322', 'Visa');



-- Locations table


INSERT INTO locations (location_id, address_line, city, state_province, zip, country)
    VALUES (location_id_seq.nextval, '123 E. Downing St.', 'London', 'Greater London', '5427', 'United Kingdom');
INSERT INTO locations (location_id, address_line, city, state_province, zip, country)
    VALUES (location_id_seq.nextval, '2424 River Blvd.', 'Vancouver', 'British Columbia', 'V5K 0C3', 'Canada');
INSERT INTO locations (location_id, address_line, city, state_province, zip, country)
    VALUES (location_id_seq.nextval, '555 27th St.', 'New York City', 'New York', '10004', 'United States');
INSERT INTO locations (location_id, address_line, city, state_province, zip, country)
    VALUES (location_id_seq.nextval, '1414 Rodeo Dr.', 'Beverly Hills', 'California', '90210', 'United States');



-- Rooms table


INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 1, '101', 2, 2, 'F', 100);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 1, '102', 4, 0, 'F', 125);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 1, '103', 4, 2, 'F', 140);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 1, '201', 6, 3, 'F', 175);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 1, '202', 6, 4, 'F', 200);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 2, 'A100', 2, 0, 'F', 80);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 2, 'A200', 2, 1, 'F', 90);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 2, 'A300', 4, 2, 'F', 120);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 2, 'A400', 8, 0, 'F', 140);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 2, 'A500', 6, 5, 'F', 150);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 3, '1200', 4, 2, 'F', 250);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 3, '1201', 2, 2, 'F', 180);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 3, '1202', 1, 0, 'F', 145);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 3, '1203', 6, 4, 'F', 300);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 3, '1300', 4, 2, 'F', 245);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 4, '101A', 2, 1, 'F', 160);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 4, '101B', 2, 2, 'F', 170);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 4, '201', 4, 2, 'F', 200);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 4, '202', 4, 3, 'F', 225);
INSERT INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
    VALUES (room_id_seq.nextval, 4, '300', 8, 5, 'F', 500);

-- Reservations table

INSERT INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
    VALUES (reservation_id_seq.nextval, 2, 1, to_date('2019/06/01', 'yyyy/mm/dd'), to_date('2019/06/04', 'yyyy/mm/dd'), 3, 0);
INSERT INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
    VALUES (reservation_id_seq.nextval, 9, 2, to_date('2019/06/03', 'yyyy/mm/dd'), to_date('2019/06/10', 'yyyy/mm/dd'), 6, 0);
INSERT INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
    VALUES (reservation_id_seq.nextval, 12, 3, to_date('2019/06/02', 'yyyy/mm/dd'), to_date('2019/06/04', 'yyyy/mm/dd'), 2, 2);
INSERT INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
    VALUES (reservation_id_seq.nextval, 20, 4, to_date('2019/06/01', 'yyyy/mm/dd'), to_date('2019/06/04', 'yyyy/mm/dd'), 6, 4);
INSERT INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
    VALUES (reservation_id_seq.nextval, 1, 5, to_date('2019/06/12', 'yyyy/mm/dd'), to_date('2019/06/15', 'yyyy/mm/dd'), 2, 1);
INSERT INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
    VALUES (reservation_id_seq.nextval, 7, 1, to_date('2019/06/15', 'yyyy/mm/dd'), to_date('2019/06/18', 'yyyy/mm/dd'), 2, 0);
INSERT INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
    VALUES (reservation_id_seq.nextval, 11, 2, to_date('2019/07/05', 'yyyy/mm/dd'), to_date('2019/07/08', 'yyyy/mm/dd'), 2, 1);
INSERT INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
    VALUES (reservation_id_seq.nextval, 16, 3, to_date('2019/06/11', 'yyyy/mm/dd'), to_date('2019/06/15', 'yyyy/mm/dd'), 1, 0);
INSERT INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
    VALUES (reservation_id_seq.nextval, 13, 4, to_date('2019/07/15', 'yyyy/mm/dd'), to_date('2019/07/22', 'yyyy/mm/dd'), 1, 0);
INSERT INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
    VALUES (reservation_id_seq.nextval, 19, 5, to_date('2019/07/24', 'yyyy/mm/dd'), to_date('2019/07/27', 'yyyy/mm/dd'), 3, 1);
