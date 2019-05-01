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