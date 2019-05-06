create or replace procedure delete_reservation
    (reservation_id_in number,
    submit varchar2) is
begin
    delete from reservations
    where reservation_id = reservation_id_in;
end;