create or replace procedure create_reservation is
    cursor location_cursor is 
        select city
        from locations;
    location_row location_cursor%rowtype;
begin
    for location_row in location_cursor
    loop
        dbms_output.put_line('Location Info: ' || location_row.city);
    end loop;
end;