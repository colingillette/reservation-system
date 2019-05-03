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