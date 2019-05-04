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