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
    CONSTRAINT reservation_id PRIMARY KEY (reservation_id),
    CONSTRAINT reservations_rooms_fk FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    CONSTRAINT reservations_customers_fk FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Sequences for each table's primary key to use
CREATE SEQUENCE customer_id_seq MINVALUE 1 MAXVALUE 99999999999 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE location_id_seq MINVALUE 1 MAXVALUE 99999999999 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE room_id_seq MINVALUE 1 MAXVALUE 99999999999 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE reservation_id_seq MINVALUE 1 MAXVALUE 99999999999 START WITH 1 INCREMENT BY 1 CACHE 20;