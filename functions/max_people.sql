create or replace function max_people
    (person_type varchar2(8),
    room_id_in rooms.room_id%type)
    num number(2)
    return number(2) is
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