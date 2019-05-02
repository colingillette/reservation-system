-- NOTE: At work. Untested script. Will test this afternoon.

-- This script assumes all sequences are starting at 1

-- Customers Table

INSERT ALL
    INTO customers (customer_id, first, last, card_no, card_type)
        VALUES(customer_id_seq.nextval, 'John', 'Doe', '1234 5678 9102 3456', 'Visa')
    INTO customers (customer_id, first, last, card_no, card_type)
        VALUES(customer_id_seq.nextval, 'Jane', 'Buck', '5555 0987 6543 2109', 'American Express')
    INTO customers (customer_id, first, last, card_no, card_type)
        VALUES(customer_id_seq.nextval, 'Frank', 'Caliendo', '2323 4578 9191 6666', 'Discover')
    INTO customers (customer_id, first, last, card_no, card_type)
        VALUES(customer_id_seq.nextval, 'Jeff', 'Smith', '1111 7878 6699 3535', 'MasterCard')
    INTO customers (customer_id, first, last, card_no, card_type)
        VALUES(customer_id_seq.nextval, 'Tory', 'Lane', '1234 6677 4455 3322', 'Visa')
SELECT * FROM dual;


-- Locations table

INSERT ALL
    INTO locations (location_id, address_line, city, state_province, zip, country)
        VALUES (location_id_seq.nextval, '123 E. Downing St.', 'London', 'Greater London', '5427', 'United Kingdom')
    INTO locations (location_id, address_line, city, state_province, zip, country)
        VALUES (location_id_seq.nextval, '2424 River Blvd.', 'Vancouver', 'British Columbia', 'V5K 0C3', 'Canada')
    INTO locations (location_id, address_line, city, state_province, zip, country)
        VALUES (location_id_seq.nextval, '555 27th St.', 'New York City', 'New York', '10004', 'United States')
    INTO locations (location_id, address_line, city, state_province, zip, country)
        VALUES (location_id_seq.nextval, '1414 Rodeo Dr.', 'Beverly Hills', 'California', '90210', 'United States')
SELECT * FROM dual;


-- Rooms table

INSERT ALL
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 1, '101', 2, 2, 'F', 100)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 1, '102', 4, 0, 'F', 125)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 1, '103', 4, 2, 'F', 140)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 1, '201', 6, 3, 'F', 175)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 1, '202', 6, 4, 'F', 200)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 2, 'A100', 2, 0, 'F', 80)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 2, 'A200', 2, 1, 'F', 90)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 2, 'A300', 4, 2, 'F', 120)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 2, 'A400', 8, 0, 'F', 140)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 2, 'A500', 6, 5, 'F', 150)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 3, '1200', 4, 2, 'F', 250)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 3, '1201', 2, 2, 'F', 180)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 3, '1202', 1, 0, 'F', 145)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 3, '1203', 6, 4, 'F', 300)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 3, '1300', 4, 2, 'F', 245)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 4, '101A', 2, 1, 'F', 160)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 4, '101B', 2, 2, 'F', 170)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 4, '201', 4, 2, 'F', 200)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 4, '202', 4, 3, 'F', 225)
    INTO rooms (room_id, location_id, room_no, fits_no_adults, fits_no_kids, is_smoking, price)
        VALUES (room_id_seq.nextval, 4, '300', 8, 5, 'F', 500)
SELECT * FROM dual;


-- Reservations table

INSERT ALL
    INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
        VALUES (reservation_id_seq.nextval, 2, 1, to_date('2019/06/01', 'yyyy/mm/dd'), to_date('2019/06/04', 'yyyy/mm/dd'), 3, 0)
    INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
        VALUES (reservation_id_seq.nextval, 9, 2, to_date('2019/06/03', 'yyyy/mm/dd'), to_date('2019/06/10', 'yyyy/mm/dd'), 6, 0)
    INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
        VALUES (reservation_id_seq.nextval, 12, 3, to_date('2019/06/02', 'yyyy/mm/dd'), to_date('2019/06/04', 'yyyy/mm/dd'), 2, 2)
    INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
        VALUES (reservation_id_seq.nextval, 20, 4, to_date('2019/06/01', 'yyyy/mm/dd'), to_date('2019/06/04', 'yyyy/mm/dd'), 6, 4)
    INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
        VALUES (reservation_id_seq.nextval, 1, 5, to_date('2019/06/12', 'yyyy/mm/dd'), to_date('2019/06/15', 'yyyy/mm/dd'), 2, 1)
    INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
        VALUES (reservation_id_seq.nextval, 7, 1, to_date('2019/06/15', 'yyyy/mm/dd'), to_date('2019/06/18', 'yyyy/mm/dd'), 2, 0)
    INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
        VALUES (reservation_id_seq.nextval, 11, 2, to_date('2019/07/05', 'yyyy/mm/dd'), to_date('2019/07/08', 'yyyy/mm/dd'), 2, 1)
    INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
        VALUES (reservation_id_seq.nextval, 16, 3, to_date('2019/06/11', 'yyyy/mm/dd'), to_date('2019/06/15', 'yyyy/mm/dd'), 1, 0)
    INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
        VALUES (reservation_id_seq.nextval, 13, 4, to_date('2019/07/15', 'yyyy/mm/dd'), to_date('2019/07/22', 'yyyy/mm/dd'), 1, 0)
    INTO reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
        VALUES (reservation_id_seq.nextval, 19, 5, to_date('2019/07/24', 'yyyy/mm/dd'), to_date('2019/07/27', 'yyyy/mm/dd'), 3, 1)
SELECT * FROM dual;