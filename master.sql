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
    card_no char(16) NOT NULL,
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
    VALUES(customer_id_seq.nextval, 'John', 'Doe', '1234567891023456', 'Visa');
INSERT INTO customers (customer_id, first, last, card_no, card_type)
    VALUES(customer_id_seq.nextval, 'Jane', 'Buck', '5555098765432109', 'American Express');
INSERT INTO customers (customer_id, first, last, card_no, card_type)
    VALUES(customer_id_seq.nextval, 'Frank', 'Caliendo', '2323457891916666', 'Discover');
INSERT INTO customers (customer_id, first, last, card_no, card_type)
    VALUES(customer_id_seq.nextval, 'Jeff', 'Smith', '1111787866993535', 'MasterCard');
INSERT INTO customers (customer_id, first, last, card_no, card_type)
    VALUES(customer_id_seq.nextval, 'Tory', 'Lane', '1234667744553322', 'Visa');



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

-- Run this to create all functions at once

create or replace function check_for_customer
    (first_name_in IN customers.first%type,
    last_name_in IN customers.last%type,
    card_no_in IN customers.card_no%type,
    card_type_in IN customers.card_type%type)
    return boolean is
    cursor customer_cursor is
        select first, last, card_no, card_type
        from customers;
    customer_row customer_cursor%rowtype;
begin
    for customer_row in customer_cursor
    loop
        if customer_row.first = first_name_in and customer_row.last = last_name_in and customer_row.card_no = card_no_in and customer_row.card_type = card_type_in then
            return true;
        end if;
    end loop;

    return false;
end;
/

create or replace function get_customer_id
    (first_name_in IN customers.first%type,
    last_name_in IN customers.last%type,
    card_no_in IN customers.card_no%type,
    card_type_in IN customers.card_type%type)
    return number is
    customer_id_text customers.customer_id%type;
begin
    select customer_id
    into customer_id_text
    from customers
    where first = first_name_in
        and last = last_name_in
        and card_no = card_no_in
        and card_type = card_type_in;
    
    return customer_id_text;
end;
/

-- Out of some stroke of genius I apparently had, this returns true if the dates do not conlfict.

create or replace function get_date_conflicts
    (room_id_in IN rooms.room_id%type,
    arrival_in IN reservations.arrive_date%type,
    depart_in IN reservations.depart_date%type)
    return boolean is
begin
    for reservation in (select arrive_date, depart_date from reservations where room_id = room_id_in)
        loop
            if (reservation.arrive_date < arrival_in and reservation.depart_date > arrival_in) 
                or (reservation.arrive_date < depart_in and reservation.depart_date > depart_in)
                or (arrival_in < reservation.arrive_date and depart_in > reservation.depart_date) then
                    return false;
            end if;
        end loop;
    return true;
end;
/

create or replace function get_room_number
    (room_id_in rooms.room_id%type)
    return rooms.room_no%type is
    room_no_text rooms.room_no%type;
begin
    select room_no
    into room_no_text
    from rooms
    where room_id = room_id_in;

    return room_no_text;
end;
/

create or replace function max_people
    (person_type varchar2,
    room_id_in rooms.room_id%type)
    return number is
    num number(2);
begin
    if person_type = 'adults' then
        select fits_no_adults
        into num
        from rooms
        where room_id = room_id_in;
    else
        select fits_no_adults
        into num
        from rooms
        where room_id = room_id_in;
    end if;

    return num;
end;
/

create or replace procedure home_page is
begin
  htp.print('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
  <html>
      <head>
          <title>Hotel Reservation System</title>
      </head>
      <div style="text-align:center;">
        <head><a href="create_new_reservation" style="margin-right: 3em;">Create Reservation</a></head>
        <head><a href="home_page" style="margin-right: 3em;">Home</a></head>
        <head><a href="show_current_reservations">Administration</a></head>
    </div>
  <title>Example Hotel Company</title>
  <body>
      <div style="text-align: center;">
          <h1>Example Hotel Company</h1>
          <p>
            <h2>We are a chain of small hotels in big locations.</h2>
            
            You can find us in London, Beverly Hills, New York, and Vancouver! Use the navigations bar above to either create a
            reservation, or edit and delete existing ones.
          </p>
      </div>
  </body>
  </html>');
end;
/

create or replace procedure Create_New_Reservation as 
    cursor location_cursor is 
        select city
        from locations;
    location_row location_cursor%rowtype;
begin 
htp.print('<!DOCTYPE HTML PUBLIC"-//W#C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <link rel="stylesheet" href="index.css">
    </head>
    <div style="text-align:center;">
        <head><a href="create_new_reservation" style="margin-right: 3em;">Create Reservation</a></head>
        <head><a href="home_page" style="margin-right: 3em;">Home</a></head>
        <head><a href="show_current_reservations">Administration</a></head>
    </div>
    <hr>
<title align>Create Reservation</title>
<body>
    <h1 style="text-align:center">Create Reservation</h1>
    <script>
          function amexnumber(cardnumber) {
    var cardno = /^(?:3[47][0-9]{13})$/;
    if (!cardnumber.value.match(cardno)) {
        alert("Not a valid American Express card number!");
        return false;
    }
}

function visanumber(cardnumber) {
    var cardno = /^(?:4[0-9]{12}(?:[0-9]{3})?)$/;
    if (!cardnumber.value.match(cardno)) {
        alert("Not a valid Visa credit card number!");
        return false;
    }
}
function masternumber(cardnumber) {
    var cardno = /^(?:5[1-5][0-9]{14})$/;
    if (!cardnumber.value.match(cardno)) {
        alert("Not a valid Master card number!");
        return false;
    }
}
function discovernumber(cardnumber) {
    var cardno = /^(?:6(?:011|5[0-9][0-9])[0-9]{12})$/;
    if (!cardnumber.value.match(cardno)) {
        alert("Not a valid Discover card number!");
        return false;
    }
}
        </script>
        <script>
        function checkcard(){
        var selectedtyp = document.getElementById("selecttype").value;
        var cardnumer = document.form1.cardnum;
        if (selectedtyp === "American Express"){
        return amexnumber(cardnumer);
        }else if(selectedtyp === "MasterCard"){
        return masternumber(cardnumer);
        } else if (selectedtyp ==="Discover"){
        return discovernumber(cardnumer);
        }else{
        return visanumber(cardnumer);
        }
        }
      </script>

    <form action="room_picker" method="post" align="center" name ="form1" id ="form1" onsubmit="return checkcard()">
        First Name:
        <input type="text" name="first_name_in" style="margin-top:20px"><br>
        Last Name:
        <input type="text" name="last_name_in" style="margin-top:15px"><br>
        Number of Adults:
        <select style="margin-top: 15px" name="adults_in">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
        </select><br>
        Number of children:
        <select style="margin-top: 15px" name="children_in">
            <option value="0">0</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
        </select><br>
        Arrival Date:
        <input type="date" name="arrival_in" id="arrival_in" style="margin-top: 15px"><br>
        <script>
        var today = new Date().toISOString().split("T")[0];
    document.getElementsByName("arrival_in")[0].setAttribute("min", today);
        </script>
        Departure Date:
        <input type="date" name="depart_in" style="margin-top: 15px"><br>
        <script>
        var today = new Date().toISOString().split("T")[0];
    document.getElementsByName("depart_in")[0].setAttribute("min", today);
        </script>
        Location:
        <select style="margin-top:15px" name="city_in"> ');
            for location_row in location_cursor
            loop
                htp.prn('<option value="'||location_row.city||'">'||location_row.city||'</option>');
            end loop;
        htp.print('</select><br>
        Card Number:
        <input type="text" name="card_number_in" id ="cardnum" style="margin-top: 15px" placeholder="1234567891012345"><br>
        Card Company:
        <select style="margin-top:15px;margin-bottom:15px;" name="card_company_name_in" id ="selecttype">
            <option value="Visa">Visa</option>
            <option value="MasterCard">MasterCard</option>
            <option value="Discover">Discover</option>
            <option value="American Express">American Express</option>
        </select><br>
        <input type="submit" name="submit_button_in" value="Proceed"/>
     </form>
    
    <p style="text-align:center;">Valid card numbers for each company start with these numbers:</p>
    <div align="center">
        <table>
            <tr>
                <th>Card Company</th>
                <th>Starts With</th>
            </tr>
            <tr>
                <td>American Express</td>
                <td>3</td>
            </tr>
            <tr>
                <td>Visa</td>
                <td>4</td>
            </tr>
            <tr>
                <td>Mastercard</td>
                <td>5</td>
            </tr>
            <tr>
                <td>Discover</td>
                <td>6</td>
            </tr>
        </table>
    </div>
</body>
</html>
');
exception
when others then
htp.prn(sqlerrm);
end;
/

create or replace procedure create_customer
    (first_in customers.first%type,
    last_in customers.last%type,
    card_no_in customers.card_no%type,
    card_type_in customers.card_type%type) is
begin
    insert into customers (customer_id, first, last, card_no, card_type)
        values (customer_id_seq.nextval, first_in, last_in, card_no_in, card_type_in);
    commit;
end;
/

create or replace procedure room_picker
    (first_name_in varchar2,
    last_name_in varchar2,
    adults_in number,
    children_in number,
    arrival_in varchar2,
    depart_in varchar2,
    city_in varchar2,
    card_number_in varchar2,
    card_company_name_in varchar2,
    submit_button_in varchar2) IS
    room_no_text rooms.room_no%type;
    cursor room_cursor is
        select r.room_id, r.room_no, r.is_smoking, to_char(r.price, '$999.99') as price, r.fits_no_adults, r.fits_no_kids
        from rooms r, locations l
        where r.location_id = l.location_id
            and l.city = city_in;
    room_row room_cursor%rowtype;
    room_good boolean;
    arrival_in_date reservations.arrive_date%type;
    depart_in_date reservations.depart_date%type;
begin
    if check_for_customer(first_name_in, last_name_in, card_number_in, card_company_name_in) = false then
        create_customer(first_name_in, last_name_in, card_number_in, card_company_name_in);
    end if;
    
    arrival_in_date := to_date(arrival_in, 'yyyy/mm/dd');
    depart_in_date := to_date(depart_in, 'yyyy/mm/dd');

    htp.prn('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
    <head>
        <title>Room Selection</title>
        <div style="text-align:center;">
            <head><a href="create_new_reservation" style="margin-right: 3em;">Create Reservation</a></head>
            <head><a href="home_page" style="margin-right: 3em;">Home</a></head>
            <head><a href="show_current_reservations">Administration</a></head></div>
    </head>
    <body>
        <div align="center"><p><h2>Example Rooms</h2></p>
           
        <hr /></div>
        <!-- Start Page Content -->
        <form action="new_reservation" method="post" align="center">
            <p align="center"><b>Rooms Available</b></p> ');
            
             for room_row in room_cursor
             loop
                room_good := true;
        
                room_good := get_date_conflicts(room_row.room_id, arrival_in_date, depart_in_date);
                
                if room_row.fits_no_adults < adults_in or room_row.fits_no_kids < children_in then
                    room_good := false;
                end if;
                
                if room_good then
                    htp.prn('<input type="radio" name="room_id_in" value="'||room_row.room_id||'"> 
                        Room '||room_row.room_no||' ');
                        if room_row.is_smoking = 'T' then
                            htp.prn('Smoking ');
                        else
                            htp.prn('Non-Smoking ');
                        end if;
                        htp.prn('Price: '||room_row.price||' per night
                    <br>');
                end if;
             end loop;
             
             htp.prn('<input type="hidden" name="first_name_in" value="'||first_name_in||'">
                <input type="hidden" name="last_name_in" value="'||last_name_in||'">
                <input type="hidden" name="adults_in" value="'||adults_in||'">
                <input type="hidden" name="children_in" value="'||children_in||'">
                <input type="hidden" name="arrival_in" value="'||arrival_in_date||'">
                <input type="hidden" name="depart_in" value="'||depart_in_date||'">
                <input type="hidden" name="city_in" value="'||city_in||'">
                <input type="hidden" name="card_number_in" value="'||card_number_in||'">
                <input type="hidden" name="card_company_name_in" value="'||card_company_name_in||'">');
            
            htp.prn('<br /><br />
            <input type="submit" name="submit_button_in" value="Select Room"/>
        </form>
    <!-- End Page Content -->
    </body>
    </html>
    ');
    exception
    when others then
    htp.prn(sqlerrm);
end;
/

create or replace procedure new_reservation 
    (first_name_in varchar2,
    last_name_in varchar2,
    adults_in number,
    children_in number,
    arrival_in varchar2,
    depart_in varchar2,
    city_in varchar2,
    card_number_in varchar2,
    card_company_name_in varchar2,
    room_id_in number,
    submit_button_in varchar2) IS
        location_id_text locations.location_id%type;
        customer_id_text customers.customer_id%type;
        room_no_text rooms.room_no%type;
        arrival_in_date reservations.arrive_date%type;
        depart_in_date reservations.depart_date%type;
begin 
    customer_id_text := get_customer_id(first_name_in, last_name_in, card_number_in, card_company_name_in);

    room_no_text := get_room_number(room_id_in);
    
    insert into reservations (reservation_id, room_id, customer_id, arrive_date, depart_date, adults, kids)
        values (reservation_id_seq.nextval, room_id_in, customer_id_text, arrival_in, depart_in, adults_in, children_in);
    
    arrival_in_date := to_date(arrival_in, 'yyyy/mm/dd');
    depart_in_date := to_date(depart_in, 'yyyy/mm/dd');
    
    htp.print('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
    <head>
        <title>New Reservations Created</title>
        <div style="text-align:center;">
            <head><a href="create_new_reservation" style="margin-right: 3em;">Create Reservation</a></head>
            <head><a href="home_page" style="margin-right: 3em;">Home</a></head>
            <head><a href="show_current_reservations">Administration</a></head></div>
    </head>
    <body>
        <div align="center"><p><h2>Reservations</h2>
        <hr /></div>
        <br> <!-- Start Page Content -->
        <div align="center">
            <p><b>Your Reservation</b></p>
            <table border="0" cellpadding="1" cellspacing="1" summary="">
                <tr></tr>
                <tr><td>Full Name:</td><td>'||first_name_in||' '||last_name_in||'</td></tr>
                <tr><td>Reservation ID:</td><td>'||reservation_id_seq.currval||'</td></tr>
                <tr><td>Arrival Date:</td><td>'||arrival_in||'</td></tr>
                <tr><td>Depart Date:</td><td>'||depart_in||'</td></tr>
                <tr><td>Reservation Location:</td><td>'||city_in||' Room '||room_no_text||'</td></tr>
                <tr><td>Adults</td><td>'||adults_in||'</td></tr>
                <tr><td>Kids</td><td>'||children_in||'</td></tr>
            </table>
            ');
        htp.prn('</div>
        <!-- End Page Content -->
    </body>
    </html>
    ');
    exception
    when others then
    htp.prn(sqlerrm);
end;
/

create or replace procedure show_current_reservations as
    cursor location_cursor is
    select location_id, city, state_province, country from locations;
    location_row location_cursor%rowtype;
begin
    htp.print('<!DOCTYPE html PUBLIC"-//W#C//DTD HTML 4.01 Transitional//EN">
    <html>
        <head>
            <title>Reservation List</title>
            <link rel="stylesheet" href="index.css">
            <div style="text-align:center;">
                <head><a href="create_new_reservation" style="margin-right: 3em;">Create Reservation</a></head>
                <head><a href="home_page" style="margin-right: 3em;">Home</a></head>
                <head><a href="show_current_reservations">Administration</a></head>
            </div>
        </head>
        <hr>
        <body>
            <h1 style="text-align:center;">Current Reservations</h1>
            <form action="edit_reservation" method="post">');
                for location_row in location_cursor
                loop
                    
                    htp.print('<section>
                        <h3>'||location_row.city||'</h3>
                        <table>
                            <tr>
                                <th></th>
                                <th>Customer Name</th>
                                <th>Room Number</th>
                                <th>Price per Night</th>
                                <th>Arrival Date</th>
                                <th>Departure Date</th>
                            </tr>');
                            for reservation in (select reservation_id, first, last, room_no, price, arrive_date, depart_date
                                                from customers, rooms, reservations, locations
                                                where customers.customer_id = reservations.customer_id 
                                                    AND rooms.room_id = reservations.room_id 
                                                    AND locations.location_id = rooms.location_id
                                                    AND locations.location_id = location_row.location_id
                                                    AND depart_date > sysdate
                                                order by arrive_date)
                            loop
                                htp.prn('<tr><td><input type="radio" name="reservation_id_in" value="'||reservation.reservation_id||'"></td>');
                                htp.prn('<td>'||reservation.first||' '||reservation.last||'</td>');
                                htp.prn('<td>'||reservation.room_no||'</td>');
                                htp.prn('<td>'||reservation.price||'</td>');
                                htp.prn('<td>'||reservation.arrive_date||'</td>');
                                htp.prn('<td>'||reservation.depart_date||'</td></tr>');
                            end loop;
                        htp.print('</table>
                    </section>');

                end loop;
                
                htp.print('<input type="submit" value="Submit" name="submit" style="font-size: 20px; background-color:darkgrey; margin-left: 47%;">
            </form>
        </body>
    </html>');
end;
/

create or replace procedure edit_reservation
    (reservation_id_in number,
    submit varchar2) is
    customer_id_text customers.customer_id%type;
    first_text customers.first%type;
    last_text customers.last%type;
    card_no_text customers.card_no%type;
    card_type_text customers.card_type%type;
    arrive_date_text reservations.arrive_date%type;
    depart_date_text reservations.depart_date%type;
    adults_text reservations.adults%type;
    kids_text reservations.kids%type;
    city_text locations.city%type;
    room_id_text rooms.room_id%type;
    room_no_text rooms.room_no%type;
    price_text varchar2(30);
    max_adults rooms.fits_no_adults%type;
    max_kids rooms.fits_no_kids%type;
    counter1 reservations.adults%type;
    counter2 reservations.kids%type;
begin
    select c.customer_id, c.first, c.last, c.card_no, c.card_type, re.arrive_date, re.depart_date, re.adults, re.kids, l.city, ro.room_id, ro.room_no, to_char(ro.price, '$999.99')
    into customer_id_text, first_text, last_text, card_no_text, card_type_text, arrive_date_text, depart_date_text, adults_text, kids_text, city_text, room_id_text, room_no_text, price_text
    from customers c, locations l, rooms ro, reservations re
    where c.customer_id = re.customer_id
        and ro.room_id = re.room_id
        and l.location_id = ro.location_id
        and re.reservation_id = reservation_id_in;

    max_adults := max_people('adults', room_id_text);
    max_kids := max_people('kids', room_id_text);
    
    counter1 := 1;
    counter2 := 0;
    
    htp.print('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
    <head>
        <title>Edit Reservation</title>
        <div style="text-align:center;">
            <head><a href="create_new_reservation" style="margin-right: 3em;">Create Reservation</a></head>
            <head><a href="home_page" style="margin-right: 3em;">Home</a></head>
            <head><a href="show_current_reservations">Administration</a></head>
        </div>
    </head>
    <body>
        <div align="center"><p><h2>Reservations</h2>
        <hr /></div>
        <br> <!-- Start Page Content -->
        <div align="center">
            <h1>Edit Reservation</h1> 
            
            <section><section>');
                htp.prn('<p style="text-align: center;">Reservation number: <b>'||reservation_id_in||'</b></p>');
                htp.prn('<p><b>'||city_text||'</b>: Room '||room_no_text||' priced at '||price_text||' per night.</p>');
                htp.print('<form action="edit_reservation_response" method="post">
                    First Name: <input type="text" name="first_name_in" value="'||first_text||'"><br>
                    Last Name: <input type="text" name="last_name_in" value="'||last_text||'"><br><br>
                    Card Information: <input type="text" name="card_number_in" value="'||card_no_text||'"> <select name="card_type_in">');
                        if card_type_text = 'Visa' then
                            htp.prn('<option value="Visa" selected="selected">Visa</option>'); 
                        else 
                            htp.prn('<option value="Visa">Visa</option>');
                        end if;
                        if card_type_text = 'MasterCard' then
                            htp.prn('<option value="MasterCard" selected="selected">MasterCard</option>'); 
                        else 
                            htp.prn('<option value="MasterCard">MasterCard</option>');
                        end if;
                        if card_type_text = 'Discover' then
                            htp.prn('<option value="Discover" selected="selected">Discover</option>'); 
                        else 
                            htp.prn('<option value="Discover">Discover</option>');
                        end if;
                        if card_type_text = 'American Express' then
                            htp.prn('<option value="American Express" selected="selected">American Express</option>'); 
                        else 
                            htp.prn('<option value="American Express">American Express</option>');
                        end if;
                    htp.print('</select><br><br>
                    <p>Current Dates of Stay: '||arrive_date_text||' - '||depart_date_text||'</p>
                    Arrival Date: <input type="date" name="arrival_date_in"><br>
                              <script>
                    var today = new Date().toISOString().split("T")[0];
                document.getElementsByName("arrival_date_in")[0].setAttribute("min", today);
                    </script>
                    Depart Date: <input type="date" name="depart_date_in"><br><br>
                              <script>
                    var today = new Date().toISOString().split("T")[0];
                document.getElementsByName("depart_date_in")[0].setAttribute("min", today);
                    </script>
                    Adults: <select name="adults_in">');
                        for counter1 in 1..max_adults
                        loop
                            if counter1 = adults_text then
                                htp.prn('<option value="'||counter1||'" selected="selected">'||counter1||'</option>');
                            else
                                htp.prn('<option value="'||counter1||'">'||counter1||'</option>');
                            end if;
                        end loop;
                    htp.print('</select><br>
                    Children: <select name="children_in">');
                        for counter2 in 0..max_kids
                        loop
                            if counter2 = kids_text then
                                htp.prn('<option value="'||counter2||'" selected="selected">'||counter2||'</option>');
                            else
                                htp.prn('<option value="'||counter2||'">'||counter2||'</option>');
                            end if;
                        end loop;
                    htp.print('</select><br><br>
                    <input type="hidden" name="reservation_id_in" value="'||reservation_id_in||'">
                    <input type="hidden" name="customer_id_in" value="'||customer_id_text||'">
                    <input type="hidden" name="room_id_in" value="'||room_id_text||'">
                    <input type="submit" name="submit" value="Submit Edits">
                </form>');
                htp.print('<form action="delete_reservation" method="post">
                    <input type="hidden" name="reservation_id_in" value="'||reservation_id_in||'">
                    <input type="submit" name="submit" value="Delete Reservation">
                </form>
                ');
            htp.print('</section></section>
        </div>
    </body>
    </html>
    ');
    exception
    when others then
    htp.prn(sqlerrm);
end;
/

create or replace procedure edit_reservation_response
    (first_name_in varchar2 default null,
    last_name_in varchar2 default null,
    card_number_in varchar2 default null,
    card_type_in varchar2 default null,
    arrival_date_in varchar2 default null,
    depart_date_in varchar2 default null,
    adults_in number default null,
    children_in number default null,
    reservation_id_in number default null,
    customer_id_in number default null,
    room_id_in number default null,
    submit varchar2 default null) is
        arrival_text reservations.arrive_date%type;
        depart_text reservations.depart_date%type;
        previous_arrival reservations.arrive_date%type;
        previous_depart reservations.depart_Date%type;
        previous_adults reservations.adults%type;
        previous_kids reservations.kids%type;
begin
    select arrive_date, depart_date, adults, kids
    into previous_arrival, previous_depart, previous_adults, previous_kids
    from reservations
    where reservation_id = reservation_id_in;

    update customers 
    set first = first_name_in, last = last_name_in, card_no = card_number_in, card_type = card_type_in
    where customer_id = customer_id_in;

    arrival_text := to_date(arrival_date_in, 'yyyy/mm/dd');
    depart_text := to_date(depart_date_in, 'yyyy/mm/dd');

    htp.print('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
    <html>
    <head>
        <title>Reservation Edited</title>
        <div style="text-align:center;">
            <head><a href="create_new_reservation" style="margin-right: 3em;">Create Reservation</a></head>
            <head><a href="home_page" style="margin-right: 3em;">Home</a></head>
            <head><a href="show_current_reservations">Administration</a></head>
        </div>
    </head>
    <body>
        <div align="center"><p><h2>Reservation Edited</h2>
            <br />
        <hr /></div>
        <br> <!-- Start Page Content -->
        <div align="center">
            <p>The following Customer information has been saved for Reservation '||reservation_id_in||'</p>
            <table border="0" cellpadding="1" cellspacing="1" summary="">
                <tr><td>Full Name:</td><td>'||first_name_in||' '||last_name_in||'</td></tr>
                <tr><td>Card Number:</td><td>'||card_number_in||'</td></tr>
                <tr><td>Card Company:</td><td>'||card_type_in||'</td></tr>
            </table>');
    if arrival_text = previous_arrival and depart_text = previous_depart and adults_in = previous_adults and children_in = previous_kids then
        htp.print('<p>No changes were made to the reservation.</p>');
        htp.print('<table border="0" cellpadding="1" cellspacing="1" summary="">
                    <tr><td>Number of Adults:</td><td>'||adults_in||'</td></tr>
                    <tr><td>Number of Kids:</td><td>'||children_in||'</td></tr>
                    <tr><td>Arrive Date:</td><td>'||arrival_date_in||'</td></tr>
                    <tr><td>Depart Date:</td><td>'||depart_date_in||'</td></tr>
                </table>');
    else
        if get_date_conflicts(room_id_in, arrival_text, depart_text) then
            update reservations
            set arrive_date = arrival_text, depart_date = depart_text, adults = adults_in, kids = children_in
            where reservation_id = reservation_id_in;
            
            htp.print('<p>The following Reservation information has been updated and saved for Reservation '||reservation_id_in||'</p>
                <table border="0" cellpadding="1" cellspacing="1" summary="">
                    <tr><td>Number of Adults:</td><td>'||adults_in||'</td></tr>
                    <tr><td>Number of Kids:</td><td>'||children_in||'</td></tr>
                    <tr><td>Arrive Date:</td><td>'||arrival_date_in||'</td></tr>
                    <tr><td>Depart Date:</td><td>'||depart_date_in||'</td></tr>
                </table>');
            
        else
            htp.prn('Thinks stuff is: '||room_id_in||' '||arrival_text||' - '||depart_text||' ');
            htp.print('<p>While we could save any changes to the customer, there was a conflict with that room on 
                        the selected dates. You will have to delete this reservation and complete a new one in 
                        a different room if you require these dates.</p>');
        end if;
    end if;
    
    htp.print('</div>
        </body>
    </html>');
    
    exception
    when others then
    htp.prn(sqlerrm);
end;
/

create or replace procedure delete_reservation
    (reservation_id_in number,
    submit varchar2) is
begin
    delete from reservations
    where reservation_id = reservation_id_in;
    
    htp.print('<!DOCTYPE HTML PUBLIC"-//W#C//DTD HTML 4.01 Transitional//EN">
    <html>
        <head>
            <link rel="stylesheet" href="index.css">
        </head>
        <div style="text-align:center;">
            <head><a href="create_new_reservation" style="margin-right: 3em;">Create Reservation</a></head>
            <head><a href="home_page" style="margin-right: 3em;">Home</a></head>
            <head><a href="show_current_reservations">Administration</a></head>
        </div>
        <hr>
    <title align>Reservation Deleted</title>
    <body>
        <h1 style="text-align:center">Reservation Deleted</h1>
        <p style="text-align:center">
            This represents confirmation that Reservation <b>'||reservation_id_in||'</b> has been deleted. Please use the
            navigation buttons above to go to another page.
        </p>
    </body>
    </html>');
end;
/

create or replace trigger prevent_duplicate_res_insert
before insert
on reservations
for each row
declare
    cursor reservation_cursor is
    select room_id, arrive_date, depart_date
    from reservations;
    reservation_row reservation_cursor%rowtype;
begin
    for reservation_row in reservation_cursor
    loop
        if :new.room_id = reservation_row.room_id 
            and :new.arrive_date = reservation_row.arrive_date
            and :new.depart_date = reservation_row.depart_date then

            raise_application_error(-20000, 'cannot create duplicate version of reservation');
        end if;
    end loop;
end;
/