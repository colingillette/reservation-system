-- Prevents duplicate inserts if the page is reloaded

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