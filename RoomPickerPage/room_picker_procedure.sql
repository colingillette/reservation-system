create or replace procedure select_room is 
begin 
for room_row in (select room_id, location_id, room_no, price from rooms) loop
dbms_output.put_line('Room ID' || room_row.room_id);
dbms_output.put_line('Location ID' || room_row.location_id);
dbms_output.put_line('Room No' || room_row.room_no);
dbms_output.put_line('price' || room_row.price);
end loop;
end;
