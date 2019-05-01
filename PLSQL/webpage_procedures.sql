-- Procedure to show all locations in dropdown on createReservation.psp

create or replace procedure show_locations is
begin
    for location_row in (select location_id, city, state_province, country from locations) loop
        dbms_output.put_line('Location ID ' ||location_row.location_id);
        dbms_output.put_line('City ' ||location_row.city);
        dbms_output.put_line('State ' ||location_row.state_province);
        dbms_output.put_line('Country ' ||location_row.country);
    end loop;
end;

-- Procedure to show all reservations sorted by location, as long
-- as the depart date is later than the current one. reservationList.psp

create or replace procedure show_current_reservations is
    cursor location_cursor is
    select location_id, city, state_province, country from locations;
    location_row location_cursor%rowtype;
begin
    for location_row in location_cursor
    loop
        dbms_output.put_line(location_row.city || ', ' || location_row.state_province || ' ' || location_row.country);
        dbms_output.put_line('Customer Name' || CHR(9) || 'Room Number' || CHR(9) || 'Cost Per Night' || CHR(9) || 'Arrival Date' || CHR(9) || 'Departure Date');
        for reservation in (select first, last, room_no, price, arrive_date, depart_date
                            from customers, rooms, reservations, locations
                            where customers.customer_id = reservations.customer_id 
                                AND rooms.room_id = reservations.room_id 
                                AND locations.location_id = rooms.location_id
                                AND location_id = location_row.location_id
                                AND depart_date > sysdate
                            order by arrive_date)
        loop
            dbms_output.put_line(reservation.first || ' ' reservation.last || CHR(9) || reservation.room_no || CHR(9) || reservation.price || CHR(9) || reservation.arrive_date || CHR(9) || reservation.depart_date);
        endloop;
    end loop;
end;

-- Procedure to show the details of a selected reservation. editReservation.psp

create or replace procedure show_reservation is
    reservation_id_in reservations.reservation_id%type;
    first_text customers.first%type;
    last_text customers.last%type;
    card_no_text customers.card_no%type;
    adults_text reservations.adults%type;
    kids_text reservations.kids%type;
    room_no_text rooms.room_no%type;
    city_text locations.city%type;
    state_text locations.state_province%type;
    country_text locations.country%type;
    arrive_date_text reservations.arrive_date%type;
    depart_date_text reservations.depart_date%type;
begin
    select reservation_id, first, last, card_no, adults, kids, room_no city, state_province, country, arrive_date, depart_date
    into reservation_id_in, first_text, last_text, card_no_text, adults_text, kids_text, room_no_text, city_text, state_text, country_text, arrive_date_text, depart_date_text
    from reservations, customers, locations, rooms
    where reservation_id = reservation_id_in
        AND rooms.room_id = reservation.room_id
        AND rooms.location_id = locations.location_id
        AND customers.customer_id = reservations.customer_id;
    dbms_output.put_line('Reservation Number: ' || reservation_id_in);
    dbms_output.put_line('Room Number: ' || room_no_text);
    dbms_output.put_line('Name: ' || first_text || ' ' || last_text);
    dbms_output.put_line(adults_text || ' Adults and ' || kids_text || ' kids.');
    dbms_output.put_line('Location: ' || city_text || ', ' || state_text || ' ' || country_text);
    dbms_output.put_line('Dates of stay: ' || arrive_date_text || ' - ' || depart_date_text);
end;