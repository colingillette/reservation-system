-- Procedure to show all locations in dropdown on createReservation.psp

create or replace procedure show_locations is
begin
    for location_row in (select location_id, city, state, country from locations) loop
        dbms_output.put_line('Location ID ' ||location_row.location_id);
        dbms_output.put_line('City ' ||location_row.city);
        dbms_output.put_line('State ' ||location_row.state);
        dbms_output.put_line('Country ' ||location_row.country);
    end loop;
end;